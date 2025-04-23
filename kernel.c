#include "source.h"
#include "keyboard.h"

void main(void) {
    // we first create a terminal buffer, this is a memory buffer to throw all our
    // display data in. We will use VGA.
    terminal_buffer = (unsigned short*) VGA_ADDRESS;
    // kinda like ur cursor, its the location of your text
    vga_index = 0;
    // clear the screen before printing hello world
    clear_screen();

    print_string("Hello world!", YELLOW);
    vga_index= 80;
    print_string("Version 1", RED);
    vga_index = 160;
    print_char('b', RED);
    vga_index = 240;
    while (1) {
        keyboard_handler();
    }

    return;

}
