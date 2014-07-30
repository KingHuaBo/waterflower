int jdqPin=7;//定义数字检测接
void setup()
{
  pinMode(jdqPin,OUTPUT);//设定数字接口13、12、11为输入接口
  Serial.begin(9600);//设置串口波特率为9600kbps
}
void loop()
{
digitalWrite(jdqPin,HIGH);
delay(5000);
digitalWrite(jdqPin,LOW);
delay(5000);
}
