#include "../../klee/klee.h"
#include "klee_kernel_stubs.h"

/* Exported by the instrumented module */
int  usb_logger_init(void);
void usb_logger_exit(void);

/* STASE booleans (defined in src/usb_event_logger.c) */
extern _Bool module_alive;
extern _Bool notifier_registered;

/* Registration subject (to identify the callback) */
extern struct notifier_block usb_nb;
int usb_notify(struct notifier_block*, unsigned long, void*);

/* Symbolic knob: whether exit() unregisters */
extern _Bool do_unregister;



int main(void) {
  /* 0) Symbolics */
  klee_make_symbolic(&do_unregister, sizeof(do_unregister), "do_unregister");

  /* Make the internal state variables symbolic too (for status checking).
     Immediately constrain to the *initial* assumptions your JSON encodes. */
  klee_make_symbolic(&module_alive, sizeof(module_alive), "module_alive");
  klee_make_symbolic(&notifier_registered, sizeof(notifier_registered), "notifier_registered");
  klee_assume(module_alive == 0);
  klee_assume(notifier_registered == 0);


  /* 1) First load: should set module_alive=1, notifier_registered=1 */
  usb_logger_init();

  /* Sanity checks on the state right after first init */
  klee_assert(module_alive == 1 && "module should be alive after init");
  klee_assert(notifier_registered == 1 && "notifier should be registered after init");

  /* 2) Unload: depending on do_unregister, we may (or may not) unregister */
  usb_logger_exit();

  /* After exit, module must be torn down */
  klee_assert(module_alive == 0 && "module should be dead after exit");

  /* If we did unregister, the flag must be 0; otherwise it stays 1 (the bug) */
  if (do_unregister) {
    klee_assert(notifier_registered == 0 && "expected notifier to be unregistered when do_unregister==1");
  } else {
    klee_assert(notifier_registered == 1 && "expected notifier to remain registered when do_unregister==0");
  }

  /* 3) Identify the dangling pointer target before re-registering:
        ensure the concrete callback is still the same function */
  klee_assert(usb_nb.notifier_call == usb_notify && "target callback identity mismatch");

  /* 4) Second load: if do_unregister==0, the module’s pre-register assertion
        ( !( !module_alive && notifier_registered ) ) will FAIL → dangling notifier witness */
  usb_logger_init();

  return 0;
}
