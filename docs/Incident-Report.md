SOC Incident Investigation Report
Incident: Repeated SSH Authentication Failures
 Environment: Wazuh SIEM Lab
 Detection Rule: 100100
 Severity: Level 10
 Status: Detection validated; controlled activity confirmed
1. Executive Summary
A custom Wazuh detection rule identified multiple failed SSH authentication attempts targeting the analyst account.
The activity originated from 192.168.64.1 and triggered a Level 10 security alert after five authentication failures within a 120-second timeframe.
The activity was intentionally generated as part of a controlled security testing exercise.
2. Alert Details
Field
Finding
Source IP
192.168.64.1
Target account
analyst
Protocol
SSH
Detection Rule
100100
Severity
10
Frequency
5
Timeframe
120 seconds
MITRE Technique
T1110 – Brute Force

3. Investigation Timeline
November 18, 2026
04:17 UTC: SSH authentication success events recorded.
04:18 UTC: SSH and PAM authentication failures observed.
17:56 UTC: Repeated authentication failures generated.
17:56:58 UTC: Custom Wazuh Rule 100100 triggered.
17:57 UTC: Additional authentication failure recorded.
Subsequent investigation: Authentication history, SSH connections, and network information reviewed.
4. Evidence Collected
The following evidence was reviewed:
Wazuh alerts.json
SSH authentication events
PAM authentication failures
journalctl output
Successful login history using last -ai
Failed login history using lastb -ai
SSH connection information using ss -tnp
Neighbor information using ip neigh
5. Detection Analysis
The custom detection rule was configured to identify five matching authentication failures within 120 seconds.
The resulting alert confirmed:
Rule ID: 100100
Rule level: 10
Source IP: 192.168.64.1
Destination user: analyst
Description: Multiple failed authentication attempts detected within 120 seconds.
The alert also contained MITRE ATT&CK technique T1110.
6. Analyst Assessment
The detection successfully identified the simulated brute-force activity.
The source IP and account were correlated with the underlying SSH and PAM logs.
Because the activity was intentionally generated, the investigation classified it as authorized testing rather than a confirmed malicious intrusion.
Although successful authentication events were also present in the historical logs, the available evidence does not establish that they resulted from an unauthorized login.
7. Recommended Security Improvements
Enforce SSH key-based authentication.
Disable password authentication where operationally appropriate.
Apply account lockout or rate-limiting controls.
Restrict SSH access to authorized network sources.
Monitor repeated authentication failures.
Review successful logins following suspicious authentication activity.
Maintain centralized security logging and alert monitoring.
8. Final Conclusion
The Wazuh detection engineering exercise successfully demonstrated the creation, testing, and validation of a custom SSH brute-force detection rule.
The investigation demonstrated the ability to identify authentication anomalies, correlate SIEM alerts with underlying system logs, examine network context, and document findings using a SOC incident reporting structure.
Final Outcome: Detection rule successfully validated in a controlled lab environment.

