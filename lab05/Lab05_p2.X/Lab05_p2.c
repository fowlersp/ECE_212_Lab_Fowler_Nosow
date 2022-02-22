/* 
 * File:   Lab05_p2.c
 * Author: fowlersp
 *
 * Created on February 22, 2022, 9:17 AM
 */

#include "ece212.h"

/*
 * 
 */
int main() {
    ece212_lafbot_setup();
    while(1) {
        RBACK = 0;
        RFORWARD = 0x8000;
        LBACK = 0;
        LFORWARD = 0x8000;
        delayms(500);
        RBACK = 0;
        RFORWARD = 0;
        LBACK = 0;
        LFORWARD = 0;
        delayms(1000);
        RBACK = 0x8000;
        RFORWARD = 0;
        LBACK = 0x8000;
        LFORWARD = 0;
        delayms(500);
        RBACK = 0;
        RFORWARD = 0;
        LBACK = 0;
        LFORWARD = 0;
        delayms(1000);
    }
    return (EXIT_SUCCESS);
}
