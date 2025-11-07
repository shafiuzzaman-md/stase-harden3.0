
// instrumented/usb_event_logger.c
#include "../../klee/klee.h"
#include "klee_kernel_stubs.h"

MODULE_LICENSE("GPL");
MODULE_AUTHOR("Stanley Hudson");
MODULE_DESCRIPTION("USB Device Event Logger");

/* Initial assumptions (symbolic executor will evolve these) */
_Bool module_alive = 0;
_Bool notifier_registered = 0;

/* Symbolic knob controlled by the driver to decide if exit will unregister */
_Bool do_unregister;

int usb_notify(struct notifier_block *self, unsigned long action, void *dev)
{
    (void)self; (void)action; (void)dev;
    return NOTIFY_OK;
}

struct notifier_block usb_nb = {
    .notifier_call = usb_notify,
};

int usb_logger_init(void)
{
    /* Assert the property at the *target* site: before register call */
    klee_assert(!( !module_alive && notifier_registered ));

    /* TARGET instruction */
    usb_register_notify(&usb_nb);

    /* Bind state at the instructions that change it */
    notifier_registered = 1;
    module_alive = 1;
    return 0;
}

void usb_logger_exit(void)
{
    /* choose to unregister based on symbolic knob */
    if (do_unregister) {
        usb_unregister_notify(&usb_nb);
        notifier_registered = 0;
    }
    module_alive = 0;
}

module_init(usb_logger_init);
module_exit(usb_logger_exit);
