#!/usr/bin/env bash
set -Eeuo pipefail

# Analyze Wazuh alerts for the custom SSH detection rule.
# Usage:
#   sudo RULE_ID=100100 bash scripts/analyze_ssh_logs.sh
#   WAZUH_ALERTS_FILE=/path/to/alerts.json REPORT_DIR=./reports bash scripts/analyze_ssh_logs.sh

LOG_FILE="${WAZUH_ALERTS_FILE:-/var/ossec/logs/alerts/alerts.json}"
RULE_ID="${RULE_ID:-100100}"
REPORT_DIR="${REPORT_DIR:-reports}"
TIMESTAMP="$(date -u +%Y%m%dT%H%M%SZ)"
REPORT_FILE="$REPORT_DIR/ssh-rule-${RULE_ID}-${TIMESTAMP}.txt"

command -v jq >/dev/null 2>&1 || {
  echo "ERROR: jq is required. Install jq and try again." >&2
  exit 1
}

if [[ ! -r "$LOG_FILE" ]]; then
  echo "ERROR: Cannot read $LOG_FILE" >&2
  echo "Try running with sudo, or set WAZUH_ALERTS_FILE to a readable copy." >&2
  exit 1
fi

mkdir -p "$REPORT_DIR"

{
  echo "WAZUH SSH DETECTION INVESTIGATION"
  echo "Generated (UTC): $TIMESTAMP"
  echo "Alert file: $LOG_FILE"
  echo "Rule ID: $RULE_ID"
  echo

  printf '%-28s %-9s %-7s %-18s %-16s %-18s %s\n' \
    "TIMESTAMP" "RULE_ID" "LEVEL" "SOURCE_IP" "ACCOUNT" "ENDPOINT" "DESCRIPTION"

  jq -sr --arg rule "$RULE_ID" '
    .[]
    | select((.rule.id? // "" | tostring) == $rule)
    | [
        (.timestamp // "Unknown"),
        (.rule.id // "Unknown" | tostring),
        (.rule.level // "Unknown" | tostring),
        (.data.srcip // "Not recorded"),
        (.data.dstuser // .data.srcuser // .data.user // "Not recorded"),
        (.agent.name // "Unknown"),
        (.rule.description // "No description")
      ]
    | @tsv
  ' "$LOG_FILE" |
  while IFS=$'\t' read -r ts rid level ip user agent description; do
    printf '%-28s %-9s %-7s %-18s %-16s %-18s %s\n' \
      "$ts" "$rid" "$level" "$ip" "$user" "$agent" "$description"
  done

  echo
  MATCH_COUNT="$(jq -sr --arg rule "$RULE_ID" \
    '[.[] | select((.rule.id? // "" | tostring) == $rule)] | length' "$LOG_FILE")"
  echo "Matching alerts: $MATCH_COUNT"

  if [[ "$MATCH_COUNT" -eq 0 ]]; then
    echo "No alerts matched this rule ID in the selected file."
  else
    echo "Review the source IP, account, timestamps, and endpoint in the context of your lab."
  fi
} | tee "$REPORT_FILE"

echo
echo "Report saved to: $REPORT_FILE"
