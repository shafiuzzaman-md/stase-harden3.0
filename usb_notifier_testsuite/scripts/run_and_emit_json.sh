
#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.."; pwd)"
cd "$ROOT"

make run

# Determine if KLEE hit the assertion (by checking an .err file)
STATUS="PASS"
if ls klee-last/*.err >/dev/null 2>&1; then
  STATUS="FAIL"
fi

# Emit JSON to outputs/
JSON_PATH="outputs/DANGLING_PTR_usb_event_logger_103.json"
cat > "$JSON_PATH" <<'JSON'
{
  "type": "DANGLING_PTR",
  "file": "../inputs/../stase_generated_last/instrumented_source/drivers/usb_event_logger/usb_event_logger.c",
  "line": 103,
  "target": { "kind": "function_pointer", "expr": "usb_nb.notifier_call" },
  "symvars": ["do_unregister"],
  "assumptions": [
    "module_alive == 0",
    "notifier_registered == 0"
  ],
  "assertions": [
    "klee_assert(!( !module_alive && notifier_registered ));"
  ]
}
JSON

echo "JSON written to $JSON_PATH"
echo "KLEE_STATUS=$STATUS"
exit 0
