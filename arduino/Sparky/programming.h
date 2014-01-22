boolean active = false;
String incoming;

void configure(int state)
{
  int states = 112;
  long color;
  switch(state)
  {
    // red
    case 0:
      color = 16711680;
    break;
    // orange    
    case 1:
      color = 16737792;    
    break;
    // yellow    
    case 2:
      color = 16776960;    
    break;
    // green or white    
    case 3:
      // green 65280
      // white 16777215
      readIO();
      color = 65280;
      if(address == states)
      {
        color = 16777215;
        configurator = true;
      }
    break;    
  }
  
  displayIO(states, color);
}

/*
** @method programming
** @description this is a watcher for the serial event automatically opens serial
** 
*/
void programming()
{
  if(!active)
  {
    Serial.begin(115200);
    active = true;
  }
  
  int address;
  long color;
  int* rgb;
  String command;
  
  if(Serial.available() > 0)
  {
    command = Serial.readStringUntil(' ');
    
    if(command.equals("set"))
    {
      address = Serial.parseInt()*4;
      color = Serial.parseInt();
      rgb = getRGB(color);     
      
      Serial.print("previously stored:");
      Serial.println(EEPROM.readLong(address));
          
      Serial.print("changing stored:");
      Serial.print(address/4);
      Serial.print("\tto:");
      Serial.print(color);
      Serial.print("\thex:");
      Serial.print(getHEX(color));
      Serial.print("\trgb:(");
      Serial.print(rgb[0]);
      Serial.print(",");
      Serial.print(rgb[1]);
      Serial.print(",");
      Serial.print(rgb[2]);    
      Serial.println(")");
      Serial.flush();
      
      EEPROM.writeLong(address, color);
      delay(50);
      Serial.print("reading stored:");
      Serial.println(EEPROM.readLong(address));
      Serial.println("-------------------------------");      
    }
    else
    {
      Serial.print("running:");
      Serial.println(command);      

      if(command.equals("erase"))
      {
        for(int n = 0; n < 1020; n+=4)
        {
          EEPROM.writeLong(n, empty);
          delay(10);
        }
      }
      
      if(command.equals("get"))
      {
        address = Serial.parseInt()*4;
        color = EEPROM.readLong(address);
        rgb = getRGB(color);
        
        Serial.print("reading stored:");
        Serial.print(address/4);
        Serial.print("\tlong:");
        Serial.print(color);
        Serial.print("\thex:");
        Serial.print(getHEX(color));
        Serial.print("\trgb:(");
        Serial.print(rgb[0]);
        Serial.print(",");
        Serial.print(rgb[1]);
        Serial.print(",");
        Serial.print(rgb[2]);    
        Serial.println(")");        
      } 
      
      if(command.equals("print"))
      {
        for(int n = 0; n < 1020; n+=4)
        {
          Serial.print("reading address:");
          Serial.print(n/4);
          Serial.print("\tlong:");
          Serial.println(EEPROM.readLong(n));
        }
      }
      
      if(command.equals("random"))
      {
        for(int n = 0; n < 1020; n+=4)
        {
          EEPROM.writeLong(n, colors[random(0,13)]);
          delay(10);
        }
      }
      
      if(command.equals("byte"))
      {
         int d = 128;
         Serial.print(d);
         Serial.print(":");
         Serial.print(String(d,BIN));     
      }

      if(command.equals("press"))
      {
        int states = Serial.parseInt();
        incoming = getBin(states);
        
        Serial.print("reading states:");
        Serial.print(states);  
        Serial.print("\tincoming:");
        Serial.println(incoming);  
 
        for(int n = 0; n < count; n++)
        {
          char pin = incoming[n];
          pin == '0' ? digitalWrite(outputs[n], LOW) : digitalWrite(outputs[n], HIGH);
        }    
        
        //poll(states);        
      }
      
      if(command.equals("display"))
      {
        int states = Serial.parseInt();
        incoming = getBin(states);
        
        Serial.print("reading states:");
        Serial.print(states);  
        Serial.print("\tincoming:");
        Serial.println(incoming); 

        displayIO(states);        
      }      

      if(command.equals("help"))
      {
        help();         
      }     
    
      if(command.equals("reset"))
      {
        WDTCSR=(1<<WDE) | (1<<WDCE);
        WDTCSR= (1<<WDE);
        for(;;);
      }
      /*
      if(command.equals("debug"))
      {
        debug = Serial.parseInt();
        Serial.print("debug:");
        Serial.println(debug);        
      }
      */
      
      Serial.print(command);       
      Serial.println(" complete");  
      Serial.println("-------------------------------");      
    }
  }
}
