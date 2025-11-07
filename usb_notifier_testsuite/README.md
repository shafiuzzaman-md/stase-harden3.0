
# USB Notifier Dangling Pointer — KLEE Test Suite

This suite reproduces a dangling notifier pointer scenario with KLEE and
emits a JSON artifact at the registration site (line 103), using the
rule-agnostic `target` and the predicate `!module_alive && notifier_registered`.

## Layout
```
usb_notifier_testsuite/
├─ src/
│  ├─ usb_event_logger.c        # instrumented: assert before register; symbolic do_unregister
│  └─ kbmi_usb.c                # optional, not needed for the witness
├─ driver/
│  └─ klee_driver_dangling_notify.c  # drives two init cycles; do_unregister is symbolic
├─ include/
│  └─ klee_kernel_stubs.h       # tiny kernel shims
├─ scripts/
│  └─ run_and_emit_json.sh      # builds, runs KLEE, emits JSON
├─ Makefile
└─ outputs/
```

## Build & Run
```
make run
# or
./scripts/run_and_emit_json.sh
```

- Requires `clang`, `llvm-link`, and `klee` on your PATH.
- On success, you will see `klee-last/` with test results and:
  `outputs/DANGLING_PTR_usb_event_logger_103.json`

## What gets checked
The assertion is injected **immediately before** the registration call
(equivalent to line 103) and encodes:
```
klee_assert(!( !module_alive && notifier_registered ));
```
Initial assumptions:
```
module_alive == 0
notifier_registered == 0
```
The driver makes `do_unregister` symbolic; when `do_unregister == 0`, the
second `usb_logger_init()` hits the assertion with the stale pre-state,
proving the dangling notifier case. If you fix the module to always
unregister, KLEE should not find a counterexample.
