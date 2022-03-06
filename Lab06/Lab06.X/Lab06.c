/* 
 * File:   Lab06.c
 * Author: fowlersp
 *
 * Created on February 22, 2022, 9:47 AM
 * Description: This code is used to control a car going around a track.
 * This uses the ece212.h given code for programming the motors and sensors. 
 */

#include "ece212.h"

/* main function
 * This function controls and runs all parts of the program.
 * 
 */
int main(int argc, char** argv) {
    int senseL = 0x000;
    int senseR = 0x000;
    int cnt = 0;
    RBACK = 0;
    RFORWARD = 0xFFFF;
    LBACK = 0;
    LFORWARD = 0xFFFF;
    ece212_lafbot_setup();
    while(1){
        senseR = analogRead(RIGHT_SENSOR);
        senseL = analogRead(LEFT_SENSOR);
        //straightaways
        if(senseR < 0x175 && senseL < 0x175){
            //This was used to test if the car is on a straightaway 
            //for a long period of time but is redundant now since
            //the straight speed for the car is maxed.
            if(cnt > 5000){
                writeLEDs(0xF);
                RBACK = 0;
                RFORWARD = 0xFFFF;
                LBACK = 0;
                LFORWARD = 0xFFFF;
            }
            else{
                writeLEDs(0x9);
                RBACK = 0;
                RFORWARD = 0xFFFF;
                LBACK = 0;
                LFORWARD = 0xFFFF;
                cnt++;
            }
        }
        //turn left
        else if(senseR < 0x175){
            writeLEDs(0x1);
            RBACK = 0;
            RFORWARD = 0xFFFF;
            LBACK = 0;
            LFORWARD = 0x6700;
            cnt = 0;
        }
        //turn right
        else if(senseL < 0x175){
            writeLEDs(0x8);
            RBACK = 0;
            RFORWARD = 0x6700;
            LBACK = 0;
            LFORWARD = 0xFFFF;
            cnt = 0;
        } 
        else{
            writeLEDs(0x0);
            //cnt = 0;
        }
      //delayms(50); 
    }
    
    
    return (EXIT_SUCCESS);
}
