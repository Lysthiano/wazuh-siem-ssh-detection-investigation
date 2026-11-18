
#!/usr/bin/env bash
set -euo pipefail

LOG_FILE="/var/ossec/logs/alerts/alerts.json"
RULE_ID="100100"
REPORT_DIR="reports"

mkdir -p "$REPORT_DIR"

REPORT_FILE="$REPORT_DIR/ssh-investigation-$(date +%Y%m%d-%H%M%S).txt"

if ! sudo test -r "$LOG_FILE"; then
    echo "ERROR: Wazuh alerts log is missing or unreadable."
    exit 1
fi

# Extract and normalize matching events
EVENTS=$(sudo jq -cs --arg rule "$RULE_ID" '
[
  .[] |
  (if type == "array" then .[] else . end) |
  select(type == "object") |
  select(((.rule.id? // .rule_id? // "") | tostring) == $rule)
  ) |
  {
    timestamp: (.timestamp // "Unknown"),
    username: (
      .data.srcuser? //
      .data.dstuser? //
      .data.user? //
      "Unknown"
    ),
    source_ip: (.data.srcip? // "Not recorded"),
    endpoint: (.agent.name? // "Unknown"),
    severity: (.rule.level? // "Not recorded"),
    tty: (.data.tty? // "Not recorded")
  }
]
' "$LOG_FILE")

TOTAL=$(jq 'length' <<< "$EVENTS")

{
    echo "=================================================="
    echo "         SSH SECURITY INVESTIGATION REPORT"
    echo "=================================================="
    echo
    echo "Detection Rule: $RULE_ID"
    echo "Log Source: $LOG_FILE"
    echo "Analysis Date: $(date)"
    echo

    echo "[1] FAILED SSH AUTHENTICATION EVENTS"
    echo "--------------------------------------------------"

    if [[ "$TOTAL" -eq 0 ]]; then
        echo "No matching events found."
    else
        printf "%-28s %-15s %-18s %-20s %-10s\n" \
            "TIMESTAMP" "USERNAME" "SOURCE IP" "ENDPOINT" "SEVERITY"

        jq -r '.[] | [
            .timestamp,
            .username,
            .source_ip,
            .endpoint,
            (.severity | tostring)
        ] | @tsv' <<< "$EVENTS" |
        while IFS=$'\t' read -r timestamp username ip endpoint severity; do
            printf "%-28s %-15s %-18s %-20s %-10s\n" \
                "$timestamp" "$username" "$ip" "$endpoint" "$severity"
        done
    fi

    echo
    echo "[2] FAILED ATTEMPTS BY SOURCE IP"
    echo "--------------------------------------------------"

    jq -r '
      group_by(.source_ip)[]
      | "\(length)\t\(.[0].source_ip)"
    ' <<< "$EVENTS" |
    while IFS=$'\t' read -r count ip; do
        printf "%-8s %s\n" "$count" "$ip"
    done

    echo
    echo "[3] ALERT SEVERITY"
    echo "--------------------------------------------------"

    jq -r '
      group_by(.severity)[]
      | "Severity \(.[0].severity): \(length) event(s)"
    ' <<< "$EVENTS"

    echo
    echo "[4] TOTAL FAILED AUTHENTICATION EVENTS"
    echo "--------------------------------------------------"
    echo "$TOTAL"

    echo
    echo "[5] INVESTIGATION SUMMARY"
    echo "--------------------------------------------------"

    if [[ "$TOTAL" -gt 0 ]]; then
        echo "Matching authentication alerts were identified."
        echo "Review source IPs and affected accounts."
        echo "Investigate unrecorded source IP fields."
    else
        echo "No matching alerts were identified."
    fi

    echo
    echo "=================================================="
    echo "          INVESTIGATION COMPLETE"
    echo "=================================================="

} | tee "$REPORT_FILE"

echo
echo "Report saved to: $REPORT_FILE"

