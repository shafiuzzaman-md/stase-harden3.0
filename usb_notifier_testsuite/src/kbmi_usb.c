
#include "../../klee/klee.h"
#include "klee_kernel_stubs.h"

#define MESSAGE_SIZE 1024ull
char message_buffer[MESSAGE_SIZE];

static void load_message_to_memory(void) {
    (void)message_buffer;
}

int kbmi_usb_notifier(struct notifier_block *nb, unsigned long action, void *dev) {
    (void)nb; (void)action; (void)dev;
    load_message_to_memory();
    return NOTIFY_OK;
}

static struct notifier_block my_nb = {
    .notifier_call = kbmi_usb_notifier,
};

static int __init kbmi_usb_init(void) {
    usb_register_notify(&my_nb);
    return 0;
}

static void __exit kbmi_usb_exit(void) {
    usb_unregister_notify(&my_nb);
}

module_init(kbmi_usb_init);
module_exit(kbmi_usb_exit);
