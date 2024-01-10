from bluedot.btcomm import BluetoothServer
from signal import pause
import RPi.GPIO as GPIO
import time

GPIO.setwarnings(False)
GPIO.setmode(GPIO.BOARD)
led = 18
GPIO.setup(led, GPIO.OUT)
GPIO.output(led, GPIO.LOW)
def dataRecieved(data):
    if(data == '1'):
        GPIO.output(led, GPIO.HIGH)
s= BluetoothServer(dataRecieved)