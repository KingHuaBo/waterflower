/*
Arduino 连接 DS1302
代码来源：http://quadpoint.org/projects/arduino-ds1302
增加了串口调整时间代码
*/
#include <stdio.h>
#include <string.h>
#include <DS1302.h>
/* 接口定义
CE(DS1302 pin5) -> Arduino D5
IO(DS1302 pin6) -> Arduino D6
SCLK(DS1302 pin7) -> Arduino D7
RELAY->Arduino D8
*/
uint8_t CE_PIN    = 5;
uint8_t IO_PIN    = 6;
uint8_t SCLK_PIN  = 7;
uint8_t RELAY_PIN = 8;
/* 创建 DS1302 对象 */
DS1302 rtc(CE_PIN, IO_PIN, SCLK_PIN);
Time clock;
void setup()
{
  Serial.begin(9600);
  
  /* Initialize a new chip by turning off write protection and clearing the
     clock halt flag. These methods needn't always be called. See the DS1302
     datasheet for details. */
  rtc.write_protect(false);
  rtc.halt(false);

  /* Make a new time object to set the date and time */
  /*   Tuesday, May 19, 2009 at 21:16:37.            */
  Time t(2009, 5, 19, 21, 16, 37, 3);

  /* Set the time and date on the chip */
  rtc.time(t);
  clock.day = 4;//set a Clock at every Wednesday 9a
  clock.hr =  9;
  clock.min = 0;
  clock.sec = 0;
}
void loop()
{
    delay(20000);//delay 20s
    /* 从 DS1302 获取当前时间 */
    Time now = rtc.time();
    if(now.day==clock.day && now.hr==clock.hr && now.min && now.sec==clock.sec)//
    {
      RELAY_PIN=1;
    }
    if(now.day==clock.day && now.hr==clock.hr && now.min && now.sec==clock.sec)
    {
      RELAY_PIN=0;
    }
}


