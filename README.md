Wazuh SIEM – SSH Authentication Detection & Automated Investigation
Project Overview
This project implements a Security Information and Event Management (SIEM) environment using Wazuh to monitor Linux authentication activity, detect suspicious SSH login attempts, and automate security investigations.
A custom detection rule identifies SSH authentication events, while Bash and jq automate log extraction, event normalization, source IP aggregation, severity analysis, and investigation reporting.
Objectives
Configure a Wazuh SIEM monitoring environment.
Monitor Linux SSH authentication activity.
Develop custom authentication detection logic.
Investigate failed authentication alerts.
Automate security log analysis using Bash and jq.
Generate structured incident investigation reports.
Apply MITRE ATT&CK concepts to authentication-related threats.
Technologies Used
Technology
Purpose
Wazuh
SIEM and security event monitoring
Ubuntu Linux
Endpoint and server environment
Bash
Investigation automation
jq
JSON parsing and log analysis
SSH
Authentication monitoring
MITRE ATT&CK
Threat classification
Git/GitHub
Version control and documentation

Detection Engineering
Custom Detection Rule: 100100
The detection workflow monitors SSH authentication activity and identifies failed login attempts.
The collected alerts include:
Authentication failures
Invalid username attempts
Failed password attempts
Source IP information
Endpoint information
Alert severity
MITRE ATT&CK technique metadata when present
Automated Investigation
Developed a Bash script:
scripts/analyze_ssh_logs.sh
The script performs the following operations:
Reads Wazuh alerts from alerts.json.
Filters events associated with detection rule 100100.
Normalizes relevant event fields.
Extracts timestamps, usernames, source IPs, endpoints, and severity.
Groups failed authentication attempts by source IP.
Summarizes alert severity.
Calculates the total number of matching events.
Generates a timestamped investigation report.
Investigation Report
The automated report contains five sections:
Failed SSH Authentication Events
Failed Attempts by Source IP
Alert Severity
Total Failed Authentication Events
Investigation Summary
Reports are saved in the reports/ directory.
Testing & Findings
Testing demonstrated that the Wazuh environment generated authentication-related alerts for SSH activity.
Observed findings included:
Multiple failed authentication events.
Invalid username activity.
Alerts associated with custom rule 100100.
Endpoint identification.
Source IP information, including locally generated loopback activity.
The investigation script successfully processed three matching events in one documented test run and generated a report.
Security Considerations
The initial testing environment included locally generated authentication activity. Loopback addresses such as 127.0.0.1 should not be interpreted as evidence of an external attacker.
Missing source IP and username fields are identified as data-quality limitations requiring further investigation.
Skills Demonstrated
SIEM Administration
Security Monitoring
Detection Engineering
Linux Administration
SSH Security
Log Analysis
JSON Parsing
Bash Scripting
Incident Investigation
MITRE ATT&CK
Future Improvements
Expand SSH detection coverage.
Improve source IP attribution.
Add successful versus failed authentication correlation.
Implement brute-force threshold detection.
Improve investigation report formatting.
Add additional detection rules and automated response workflows.
Disclaimer
This project was developed in a controlled lab environment for educational and cybersecurity portfolio purposes. Testing was performed against authorized systems.
