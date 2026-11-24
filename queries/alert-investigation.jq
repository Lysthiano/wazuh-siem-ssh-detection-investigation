# Show SSH authentication and custom brute-force alerts without hardcoding a lab IP.
# Usage:
#   jq -r -f queries/alert-investigation.jq /var/ossec/logs/alerts/alerts.json

select(
  ((.rule.id? // "") | tostring) as $id
  | ["5715", "5760", "100100"]
  | index($id) != null
)
| [
    .timestamp // "Unknown",
    (.rule.id // "Unknown" | tostring),
    .rule.description // "No description",
    .data.srcip // "Not recorded",
    .data.dstuser // .data.srcuser // .data.user // "Not recorded"
  ]
| @tsv
