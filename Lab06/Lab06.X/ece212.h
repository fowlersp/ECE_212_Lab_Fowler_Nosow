/*
 * File:   ece212.h
 * Author: Matthew Watkins
 *
 * Header to support ECE 212 use of PIC32 microcontroller with
 * LafBot Breakout Board
 */
 
#ifndef ECE212_H
#define	ECE212_H

#ifdef	__cplusplus
extern "C" {
#endif

#include <p32xxxx.h>
#include <plib.h>

// all of these pragmas are used by the compiler to configure the PIC32

//Clock
#pragma config FNOSC = FRCPLL   // Internal Fast RC oscillator (8 MHz) w/ PLL
#pragma config FPLLIDIV = DIV_2 // Divide FRC before PLL (now 4 MHz)
#pragma config FPLLMUL = MUL_20 // PLL Multiply (now 80 MHz)
#pragma config FPLLODIV = DIV_2 // Divide After PLL (now 40 MHz)
//Disable dedicated pins
#pragma config JTAGEN = OFF         // Disable JTAG
#pragma config FSOSCEN = OFF        // Disable secondary oscillator
#pragma config FWDTEN = OFF         // Disable watchdog timer
#pragma config POSCMOD = OFF
#pragma config ICESEL = ICS_PGx1    // select pins to transfer program data on (ICSP pins)



// (JN) Switches are connected to PORTB bits 8-11 (RB8-RB11)
// which are configured as inputs.  The following code reads
// individual bits of PORTB using the PORTBbits struct
// built into the API

/* Switch information.
 * Implementation:
 *   Switches have pull up resistor so read is inverted below to provide
 *   more intuitive reading of the button value (i.e., 1 means it is pressed)
 *   To use place the appropriate SWx value where you want to read the
 *   current value of the switch
 *
 * Usage:
 *   Place SWx in location where you want to use current value of switch
 *   Example:
 *     if(BTN8) {
 *   	 //action to perform if switch (button) pressed
 *     }
 *     else { //optional
 *       //action if switch not pressed
 *     }
 */
#define BTN8 !PORTBbits.RB8
#define BTN9 !PORTBbits.RB9
#define BTN10 !PORTBbits.RB10
#define BTN11 !PORTBbits.RB11

// (JN) LEDS are connected to PORTB bits RB0-RB3.  The writeLEDs function
// reads existing values of PORTB, masks it to preserve the upper 12 bits,
// and the Ors it with the parameter (masked to pass bottom 4 bits only)
// before assigning the result to LATB (the PORTB output latch)

/* Implementation:
 *   Writes 4-bit val to 4-LEDs of LafBot Daughter Board
 *   Inverts val signal as board LEDs turn on with 0 output
 *
 * Usage:
 *   Four lowest bits of val are used to set state of 4 LEDs
 *   Exs. writeLEDs(0x1); //turns LED 1 on and LED 2-4 off
 *        writeLEDs(0xA); //turns on LEDs 2 & 4 and off 1 & 3
 */
#define writeLEDs(val) LATB = ((PORTB & 0xFFF0) | ((val) & 0xF))

// (JN) specify A/D inputs AN10 (pin25 on chip) and AN11 (pin 24 on chip)
// according to data sheet, these double as PORTB pins RB14 and RB13

//Analog input pins for left and right car sensors
//Argument for analogRead() function
#define LEFT_SENSOR 10
#define RIGHT_SENSOR 11

// (JN) the following code defines macros for RBACK, RFORWARD, LBACK, LFORWARD
// as "output compare" registers OC2, OC1, OC4, OC3 respectively) for PWM

//Output compare (PWM) registers for left and right forward and back motor direction
//With default setup (from ece212_setup), a motor direction can a value from 0x0000 (off)
//to 0xFFFF (maximum speed).  Due to physical characteristics of the motors and gearing
//a motor needs a value approximately >=0x1FFF to turn.
//
//Example Use: RBACK = 0x1FFF
//**NOTE** At most one of the two directions (forward/back) for a particular motor (right/left)
//         should be non-zero at any time.
#define RBACK    OC2RS
#define RFORWARD OC1RS
#define LBACK    OC4RS
#define LFORWARD OC3RS

/* Setups up basic functionality for use in ECE 212
 * This setup enables 4 LEDs and 3 buttons (SW3-SW5)
 */
void ece212_setup(){
    SYSTEMConfigPerformance(40000000);

    // Set all inputs to digital pins (as opposed to analog)
    ANSELA = 0; ANSELB = 0; CM1CON = 0; CM2CON = 0;

    //PORT PWM (1=input, 0=output))
    TRISA = 0x0000;
    //SWs RB8-11 input
    //LED RB0-3 output
    //RB 13 & 14 input
    TRISB = 0xFFF0;
    //clear pull up & down just to be safe
    CNPUBCLR = 0xFFFF;
    CNPDBCLR = 0xFFFF;
    //EnablePullDownB( BIT_7 | BIT_8 | BIT_9);
    mPORTBSetPinsDigitalIn(BIT_8 | BIT_9 | BIT_10 | BIT_11);    //Set port as input

    //Timer4/5: 32-bit delay timer. 64x divider on internal 40MHZ clock
    T5CONCLR = 0xFFFF;
    T4CONCLR = 0xFFFF;
    T4CON    = 0x8068;
    PR4 =  0xFFFFFFFF;
}

/* Setups up functionality for connecting breakout board
 * to LafBot car.  Enabled Output Compare PWM to control motor
 * direction and Analog-to-Digital Conversion (ADC) to read
 * position sensor information.
 */
void ece212_lafbot_setup	(){
    SYSTEMConfigPerformance(40000000);

    // Set all inputs to digital pins (as opposed to analog)
    ANSELA = 0; ANSELB = 0; CM1CON = 0; CM2CON = 0;
    // Set RB 13 & 14 as analog inputs
    ANSELB = 0x6000;
    //PORT PWM (1=input, 0=output))
    TRISA = 0x0000;
    //SWs RB8-11 input
    //LED RB0-3 output
    //RB 13 & 14 input
    TRISB = 0xFFF0;

    //Setup peripherals to enable PWM
    //Timer2: PWM basis with 16-bit resolution and 1x prescaler.
    //~610.4Hz output is fast enough to avoid jitter, but slow enough to offer resolution.
    T2CON = 0x8000;
    PR2 = 0xFFFF;

    OC1RS = 0x0; //set to 0 width initially
    OC1R  = 0xFFFF;  //set Period
    OC1CON = 0x8006; //PWM mode, 16-bit, fault disabled, start.
    OC2RS = 0x0; //set to 0 width initially
    OC2R  = 0xFFFF;  //set Period
    OC2CON = 0x8006;
    OC3RS = 0x0; //set to 0 width initially
    OC3R  = 0xFFFF;  //set Period
    OC3CON = 0x8006;
    OC4RS = 0x0; //set to 0 width initially
    OC4R  = 0xFFFF;  //set Period
    OC4CON = 0x8006;

    PPSOutput(1, RPA0, OC1);
    PPSOutput(2, RPA1, OC2);
    PPSOutput(4, RPA3, OC3);
    PPSOutput(3, RPA4, OC4);
    //OUT_PIN_PPS1_RPB7 = OUT_FN_PPS1_OC1;
    //End PWM setup

    //ADC: sample, then autoconvert a single channel
    AD1CON1CLR = 0x8000;    // disable ADC before configuration
    AD1CON1    = 0x00E0;    // internal counter ends sampling and starts conversion (auto-convert), manual sample
    AD1CON2    = 0;         // AD1CON2<15:13> set voltage reference to pins AVSS/AVDD
    AD1CON3    = 0x0F01;    // TAD = 4*TPB, acquisition time = 15*TAD
    AD1CON1SET = 0x8000;

    //Timer4/5: 32-bit delay timer. 64x divider on internal 40MHZ clock
    T5CONCLR = 0xFFFF;
    T4CONCLR = 0xFFFF;
    T4CON    = 0x8068;
    PR4 =  0xFFFFFFFF;

}

//Delay function with millisecond resolution and 1.9 hour range.
void delayms(int time) {
    TMR4 = 0x00000000;
    //TIMER4 runs at 625kHz, so 1ms = 625 ticks
    int threshold = (time * 625);
    while (TMR4 < threshold);
}

//Read analog voltage on analogPIN
//Returns 10 bit sample in 0-3.3V range
int analogRead(char analogPIN){
    AD1CHS = analogPIN << 16;       // AD1CHS<16:19> controls which analog pin goes to the ADC
    Nop();
    AD1CON1bits.SAMP = 1;           // Begin sampling
    while( AD1CON1bits.SAMP );      // wait until acquisition is done
    while( ! AD1CON1bits.DONE );    // wait until conversion done

    return ADC1BUF0;                // result stored in ADC1BUF0
}

#ifdef	__cplusplus
}
#endif

#endif	/* ECE212_H */