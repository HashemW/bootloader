ASM=nasm

SRC_DIR=~/mybootloader
BUILD_DIR=~/mybootloader/build

$(BUILD_DIR)/main.img: $(BUILD_DIR)/main.bin
	cp $(BUILD_DIR)/main.bin $(BUILD_DIR)/main.img
	truncate -s 1440k $(BUILD_DIR)/main.img

$(BUILD_DIR)/main.bin: $(SRC_DIR)/bootloader.asm
	$(ASM) $(SRC_DIR)/bootloader.asm -f bin -o $(BUILD_DIR)/main.bin
