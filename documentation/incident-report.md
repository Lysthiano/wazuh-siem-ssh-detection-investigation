# SOC Incident Investigation Report

**Incident:** Repeated SSH authentication failures  
**Environment:** Controlled Wazuh SIEM lab  
**Detection rule:** `100100`  
**Severity:** Level 10  
**Assessment:** Detection validated; controlled test activity confirmed

## 1. Executive summary
A custom Wazuh rule identified repeated SSH authentication failures targeting the `analyst` account. The activity originated from `192.168.64.1` and triggered a Level 10 alert after five matching events within 120 seconds. The failed attempts were intentionally generated for detection testing; this is not a confirmed malicious intrusion.

## 2. Alert details
| Field | Observed value |
|---|---|
| Source IP | `192.168.64.1` |
| Target account | `analyst` |
| Protocol | SSH |
| Custom rule | `100100` |
| Severity | `10` |
| Frequency | `5` |
| Timeframe | `120` seconds |
| MITRE technique | `T1110` – Brute Force |

## 3. Investigation performed
- Reviewed `/var/ossec/logs/alerts/alerts.json`.
- Filtered events by source IP and relevant rule IDs using `jq`.
- Inspected the full custom-rule alert and its source fields.
- Correlated SSH and PAM messages using `journalctl`.
- Reviewed successful login history with `last -ai`.
- Reviewed failed login history with `lastb -ai`.
- Checked active SSH connections with `ss -tnp`.
- Reviewed neighbor and route information with `ip neigh` and `ip route`.

## 4. Detection analysis
The custom rule was configured to match five events associated with parent rule `5760` within 120 seconds and correlate on the same source IP. The resulting alert showed rule ID `100100`, level `10`, source IP `192.168.64.1`, and destination user `analyst`.

## 5. Analyst assessment and limitations
The detection successfully identified the deliberately generated authentication failures. Authentication history also contained successful login records. The available evidence does not establish that those successful sessions were unauthorized or that an account was compromised. The source IP is part of the lab network context and should not be characterized as an external attacker without additional evidence.

## 6. Recommended defensive measures
- Prefer SSH key-based authentication where operationally appropriate.
- Restrict SSH access to authorized hosts and networks.
- Apply rate limiting or other appropriate controls to reduce password-guessing attempts.
- Monitor repeated failures and successful logins following suspicious activity.
- Preserve centralized logs and document detection tuning to reduce false positives.

## 7. Conclusion
The lab demonstrated custom Wazuh rule development, alert validation, SSH/PAM log correlation, authentication-history review, network-context checks, and SOC-style incident documentation. The detection rule successfully generated an alert for controlled test activity.
