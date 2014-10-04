
/*
NOKIA 5110
yoyo

接线方式：
时钟：SCK/CLK	接 pin3
片选：DC			接 pin4
数据输入：Din		接 pin5
复位：RST			接 pin6
使能：SCE/CE	接 pin7
 */

//包含库的头文件，请把目录nokia5110放到arduino程序目录的libraries目录下，方便以后使用
#include <nokia5110.h>


// 自定义的一个图案，是一个笑脸
static const byte glyph[] = { B00010000, B00110100, B00110000, B00110100, B00010000 };

//背景LED接的引脚
static const int BKPIN = 10;

//声明实例对象
static nokia5110 lcd;

void setup() {
   //初始化
   //第三个参数是对比度，有些屏幕全黑的要改成0xB5才行
   lcd.begin(84, 48,0xC8);

}
void loop() {
  // 移动光标到0，0点
  lcd.setCursor(1, 1);
  //打印一个
  lcd.print(1100, DEC);

  //移动光标到第二行的行首
  lcd.setCursor(1, 2);
  //打印数字（参数DEC表示采用10进制输出）
  lcd.print(100, DEC);
  //  //延迟
  delay(2500);  
  lcd.clear();
//  //空格
//  lcd.write(' ');
//  //打印自定义的笑脸图案
//  lcd.write(0);  
//  //延迟
//  delay(500);  
//  counter++;
}

