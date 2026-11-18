Wazuh SSH Brute-Force Detection & Investigation
Project Overview
A hands-on Security Operations Center (SOC) and detection engineering project using Wazuh SIEM to detect, investigate, and document repeated SSH authentication failures.
The project involved generating controlled SSH login failures, developing a custom Wazuh detection rule, validating alert generation, and correlating security events with Linux authentication logs.
Objectives
Develop a custom Wazuh detection rule.
Detect repeated SSH authentication failures.
Identify suspicious authentication patterns.
Investigate source IP and targeted account information.
Correlate Wazuh alerts with Linux system logs.
Map detection activity to MITRE ATT&CK.
Produce an incident investigation report.
Environment & Tools
Component
Technology
SIEM
Wazuh
Operating System
Ubuntu Linux
Log Analysis
jq
Authentication Logs
journalctl
Network Investigation
ss, ip neigh, ip route
Detection Rules
Wazuh XML
Framework
MITRE ATT&CK

Detection Rule
Custom Rule ID: 100100
Setting
Configuration
Severity
10
Frequency
5
Timeframe
120 seconds
Parent Rule
5760
MITRE Technique
T1110
Detection
Multiple failed authentication attempts

The custom rule identifies repeated SSH authentication failures from the same source IP within the configured time window.
Investigation Scenario
Controlled SSH authentication failures were generated against the analyst account to simulate brute-force behavior.
The investigation identified:
Repeated SSH authentication failures.
PAM authentication failure events.
Source IP: 192.168.64.1.
Target account: analyst.
A successful trigger of custom Wazuh Rule 100100.
Investigation Process
Generated controlled SSH authentication failures.
Reviewed Wazuh alerts in alerts.json.
Filtered authentication events using jq.
Identified correlated SSH and PAM events.
Validated the custom detection rule.
Reviewed authentication history using last and lastb.
Investigated network connections and neighbor information.
Documented findings and detection results.
MITRE ATT&CK Mapping
Technique
ID
Description
Brute Force
T1110
Repeated authentication attempts
Credential Access
TA0006
ATT&CK tactic associated with the detection

Results
The custom Wazuh rule successfully generated a Level 10 alert after the configured authentication-failure threshold was reached.
The resulting alert included the source IP, targeted account, detection description, and MITRE ATT&CK metadata.
The activity was intentionally generated in a controlled lab environment.
Skills Demonstrated
SIEM monitoring
Detection engineering
Wazuh custom rule development
Linux security administration
SSH authentication analysis
Log correlation
JSON parsing with jq
Network investigation
MITRE ATT&CK mapping
SOC incident documentation
Project Evidence
Screenshots documenting the detection, alert validation, log analysis, and investigation are available in the evidence/ directory.
Future Improvements
Develop additional SSH detection rules.
Create automated IP-based alert enrichment.
Build a security monitoring dashboard.
Implement alert notification workflows.
Expand detection coverage to additional authentication events.



