import RPi.GPIO as GPIO
import Adafruit_CharLCD as LCD

rs = 25
en = 24
d4 = 13
d5 = 6
d6 = 5
d7 = 11

lcdColumns = 16
lcdRows= 2

lcd = LCD.Adafruit_CharLCD(rs, en ,d4,d5,d5,d7, lcdColumns, lcdRows)
lcd.message('test')
GPIO.cleanup()
