# Windows11-STIG-Remediations

PowerShell scripts for DISA STIG remediation on Windows 11. Developed during a cybersecurity internship using a live Azure VM and Tenable for validation.

## Environment

- **OS:** Windows 11 Pro, x64, Gen 2 VM (Azure)
- **STIG Audit:** DISA Windows 11 STIG v2r6 (Tenable)
- **Reference:** STIG-A-View v2r5 (v2r6 not available at time of documentation)
- **PowerShell:** 5.1+

## STIG Remediations

| # | STIG ID | Description | Severity |
|---|---------|-------------|----------|
| 1 | WN11-AU-000500 | The Application event log size must be configured to 32768 KB or greater | CAT II |
| 2 | WN11-AU-000505 | The Security event log size must be configured to 1024000 KB or greater | CAT II |
| 3 | WN11-AU-000510 | The System event log size must be configured to 32768 KB or greater | CAT II |
| 4 | WN11-CC-000005 | Camera access from the lock screen must be disabled | CAT II |
| 5 | WN11-CC-000190 | Autoplay must be disabled for all drives | CAT II |
| 6 | WN11-CC-000185 | The default autorun behavior must be configured to prevent autorun commands | CAT II |
| 7 | WN11-CC-000210 | The Microsoft Defender SmartScreen for Explorer must be enabled | CAT II |
| 8 | WN11-00-000150 | Structured Exception Handling Overwrite Protection (SEHOP) must be enabled | CAT I |
| 9 | WN11-CC-000038 | WDigest Authentication must be disabled | CAT II |
| 10 | WN11-SO-000167 | Remote calls to the Security Account Manager (SAM) must be restricted to Administrators | CAT II |

## Methodology

1. Baseline scan in Tenable to identify failing STIGs
2. Manual registry fix applied and verified via rescan
3. Manual fix reverted and failure confirmed via rescan
4. PowerShell script written to automate the same fix
5. Script executed and passing scan confirmed
6. Script pushed to GitHub

## Repository Structure

Each STIG has its own folder named by STIG ID containing the `.ps1` remediation script.

## Notes

- Scripts include pre-check, remediation, and post-check logic
- All scripts require Administrator privileges
- Tested on a standalone (non-domain) Azure VM
