# Investigation Reports

This folder contains sample outputs and historical investigation results from the Wazuh SSH authentication monitoring lab.

The reports demonstrate how authentication events, Wazuh alerts, and custom detection-rule results were reviewed during the investigation.

## Report Inventory

| File | Description |
|---|---|
| `sample-ssh-investigation.txt` | Sample authentication events associated with Wazuh parent rule 5760. |
| `ssh-analysis.txt` | SSH authentication analysis showing six failed authentication events. |

## Understanding the Results

### 1. Parent-Rule Authentication Events

`sample-ssh-investigation.txt`

- Detection rule: 5760
- Three authentication events
- Severity level: 5
- Source IP: 192.168.64.1
- Target account: analyst

This output represents individual SSH authentication events identified by the parent rule.

### 2. SSH Authentication Analysis

`ssh-analysis.txt`

- Six failed SSH authentication events
- Source IP: 192.168.64.1
- Target account: analyst

This report summarizes failed authentication activity for further investigation.

### 3. Historical Custom-Rule Test Outputs

Earlier timestamped reports were generated while testing custom Wazuh rule 100100.

These historical outputs included:

- Three matching custom-rule alerts in some runs.
- A run with zero matching alerts.
- Events with unavailable source-IP fields.
- A localhost event associated with 127.0.0.1.

These are historical snapshots from different runs, not one continuous incident timeline.

## Detection Configuration Reference

| Setting | Value |
|---|---|
| Custom rule ID | 100100 |
| Alert level | 10 |
| Parent rule | 5760 |
| Frequency threshold | 5 |
| Timeframe | 120 seconds |
| Correlation | Same source IP |
| MITRE ATT&CK | T1110 – Brute Force |

The historical report outputs should not be interpreted as proof that every test run satisfied the five-event correlation threshold.

## Analyst Assessment

The SSH failures were intentionally generated as part of an authorized lab exercise.

The observed source IP 192.168.64.1 was associated with the lab network context. The available evidence does not establish an external attacker or confirmed account compromise.

## Purpose

These reports demonstrate practical experience with:

- Wazuh alert investigation
- SSH authentication monitoring
- Linux authentication-log analysis
- Custom detection-rule testing
- Event correlation
- Security investigation documentation

For the consolidated investigation findings, see [the SOC Incident Investigation Report](../documentation/incident-report.md).
