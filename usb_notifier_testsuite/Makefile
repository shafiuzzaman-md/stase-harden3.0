
# Simple Makefile to build and run KLEE
CLANG ?= clang
LLVMLINK ?= llvm-link
KLEE ?= klee

CFLAGS := -Iinclude -Iklee -emit-llvm -c -O0 -g

# If the user has KLEE and wants to use real headers, call:
#   make run USE_REAL_KLEE=1
ifeq ($(USE_REAL_KLEE),1)
  CFLAGS += -DUSE_REAL_KLEE
  # Try to append KLEE's cflags if available
  KLEE_CFLAGS := $(shell klee --cflags 2>/dev/null)
  ifneq ($(KLEE_CFLAGS),)
    CFLAGS += $(KLEE_CFLAGS)
  endif
  CFLAGS += $(KLEE_CFLAGS_EXTRA)
endif


all: build

build:
	$(CLANG) $(CFLAGS) src/usb_event_logger.c -o usb_event_logger.bc
	$(CLANG) $(CFLAGS) driver/klee_driver_dangling_notify.c -o klee_driver_dangling_notify.bc
	$(LLVMLINK) usb_event_logger.bc klee_driver_dangling_notify.bc -o logger_dangling_combined.bc

run: build
	$(KLEE) --exit-on-error logger_dangling_combined.bc || true
	@echo "KLEE finished. See klee-last/ for results."

clean:
	rm -f *.bc
	rm -rf klee-out-* klee-last
