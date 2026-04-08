# 🛡️ Windows 11 STIG Remediations

> PowerShell remediation scripts for DISA Windows 11 STIG compliance, developed and validated during a cybersecurity internship using Microsoft Azure and Tenable Vulnerability Management.

---

## 📋 Overview

This repository contains PowerShell scripts that automate the remediation of failed DISA STIG controls on Windows 11. Each script was developed using a structured methodology: manual identification, manual remediation, reversion to failure state, PowerShell automation, and Tenable rescan validation.

---

## 🖥️ Environment

| Field | Details |
|-------|---------|
| Operating System | Windows 11 Pro, x64, Gen 2 VM (Azure) |
| STIG Audit File | DISA Windows 11 STIG v2r6 (Tenable) |
| Documentation Reference | STIG-A-View v2r5 (v2r6 unavailable at time of writing) |
| PowerShell Version | 5.1+ |
| Scan Tool | Tenable Vulnerability Management |

---

## 📁 Remediations

| # | STIG ID | Description | Severity |
|---|---------|-------------|----------|
| 1 | [WN11-AU-000500](./WN11-AU-000500/WN11-AU-000500.ps1) | The Application event log size must be configured to 32768 KB or greater | CAT II |
| 2 | [WN11-AU-000505](./WN11-AU-000505/WN11-AU-000505.ps1) | The Security event log size must be configured to 1024000 KB or greater | CAT II |
| 3 | [WN11-AU-000510](./WN11-AU-000510/WN11-AU-000510.ps1) | The System event log size must be configured to 32768 KB or greater | CAT II |
| 4 | [WN11-CC-000005](./WN11-CC-000005/WN11-CC-000005.ps1) | Camera access from the lock screen must be disabled | CAT II |
| 5 | [WN11-CC-000190](./WN11-CC-000190/WN11-CC-000190.ps1) | Autoplay must be disabled for all drives | CAT II |
| 6 | [WN11-CC-000185](./WN11-CC-000185/WN11-CC-000185.ps1) | The default autorun behavior must be configured to prevent autorun commands | CAT II |
| 7 | [WN11-CC-000210](./WN11-CC-000210/WN11-CC-000210.ps1) | The Microsoft Defender SmartScreen for Explorer must be enabled | CAT II |
| 8 | [WN11-00-000150](./WN11-00-000150/WN11-00-000150.ps1) | Structured Exception Handling Overwrite Protection (SEHOP) must be enabled | **CAT I** |
| 9 | [WN11-CC-000038](./WN11-CC-000038/WN11-CC-000038.ps1) | WDigest Authentication must be disabled | CAT II |
| 10 | [WN11-SO-000167](./WN11-SO-000167/WN11-SO-000167.ps1) | Remote calls to the Security Account Manager (SAM) must be restricted to Administrators | CAT II |

---

## 🔁 Methodology

Each STIG remediation followed this workflow:

1. **Baseline scan** — Identified failing STIG controls using Tenable
2. **Manual fix** — Applied registry change directly and confirmed PASS via rescan
3. **Revert** — Undid the manual fix and confirmed FAIL via rescan
4. **Automate** — Wrote a PowerShell script replicating the same fix
5. **Validate** — Ran the script and confirmed PASS via final rescan
6. **Document** — Pushed script to GitHub

---

## 🧠 Script Design

All scripts follow a consistent structure:

- **Admin check** — Exits if not run as Administrator
- **Pre-check** — Exits early if already compliant (no unnecessary writes)
- **Remediation** — Applies the required registry change
- **Post-check** — Verifies the change was applied successfully
- **Exit codes** — `0` for compliant, `1` for non-compliant or error

---

## ⚠️ Notes

- Scripts are intended for standalone, non-domain Windows 11 systems
- Always test in a non-production environment before deploying widely
- Validated against the DISA Windows 11 STIG v2r6 audit file in Tenable
