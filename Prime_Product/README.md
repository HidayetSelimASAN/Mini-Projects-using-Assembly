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


  32h & 01h = 02h  
  
  35h & 01h = 05h 
  
  35h & 01h = 05h  
  
Then number = 100 * 02 + 10 * 05 + 1 * 05 = 255 in Decimal

All prime numbers betwen 1 and 255 are stored in a Look-up-Table (LUT). If a prime number divides the input number with no remainder, that number is a factor. Input number is divided by all prime numbers in LUT respectively. Divisor itarates over the LUT. First, Dividend is the input number. Then, each time when there is no remainder in division, dividend is updated as quotient of the last division with no remainder and the divisor is stored in stack. The process continues untill the dividend becomes 1. After this, Prime Factors stored in stack are popped and converted to ASCII. Finally, a appropriate output message is displayed on LCD. 





## 🎨 Design Specifications

For design convenience subroutines and Look-up-Tables are used. 0h is put to indicate the end of a LUT. All mathematical calculations are done in Register A because of the design specifications of 8051 microcontroller.  

## 🏆 Simulation Results

Product of Prime Factors of 45:
* 45 = (3 * 3 * 5)
  

![Screen Shot](images/PrimeFactor45.png)

Product of Prime Factors of 255:
* 45 = (3 * 5 * 17)
  
![Screen Shot](images/PrimeFactor255.png)



> *This simulation is done via MCU 8051 IDE*
