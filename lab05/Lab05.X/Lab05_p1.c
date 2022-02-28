/* 
 * File:   Lab05_p1.c
 * Author: fowlersp
 *
 * Created on February 22, 2022, 8:10 AM
 * Description: This code turns the leds on in a cyclic order such that it displays them changing.
 * When the button is pressed that cyclic order changes directions.
 * This code uses the ece212.h to control the leds.
 * This also includes a single pulser function to account for the button press.
 */

#include "ece212.h"

/* 
 * Function: main
 * Description: Runs the cycle of changing the leds and the single pulser.
 */
int main() {
    int direction = 0;  //used to tell which state the cycle is in forward or back
    ece212_setup();
    while(1){
        direction = singlepulser(direction);    //checks button press
        if(direction%2){    
            writeLEDs(0x8);
            delayms(100);
            direction = singlepulser(direction);
            writeLEDs(0x4);
            delayms(100);
            direction = singlepulser(direction);
            writeLEDs(0x2);
            delayms(100);
            direction = singlepulser(direction);
            writeLEDs(0x1);
            delayms(100);  
            direction = singlepulser(direction);
        }
        else{
            writeLEDs(0x1);
            delayms(100);
            direction = singlepulser(direction);
            writeLEDs(0x2);
            delayms(100);
            direction = singlepulser(direction);
            writeLEDs(0x4);
            delayms(100);
            direction = singlepulser(direction);
            writeLEDs(0x8);
            delayms(100);
            direction = singlepulser(direction);
        }
    }

    return (EXIT_SUCCESS);
}

/*
 * Function: singlepulser
 * Description: This function is a singler pulser used to only account for the button press once.
 */

int singlepulser(int direction){
    int pressed;
    static int pressed1;
    
    pressed = BTN11;
    
    if(pressed && !pressed1){
        direction += 1; 
    }
    else{
        direction = direction;
    }
    pressed1 = pressed;
    
    return direction;
    
}
