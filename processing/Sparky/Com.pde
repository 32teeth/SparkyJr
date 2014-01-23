/*
** @author Eugene Andruszczenko
** @version 0.1
** @date January 3rd, 2014
** @description interface for Arduino based SparkyFive
*/

class Com
{  
  /*
  ** @method setup
  ** @param command {String} (erase|print|reset|help)
  ** @description used to call and recieve serial commands to arduino
  */  
  void send(String command)
  {
    if(port.available() > 0)
    {
      port.write(command);
      recieve();
    }
  }

  /*
  ** @method set
  ** @description set a specific EEPROM address block value
  ** @param address {int} clr {long}
  ** @example set 127 12345
  */  
  void set(int address, long clr)
  {    
    if(open)
    {
      println("set " + address + " " + clr);
      port.write("set " + address + " " + clr);
      port.write("display " + address);
      delay(2500);
    }
  }

  /*
  ** @method get
  ** @description get a specific EEPROM address block value
  ** @param address {int}
  ** @example get 127
  */  
  void get(int address)
  {
    if(port.available() > 0)
    {
      port.write("get " + address);
      recieve();
    }
  }  

  /*
  ** @method press
  ** @description press a specific EEPROM address block value
  ** @param address {int}
  ** @example press 127
  */  
  void press(int address)
  {
    if(port.available() > 0)
    {
      port.write("set " + address);
      recieve();
    }
  }

  /*
  ** @method display
  ** @description display a specific EEPROM address block value
  ** @param address {int}
  ** @example display 127
  */  
  void display(int address)
  {
    if(port.available() > 0)
    {
      port.write("display " + address);
      recieve();
    }
  }    

  /*
  ** @method setup
  ** @param command {String} (erase|print|reset|help)
  ** @description used to recieve serial commands to arduino
  */  
  void recieve()
  {
    if(port.available() > 0)
    {
      println(port.read());     
    }
    
    while (port.available() > 0) {
      String inBuffer = port.readString();   
      if (inBuffer != null) {
        println(inBuffer);
      }
    }     
  }  
}
