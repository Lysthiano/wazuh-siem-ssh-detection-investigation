# Wazuh SSH Authentication Detection - Test Cases

## Testing Environment

- SIEM: Wazuh
- Detection Rule: 100100
- Monitored Endpoint: Ubuntu Linux
- Testing Scope: Authorized lab environment

## TC-01: Localhost Authentication Testing

**Objective:** Validate detection of failed SSH authentication attempts generated locally.

**Test Classification:** Localhost testing

**Activity:** Authentication attempts originating from the local testing environment.

**Expected Result:** Wazuh identifies failed authentication activity.

**Evidence:** wazuh-rule-100100-alerts.png

**Important:** Localhost activity is not evidence of an external attack.

## TC-02: Custom Detection Rule Validation

**Objective:** Verify custom Wazuh rule 100100.

**Detection:** Multiple failed authentication attempts within 120 seconds.

**Expected Result:** Wazuh generates an alert with severity level 10.

**Observed Result:** Four matching events displayed in Wazuh Threat Hunting.

**Status:** PASS

## TC-03: External SSH Authentication Simulation

**Objective:** Validate detection of SSH authentication attempts originating from a separate authorized test machine.

**Test Classification:** External lab simulation.

**Status:** NOT YET EXECUTED

**Expected Result:** Wazuh identifies authentication failures and records the originating source IP.

## Testing Limitations

Current evidence includes localhost testing and
Wazuh alert validation.

External SSH attack simulation has not yet
been documented or validated.

No localhost activity should be represented
as an external attack.
