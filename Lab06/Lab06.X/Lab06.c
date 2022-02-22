/* 
 * File:   Lab06.c
 * Author: fowlersp
 *
 * Created on February 22, 2022, 9:47 AM
 */

#include "ece212.h"

/*
 * 
 */
int main(int argc, char** argv) {
    int senseL = 0x000;
    int senseR = 0x000;
    int cnt = 0;
    ece212_lafbot_setup();
    while(1){
        senseR = analogRead(RIGHT_SENSOR);
        senseL = analogRead(LEFT_SENSOR);
        if(senseR < 0x150 && senseL < 0x150){
            if(cnt > 50000){
                //while(senseR < 0x150 && senseL < 0x150){
                    writeLEDs(0xF);
                    RBACK = 0;
                    RFORWARD = 0xD000;
                    LBACK = 0;
                    LFORWARD = 0xD000;
                //}
                //cnt = 0;
            }
            else{
                writeLEDs(0x9);
                RBACK = 0;
                RFORWARD = 0xB000;
                LBACK = 0;
                LFORWARD = 0xB000;
                cnt++;
            }
            
        }
        else if(senseR < 0x150){
            writeLEDs(0x1);
            RBACK = 0;
            RFORWARD = 0x9500;
            LBACK = 0;
            LFORWARD = 0x0700;
            cnt = 0;
        }
        else if(senseL < 0x150){
            writeLEDs(0x8);
            RBACK = 0;
            RFORWARD = 0x0700;
            LBACK = 0;
            LFORWARD = 0x9500;
            cnt = 0;
        } 
        else{
            writeLEDs(0x0);
            cnt = 0;
        }
       
    }
    
    
    return (EXIT_SUCCESS);
}
