Wazuh SIEM – SSH Authentication Detection & Investigation
Project Overview
This project demonstrates a Security Operations Center (SOC) monitoring and investigation workflow using Wazuh SIEM. It focuses on endpoint monitoring, security event analysis, SSH authentication detection, and custom detection rule development.
The project simulates real-world SOC activities by identifying suspicious authentication behavior, investigating security alerts, and analyzing endpoint activity.

Project Screenshots
1. Wazuh Endpoint Overview
Objective: Demonstrate centralized endpoint monitoring and system visibility.
Key observations:
Registered Ubuntu endpoint.
Agent connection and active status.
Operating system and system inventory.
Security event activity overview.
MITRE ATT&CK and compliance visibility.
2. Security Events Dashboard
Objective: Monitor and analyze security events generated across the monitored environment.
Key observations:
Centralized security event monitoring.
Event volume and activity trends.
Detection of authentication-related events.
Visibility into endpoint security activity.
3. Authentication Event Investigation
Objective: Investigate authentication-related security events and identify suspicious login behavior.
Key observations:
Failed SSH authentication attempts.
Invalid username activity.
Source IP information.
Detection severity and rule identification.
4. SSH Authentication Event Timeline
Objective: Visualize authentication activity over time and identify repeated failed login patterns.
Key observations:
Authentication event frequency.
Repeated failed login attempts.
Event timestamps and activity patterns.
Timeline-based security investigation.
5. Custom Wazuh Rule 100100 Alerts
Objective: Demonstrate custom detection and alert generation for repeated SSH authentication failures.
Key observations:
Custom Wazuh detection rule 100100.
Multiple failed authentication attempts.
Detection of repeated authentication failures within 120 seconds.
Generated security alerts available for investigation.

Detection Capabilities
Detection
Description
SSH Authentication Monitoring
Monitors SSH authentication activity
Failed Login Detection
Identifies repeated failed login attempts
Invalid Username Detection
Detects authentication attempts using invalid usernames
Source IP Analysis
Identifies the source of authentication activity
Custom Rule 100100
Generates alerts for repeated authentication failures

Technologies & Tools
Wazuh SIEM
Ubuntu Linux
SSH
JSON Alert Analysis
Custom Wazuh Detection Rules
MITRE ATT&CK
GitHub
Skills Demonstrated
Security Information and Event Management (SIEM)
Security Event Analysis
Log Analysis
Authentication Monitoring
Threat Detection
Alert Investigation
Linux Security Monitoring
Detection Engineering
Security Documentation
Project Outcome
Successfully implemented a Wazuh-based security monitoring environment capable of monitoring endpoint activity, identifying authentication failures, and generating alerts through a custom detection rule.
This project demonstrates foundational SOC analyst skills in security monitoring, event investigation, and detection engineering.


