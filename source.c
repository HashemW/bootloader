#include "source.h"

unsigned short* terminal_buffer;
unsigned int vga_index;

void clear_screen() {
    int index = 0;
    //There are 25 lines each of 80 columns, each element takes 2 bytes
    while (index < 80 * 25 * 2) {
        terminal_buffer[index] = ' ';
        index+=2;
    }
}

void print_string(char* str, unsigned char color) {
    int index = 0;
    while (str[index]) {
        terminal_buffer[vga_index] = (unsigned short) str[index] |
            (unsigned short) color << 8;
        index++;
        vga_index++;
    }
}

void print_char(char str, unsigned char color) {
    int index = 0;
    terminal_buffer[vga_index] = str | (unsigned short) color << 8;
    index++;
    vga_index++;
}
