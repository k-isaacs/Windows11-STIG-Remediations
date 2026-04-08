<#
.SYNOPSIS
    Configures Windows 11 to enable Structured Exception Handling Overwrite Protection (SEHOP) to meet STIG WN11-00-000150.
    Please test thoroughly in a non-production environment before deploying widely.
    Make sure to run as Administrator or with appropriate privileges.

.NOTES
    Author          : Keisha Isaacs
    Date Created    : 2026-04-07
    Last Modified   : 2026-04-07
    Version         : 1.0
    STIG ID         : WN11-00-000150
    STIG Page       : https://stigaview.com/products/win11/v2r5/WN11-00-000150/
    Note            : Scripts validated against DISA Windows 11 STIG v2r6 audit file in Tenable; v2r6 is not available on STIG-A-View, so v2r5 reference is used for documentation purposes only.

.TESTED ON
    Date(s) Tested  : 2026-04-07
    Tested By       : Keisha Isaacs
    Systems Tested  : Windows 11 Pro, x64, Gen 2 VM
    PowerShell Ver. : 5.1+

.USAGE
    Set [$makeCompliant = $true] to remediate the STIG.
    Example syntax:
    PS C:\> .\WN11-00-000150.ps1
#>

# Variable to determine if we want to make the computer compliant
$makeCompliant = $true

# Required STIG setting
$policyPath = 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\kernel'
$policyName = 'DisableExceptionChainValidation'
$requiredValue = 0

# Check if the script is run as Administrator
function Check-Admin {
    $identity = [System.Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = New-Object System.Security.Principal.WindowsPrincipal($identity)
    $principal.IsInRole([System.Security.Principal.WindowsBuiltInRole]::Administrator)
}

# Main script
if (-not (Check-Admin)) {
    Write-Error "Access Denied. Please run with Administrator privileges."
    exit 1
}

# Pre-check
try {
    $configuredValue = (Get-ItemProperty -Path $policyPath -Name $policyName -ErrorAction Stop).$policyName
} catch {
    $configuredValue = $null
}

if ($configuredValue -eq $requiredValue) {
    Write-Host "COMPLIANT"
    Write-Host "Registry ${policyName}: $configuredValue"
    exit 0
}

# Remediation
if ($makeCompliant) {
    if (-not (Test-Path $policyPath)) {
        New-Item -Path $policyPath -Force | Out-Null
    }

    New-ItemProperty -Path $policyPath -Name $policyName -PropertyType DWord -Value $requiredValue -Force | Out-Null
    Write-Host "SEHOP registry setting has been configured."
} else {
    Write-Host "NOT COMPLIANT"
    Write-Host "No changes made because `$makeCompliant is set to false."
    exit 1
}

# Post-check
try {
    $configuredValue = (Get-ItemProperty -Path $policyPath -Name $policyName -ErrorAction Stop).$policyName

    if ($configuredValue -eq $requiredValue) {
        Write-Host "COMPLIANT"
        Write-Host "Registry ${policyName}: $configuredValue"
        exit 0
    } else {
        Write-Host "NOT COMPLIANT"
        Write-Host "Registry ${policyName}: $configuredValue"
        exit 1
    }
}
catch {
    Write-Host "NOT COMPLIANT"
    Write-Host "Registry value not found or could not be read."
    exit 1
}
