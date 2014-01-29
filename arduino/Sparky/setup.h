/*
** @desc this file is used set all the required information to run in specific modes
*/

/*
** @define (LEO|UNO|JOY|RAZER)
** @desc LEO = Arduino Leonardo
** @desc SPARKY = SparkyJrFTDI
** @desc UNO = Arduino UNO
** @desc JOY = Arduino Joystick Shield
** @desc RAZER = Razer Atrox Arcade Stick
*/
#define RAZER

/*
** @desc play intro intro
** @param intro {boolean}
*/
#define INTRO false;

/*
** @define (ANODE|CATHODE)
** @desc ANODE = Common Anode RGB LEDs
** @desc CATHODE = Common Cathode RGB LEDs
*/
#define ANODE

/*
** @desc configurator mode
** @param configurator {boolean}
*/
boolean configurator = false;

/*
** @note below are two layouts, madcatz and hori
** if you select one of the modes, there are no fades
**
**
**
** @desc madcatz fightstick layout for xbox
** @param configurator {boolean}
*                                                   
  .g8""8q.     .g8""8q.     .g8""8q.     .g8""8q.   
.dP'    `YM. .dP'    `YM. .dP'    `YM. .dP'    `YM. 
dM'      `MM dM'      `MM dM'      `MM dM'      `MM 
MM  BLUE  MM MM YELLOW MM MM        MM MM        MM 
MM.      ,MP MM.      ,MP MM.      ,MP MM.      ,MP 
`Mb.    ,dP' `Mb.    ,dP' `Mb.    ,dP' `Mb.    ,dP' 
  `"bmmd"'     `"bmmd"'     `"bmmd"'     `"bmmd"'   
                                                    
  .g8""8q.     .g8""8q.     .g8""8q.     .g8""8q.   
.dP'    `YM. .dP'    `YM. .dP'    `YM. .dP'    `YM. 
dM'      `MM dM'      `MM dM'      `MM dM'      `MM 
MM GREEN  MM MM  RED   MM MM        MM MM        MM 
MM.      ,MP MM.      ,MP MM.      ,MP MM.      ,MP 
`Mb.    ,dP' `Mb.    ,dP' `Mb.    ,dP' `Mb.    ,dP' 
  `"bmmd"'     `"bmmd"'     `"bmmd"'     `"bmmd"'   
                 
*/
boolean MADCATZ_LAYOUT = false;

/*
** @desc hori fightstick layout for xbox
** @param configurator {boolean}

  .g8""8q.     .g8""8q.     .g8""8q.     .g8""8q.   
.dP'    `YM. .dP'    `YM. .dP'    `YM. .dP'    `YM. 
dM'      `MM dM'      `MM dM'      `MM dM'      `MM 
MM  RED   MM MM  BLUE  MM MM YELLOW MM MM        MM 
MM.      ,MP MM.      ,MP MM.      ,MP MM.      ,MP 
`Mb.    ,dP' `Mb.    ,dP' `Mb.    ,dP' `Mb.    ,dP' 
  `"bmmd"'     `"bmmd"'     `"bmmd"'     `"bmmd"'   
                                                    
  .g8""8q.     .g8""8q.     .g8""8q.     .g8""8q.   
.dP'    `YM. .dP'    `YM. .dP'    `YM. .dP'    `YM. 
dM'      `MM dM'      `MM dM'      `MM dM'      `MM 
MM GREEN  MM MM        MM MM        MM MM        MM 
MM.      ,MP MM.      ,MP MM.      ,MP MM.      ,MP 
`Mb.    ,dP' `Mb.    ,dP' `Mb.    ,dP' `Mb.    ,dP' 
  `"bmmd"'     `"bmmd"'     `"bmmd"'     `"bmmd"'   

*/
boolean HORI_LAYOUT = false;


/*
** @desc these are the RGB color arrays
** @param xrgb {int*}
** @param rgb {int[]}
** @param prgb {int[]}
** @param in {int[]}
** @param out {int[]}
*/
int* xrgb;
int rgb[] = {0,0,0};
int prgb[] = {0,0,0};
int in[] = {0,0,0};
int out[] = {0,0,0};


/*
** @desc assign eeprom values
** @param empty = this is the null checker
*/
PROGMEM long int empty = 4294967295;
int addressLong;
PROGMEM int addressMax = 1016;


/*
** @desc IO
*/
int address;
int states[] = {0,0,0,0,0,0,0,0};
int stored[] = {0,0,0,0,0,0,0,0};
String state;
float duration = 250;
float now = millis();
float changed = now;

/*
** @desc settings for on and off of digital pin states
*/
#ifdef ANODE
  int ON = HIGH;
  int OFF = LOW;
#endif
#ifdef CATHODE
  int ON = LOW;
  int OFF = HIGH;
#endif

/*
** @desc declare inputs, outputs and pwm IO pins
*/
#ifdef RAZER
  const int inputs[] = {0,15,1,18,19,14,16,17};
  const int outputs[] = {6,7,8,12,2,3,4,5};
  const int pwm[] = {9,10,11};
#endif

#ifdef SPARKY
  const int inputs[] = {0,1,2,3,4,5,6,7};
  const int outputs[] = {18,17,16,15,14,13,12,8};
  const int pwm[] = {9,10,11};
#endif

#ifdef UNO
  const int inputs[] = {0,1,2,3,4,5,6,7};
  const int outputs[] = {18,17,16,15,14,13,12,8};
  const int pwm[] = {9,10,11};
#endif

#ifdef LEO
  const int inputs[] = {3,2,0,1,4,12,6,8};
  const int outputs[] = {23,22,21,20,19,18,13,5};
  const int pwm[] = {9,10,11};
#endif

/*
** @desc count of LEDs
*/
PROGMEM int count = 8;