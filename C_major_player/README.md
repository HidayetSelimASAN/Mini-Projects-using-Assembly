<br/>
<p align="center">
 <h1 align="center" id="title">C Major Scale Player</h1>

  <p align="center">
    ✈An algorithm  to do play C major scale on 8051 microcontroller using interrupt and timer concepts
    <br/>
    <br/>
  </p>
</p>


## 💡Concepts Used in This Project

* 8051 microcontroller assembly language
* MCU 8051 IDE
* I/O ports
* Timer
* Interrupts

## 🎯 Purpose

The aim of this project is to play C major scale on 8051 microcontroller using external speaker. Each note is played for 0.5 seconds. After all 8 notes in the scale is played, loop starts again. 



## 🔓 Algorithm & Methodology

For C major scale, A440 pitch standard is used in this project. You may reach necessary frequencies for each note from this [link](https://pages.mtu.edu/~suits/notefreqs.html).  
There are 2 different timers in 8051. Timer0 is used to watch the frequency of a note with interrupt enabled. Values for required frequencies are stored in a LUT. Using to these values, a square wave with 50% duty cycle is produced in related frequency. Timer1 is used to watch 0.5s period for each note using polling. Since 16-bit timer was not large enough to measure 0.5s for 8051's clock frequency, Timer1 is set to overflow in each 0.05s. A counter(loaded with initial value 10) is decremented by one in each overflow giving us the required frequency 0.5s (0.05s * 10). After the all C major scale is played, program repeats itself. 





## 🎨 Design Specifications

A LUT starting from adress 1000h, is used to store frequncy values. Each frequency is read from ROM using MOVC instruction. Square wave is outputed from PORT1.1. Both Timer0 and Timer1 are initialized in 16 bit timer mode. Timer0 inturrupt is enabled. According to  interrupt vector table of 8051, program jumps to the adress 0x0030. Here, Timer0 registers are loaded with related frequncy value and PORT1.1 is complemented. R1 is the counter loaded with value 10 used in detecting 0.5s period. 

## 🏆 Simulation Results

not completed yet
 

## 🔎 Further Details

Under CodeFile

* You may check the C_major.asm file  to look at my assembly code. [here](CodeFile/C_major.asm)
* C_major.hex file is the related machine code. [here](CodeFile/C_major.hex)
  


