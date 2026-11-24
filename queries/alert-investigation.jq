# Filter authentication-related alerts from one source IP.
# sudo jq -r -f queries/alert-investigation.jq /var/ossec/logs/alerts/alerts.json | sort

select(.data.srcip == "192.168.64.1")
| select(
    .rule.id == "5715" or
    .rule.id == "5760" or
    .rule.id == "5503" or
    .rule.id == "100100"
  )
| [
    .timestamp,
    .rule.id,
    .rule.description,
    .data.srcip,
    .data.dstuser
  ]
| @tsv
