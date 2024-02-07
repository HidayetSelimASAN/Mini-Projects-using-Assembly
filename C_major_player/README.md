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
There are 2 different timers in 8051. Timer0 is used to watch the frequency of a note. Timer1 is used to watch 0.5s period for each note. 





## 🎨 Design Specifications

Dividend is an 16-bit number. Low byte stored in R0 and High byte stored in R1. Divisor is stored in R2. 

The total number of substractions are counted in R6.

The queotient is stored in R4:R3.

## 🏆 Simulation Results

The number 0x3226(R1:R0) is divided by number 0x08(R2):
* The quotient is 0x0644(R4:R3)
* The remainder is 0x06(R5)
* Calculation time 835µs

![Screen Shot](images/16_div_sim.png)



> *This simulation is done via MCU 8051 IDE*

## 🔎 Further Details

Under CodeFile

* You may check the 16bit_division.asm file  to look at my assembly code. [here](CodeFile/16bit_division.asm)
* 16bit_divison.hex file is the related machine code. [here](CodeFile/16bit_division.hex)
  


