export ARCH=arm64
export CROSS_COMPILE=aarch64-linux-gnu-
obj-m += helloworld.o #helloworld.c 对应.o 文件的名称。 名称要保持一致。
KDIR :=$(KERNEL_DIR) #内核源码所在虚拟机 ubuntu 的实际路径
PWD ?= $(shell pwd)
OUTPUT_DIR := $(PWD)/.build

all:
	mkdir -p $(OUTPUT_DIR)
	cp -f helloworld.c $(OUTPUT_DIR)/
	cp -f Makefile $(OUTPUT_DIR)/
	make -C $(KDIR) M=$(OUTPUT_DIR) modules #make 操作
	cp -f $(OUTPUT_DIR)/*.ko $(PWD)/

clean:
	make -C $(KDIR) M=$(OUTPUT_DIR) clean 2>/dev/null || true
	rm -rf $(OUTPUT_DIR)
	rm -f *.ko *.mod.* *.o modules.order Module.symvers .*.cmd