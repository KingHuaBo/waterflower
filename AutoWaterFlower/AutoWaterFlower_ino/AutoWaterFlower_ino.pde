/*
Arduino 连接 DS1302
代码来源：http://quadpoint.org/projects/arduino-ds1302
增加了串口调整时间代码
*/
#include <stdio.h>
#include <string.h>
#include <DS1302.h>
//包含库的头文件，请把目录nokia5110放到arduino程序目录的libraries目录下，方便以后使用
#include <nokia5110.h>
/* 接口定义
CE(DS1302 pin5) -> Arduino D5
IO(DS1302 pin6) -> Arduino D6
SCLK(DS1302 pin7) -> Arduino D7
RELAY->Arduino D8
接线方式：
时钟：SCK/CLK	接 pin3
片选：DC	接 pin4
数据输入：Din	接 pin5
复位：RST	接 pin6
使能：SCE/CE	接 pin7
*/
uint8_t CE_PIN    = 8;
uint8_t IO_PIN    = 9;
uint8_t SCLK_PIN  = 10;
uint8_t RELAY_PIN = 11;
/* 创建 DS1302 对象 */
DS1302 rtc(CE_PIN, IO_PIN, SCLK_PIN);
Time clock;
//声明实例对象
static nokia5110 lcd;
/* 日期变量缓存 */
char buf[50]; 
void setup()
{
  //初始化LCD
   //第三个参数是对比度，有些屏幕全黑的要改成0xB5才行
   lcd.begin(84, 48,0xC8);
   //初始化Serial
  Serial.begin(9600);
  /* Initialize a new chip by turning off write protection and clearing the
     clock halt flag. These methods needn't always be called. See the DS1302
     datasheet for details. */
  rtc.write_protect(false);
  rtc.halt(false);

  /* Make a new time object to set the date and time */
  /*   Tuesday, May 19, 2009 at 21:16:37.            */
  Time t(2014,10,4,21,55,0,4);//

  /* Set the time and date on the chip */
  rtc.time(t);
  clock.day = 5;//set a Clock at every Wednesday 9a
  clock.hr =  9;
  clock.min = 0;
  clock.sec = 0;
  
  /*Set RELAY_PIN Mode*/
  pinMode(RELAY_PIN,OUTPUT);
  lcd.clear();
}
void loop()
{
    /* 从 DS1302 获取当前时间 */
    Time now = rtc.time();
     /* 将日期代码格式化凑成buf等待输出 */
    snprintf(buf, sizeof(buf), "%d,%d:%d:%d", now.day,now.hr, now.min, now.sec);
    /* 输出日期到串口 */
    Serial.println(buf);
    /* 输出日期到LCD5110 */
    //打印now.day
    lcd.setCursor(1, 1);
    lcd.print(now.day, DEC);
    //打印now.hr
    lcd.setCursor(1, 2);
    lcd.print(now.hr, DEC);
    //打印now.min
    lcd.setCursor(1, 3);
    lcd.print(now.min, DEC);
    //打印now.sec
    lcd.setCursor(1,4);
    lcd.print(now.sec, DEC);
    //delay(2500);  
    //lcd.clear();
    if(now.sec%5==0)
    {
      lcd.clear();
    }
    if(now.min%2==0 && now.sec==0)
    {
      //初始化LCD
      //第三个参数是对比度，有些屏幕全黑的要改成0xB5才行
      lcd.begin(84, 48,0xC8);
    }
    if(now.hr==clock.hr && now.min==clock.min && now.sec==clock.sec)//now.day==clock.day && 
    {
      digitalWrite(RELAY_PIN,HIGH);
      Serial.println("START");
    }
    if(now.hr==clock.hr && now.min==clock.min+4 && now.sec==clock.sec+30)//now.day==clock.day && 
    {
      digitalWrite(RELAY_PIN,LOW);
      Serial.println("END");
    }
    delay(990);//delay 20s
}


