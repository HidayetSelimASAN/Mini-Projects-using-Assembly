<br/>
<p align="center">
 <h1 align="center" id="title">Product of Prime Factors</h1>

  <p align="center">
    ✈An algorithm  to calculate product of prime factors of an unsigned integer number 
    <br/>
    <br/>
  </p>
</p>


## 💡Concepts Used in This Project

* 8051 microcontroller assembly language
* MCU 8051 IDE
* I/O ports
* Subroutines
* ASCII-Hex Conversion
* LCD Interference
* Keypad Interference
* Proteus Design Suite

## 🎯 Purpose

The aim of this project is to calculate product of prime factors of an unsigned integer number in range [0:255]. Input number will be taken from keypad. The result will be displayed on LCD.



## 🔓 Algorithm & Methodology

Input is taken from keypad digit by digit in ASCII. Each digit is converted to Hex by ADDing high byte with 0. After that, each digit is multiplied with corresponding digit values and added up.  

*For example:*

User presses keypad to send 255.   

32, 35, 35 (ASCII forms of number) is sent to microcontroller.  

We do the AND operations.   


  32 & 01 = 02  
  
  35 & 01 = 05  
  
  35 & 01 = 05  
  
Then number = 100 * 02 + 10 * 05 + 1 * 05 = 255 in Decimal

All prime numbers betwen 1 and 255 is stored in a Look-up-Table (LUT). Divisor itarates over the LUT.  





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
