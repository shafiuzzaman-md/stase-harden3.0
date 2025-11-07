
#ifndef KLEE_KERNEL_STUBS_H
#define KLEE_KERNEL_STUBS_H

/* Neutralize kernel attributes/macros */
#ifndef __init
# define __init
#endif
#ifndef __exit
# define __exit
#endif
#ifndef MODULE_LICENSE
# define MODULE_LICENSE(x)
#endif
#ifndef MODULE_AUTHOR
# define MODULE_AUTHOR(x)
#endif
#ifndef MODULE_DESCRIPTION
# define MODULE_DESCRIPTION(x)
#endif
#ifndef module_init
# define module_init(x)
#endif
#ifndef module_exit
# define module_exit(x)
#endif
#ifndef KERN_INFO
# define KERN_INFO
#endif

/* Minimal types */
typedef struct notifier_block {
    int (*notifier_call)(struct notifier_block*, unsigned long, void*);
} notifier_block;

/* Stubs for used kernel APIs */
static inline int printk(const char *fmt, ...) { (void)fmt; return 0; }

/* The USB notify APIs under test */
static inline int usb_register_notify(struct notifier_block *nb) {
    (void)nb; return 0;
}
static inline int usb_unregister_notify(struct notifier_block *nb) {
    (void)nb; return 0;
}

/* Values */
#ifndef NOTIFY_OK
# define NOTIFY_OK 0
#endif

#endif /* KLEE_KERNEL_STUBS_H */
