![SparkyJr icon](images/logo.png)

***

# Introduction

**SparkyJr.** is a programmable RGB LED mod companion light up activation controller for arcade pushbuttons on gaming fightsticks.

The hardware is based on AVR microcontrollers and programmed via [AVR Studio](http://www.atmel.ca/microsite/atmel_studio6/) or the [Arduino IDE](http://arduino.cc/en/Main/Software)

![Open Source icon](images/osh.png =50x)

**SparkyJr.** in it's entirety is open source. Including hardware design, software implementation and libraries
***
##Software
####![Arduino icon](images/arduino.png =25x) Arduino

**SparkyJr.** Arduino based files are located in the *[arduino](https://github.com/32teeth/SparkyJr/tree/gh-pages/arduino/Sparky)* folder

This includes all the files required to upload to your specific AVR chipset.

**SparkyJr** only has one library dependency. We make use of the [EEPROMx](https://github.com/autohome/autohome-arduino/tree/master/libraries/EEPROMx) library

*for help on installing libraries into the Arduino IDE, please visit the [how to](http://arduino.cc/en/Guide/Libraries) on the Arduino site

####![Processing icon](images/processing.jpg =25x) Processing
**SparkyJr.** Processing based files are located in the *[processing](https://github.com/32teeth/SparkyJr/tree/gh-pages/processing)* folder

This includes all the files required to run the configurator.

####![Google Chrome icon](images/chrome.jpeg =25x) Google Chrome App
**SparkyJr.**'s configurator is additionally available as a Google Chrome Application and is available unpackaged in the [google](https://github.com/32teeth/SparkyJr/tree/gh-pages/google) folder

***
##Hardware
####![Eagle Cad icon](images/eagle.png =25x) Eagle CAD
All of the PCB design, schema and board layout files where designed in [CadSoft's Eagle Cad PCB](http://www.cadsoftusa.com/eagle-pcb-design-software/product-overview/?language=en) software.

The .sch and .brd files are available in the [eagle](https://github.com/32teeth/SparkyJr/tree/gh-pages/eagle) folder.

####SparkyJr. hardware variants
*all versions are currenlty supported in the new SparkyJr software and configurator*

|  v1 | v2 (pwm)  | v3 (ftdi) (32u4)  | *v4* (current)  | v4 (expansion) |
|---|---|---|---|---|
|retired|retired|deprecated|current release|expansion board|
|  ![Arduino icon](images/sparky1.png =100x) |  ![Arduino icon](images/sparky2.png =100x) | ![Arduino icon](images/sparky3.png =100x)  |  ![Arduino icon](images/sparky4.png =100x) |  ![Arduino icon](images/sparky5.png =100x) |
|   |   |  ftdi [sch](https://github.com/32teeth/SparkyJr/blob/gh-pages/eagle/SparkyJr_v4FTDI.sch) [brd](https://github.com/32teeth/SparkyJr/blob/gh-pages/eagle/SparkyJr_v4FTDI.brd) |  [sch](https://github.com/32teeth/SparkyJr/blob/gh-pages/eagle/SparkySpecialK.sch) [brd](https://github.com/32teeth/SparkyJr/blob/gh-pages/eagle/SparkySpecialK.brd) | [sch](https://github.com/32teeth/SparkyJr/blob/gh-pages/eagle/SparkySpecialKExpansion.sch) [brd](https://github.com/32teeth/SparkyJr/blob/gh-pages/eagle/SparkySpecialKExpansion.brd)  |
|   |   |  32u4 [sch](https://github.com/32teeth/SparkyJr/blob/gh-pages/eagle/SparkyJr_v432u4.sch) [brd](https://github.com/32teeth/SparkyJr/blob/gh-pages/eagle/SparkyJr_v432u4.brd) |   |   |

***
## Arduino
![Arduino icon](images/arduino.png =100x)

Start up your Arduino IDE and open **Sparky.ino**
The only file you *need* to change settings in is the [setup.h](https://github.com/32teeth/SparkyJr/blob/gh-pages/arduino/Sparky/setup.h) file





