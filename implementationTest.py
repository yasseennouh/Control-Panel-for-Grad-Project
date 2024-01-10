import RPi.GPIO as GPIO
from gpiozero import LightSensor, Buzzer
import time
from Adafruit_CharLCD import Adafruit_CharLCD
import Adafruit_DHT
import serial
import detect


#define bluetooth commmunication
bluetoothSerial= serial.Serial("/dev/serial0", baudrate=9600,timeout=1)
ignore = False
autoLight = True
reset = False
projector = False
start_time= time.time()
#messages to send
messages=["All devices turned off","Light row: ON",f"Light row: OFF"]
# Define GPIO pins
LED_PINS = [18, 23, 24, 25]
MOTOR1_PINS = [21, 20]
MOTOR2_PINS = [16, 12]
AC1_PINS = [4, 22]
AC2_PINS = [9, 10]
ldr = LightSensor(27)

# Initialize GPIO
GPIO.setmode(GPIO.BCM)

for pin in LED_PINS + MOTOR1_PINS + MOTOR2_PINS + AC1_PINS + AC2_PINS:
    GPIO.setup(pin, GPIO.OUT)
GPIO.output(MOTOR1_PINS, GPIO.LOW)
GPIO.output(MOTOR2_PINS, GPIO.LOW)

# Initialize DHT sensor
DHT_SENSOR= Adafruit_DHT.DHT11
DHT_pin= 17
# Initialize LCD
lcd = Adafruit_CharLCD(rs=26, en=19,
                       d4=13, d5=6, d6=5, d7=11,
                       cols=16, lines=2)

def is_printable(c):
    return 32 <= ord(c) <= 126



try:
    while True:
        cmd = bluetoothSerial.readline().decode("utf-8", errors="replace").rstrip()
        humidity , temperature = Adafruit_DHT.read(DHT_SENSOR, DHT_pin)
        if reset == True:
            start_time = time.time()
            elapsed_time = time.time() - start_time
            reset = False
        else:
            elapsed_time = time.time() - start_time
        if humidity is not None and temperature is not None:
            lcd.clear()
            if projector == True:
                lcd.message(f"Temperature: {temperature} C\nHumidity: {humidity}%")
            print(f"Temperature: {temperature} C\n")
            print(f"Humidity: {humidity} %")
            if ignore == False:
                if temperature >= 27:
                    GPIO.output(AC1_PINS[0], GPIO.LOW)
                    GPIO.output(AC1_PINS[1], GPIO.HIGH)
                    GPIO.output(AC2_PINS[0], GPIO.LOW)
                    GPIO.output(AC2_PINS[1], GPIO.HIGH)

                elif 27>temperature >=25:
                    GPIO.output(AC1_PINS[0], GPIO.LOW)
                    GPIO.output(AC1_PINS[1], GPIO.HIGH)
                    GPIO.output(AC2_PINS[0], GPIO.LOW)
                    GPIO.output(AC2_PINS[1], GPIO.LOW)
                elif 25>temperature >=22:
                    GPIO.output(AC2_PINS[0], GPIO.LOW)
                    GPIO.output(AC2_PINS[1], GPIO.HIGH)
                    GPIO.output(AC1_PINS[0], GPIO.LOW)
                    GPIO.output(AC1_PINS[1], GPIO.LOW)
                elif 22>temperature <= 20:
                    GPIO.output(AC1_PINS[0], GPIO.LOW)
                    GPIO.output(AC1_PINS[1], GPIO.LOW)
                    GPIO.output(AC2_PINS[0], GPIO.LOW)
                    GPIO.output(AC2_PINS[1], GPIO.LOW)
        if ldr.value>0.800:
            print("Natural Light Mode has been activated")
            GPIO.output(LED_PINS, GPIO.LOW)
            autoLight=False
        elif projector == False:
            autoLight = True
            
        print(elapsed_time)
        if autoLight == True and elapsed_time>30:
            detect.main()
            reset = True

        if cmd:



            if cmd.isdigit():
                cmd = int(cmd)
                if cmd == 0:
                    GPIO.output(LED_PINS + MOTOR1_PINS + MOTOR2_PINS, GPIO.LOW)
                    message="All Devices: OFF"
                    bluetoothSerial.write(message.encode("utf-8"))
                elif cmd == 1 or cmd == 2:
                    GPIO.output(LED_PINS[2 * (cmd - 1)], GPIO.HIGH)
                    GPIO.output(LED_PINS[2 * (cmd - 1) + 1], GPIO.HIGH)
                    bluetoothSerial.write(messages[1].encode("utf-8"))

                    #lcd.message("Light row 1: ON")
                elif 3 <= cmd <= 4:
                    GPIO.output(LED_PINS[2 * (cmd - 3)], GPIO.LOW)
                    GPIO.output(LED_PINS[2 * (cmd - 3) + 1], GPIO.LOW)
                    bluetoothSerial.write(messages[2].encode("utf-8"))
                elif cmd==5:
                    GPIO.output(AC1_PINS[0], GPIO.LOW)
                    GPIO.output(AC1_PINS[1], GPIO.LOW)
                    GPIO.output(AC2_PINS[0], GPIO.LOW)
                    GPIO.output(AC2_PINS[1], GPIO.LOW)
                    ignore = True
                    print("AC: OFF")

                elif cmd==6:

                    GPIO.output(AC1_PINS[0], GPIO.LOW)
                    GPIO.output(AC1_PINS[1], GPIO.HIGH)
                    ignore = False

                    print("AC: ON")
                elif cmd==7:
                    GPIO.output(AC2_PINS[0], GPIO.LOW)
                    GPIO.output(AC2_PINS[1], GPIO.HIGH)
                    GPIO.output(AC1_PINS[0], GPIO.LOW)
                    GPIO.output(AC1_PINS[1], GPIO.LOW)
                    ignore = True
                    print("AC: LOW")
                elif cmd==8:
                    GPIO.output(AC1_PINS[0], GPIO.LOW)
                    GPIO.output(AC1_PINS[1], GPIO.HIGH)
                    GPIO.output(AC2_PINS[0], GPIO.LOW)
                    GPIO.output(AC2_PINS[1], GPIO.LOW)
                    ignore = True
                    print("AC: Medium")
                elif cmd==9:
                    GPIO.output(AC1_PINS[0], GPIO.LOW)
                    GPIO.output(AC1_PINS[1], GPIO.HIGH)
                    GPIO.output(AC2_PINS[0], GPIO.LOW)
                    GPIO.output(AC2_PINS[1], GPIO.HIGH)
                    ignore = True
                    print("AC: HIGH")
                elif cmd == 10:
                    GPIO.output(MOTOR1_PINS[0], GPIO.LOW)
                    GPIO.output(MOTOR1_PINS[1], GPIO.HIGH)
                    time.sleep(5)
                    GPIO.output(MOTOR1_PINS[0], GPIO.LOW)
                    GPIO.output(MOTOR1_PINS[1], GPIO.LOW)
                    print("Curtains down")
                elif cmd == 11:
                    GPIO.output(MOTOR1_PINS[0], GPIO.HIGH)
                    GPIO.output(MOTOR1_PINS[1], GPIO.LOW)
                    time.sleep(5)
                    GPIO.output(MOTOR1_PINS[0], GPIO.LOW)
                    GPIO.output(MOTOR1_PINS[1], GPIO.LOW)
                    print("Curtains up")
                elif cmd == 12:
                    GPIO.output(MOTOR2_PINS[0], GPIO.HIGH)
                    GPIO.output(MOTOR2_PINS[1], GPIO.LOW)
                    time.sleep(5)
                    GPIO.output(MOTOR2_PINS, GPIO.LOW)
                    print("Projector mat down")
                elif cmd == 13:
                    GPIO.output(MOTOR2_PINS[0], GPIO.LOW)
                    GPIO.output(MOTOR2_PINS[1], GPIO.HIGH)
                    time.sleep(5)
                    GPIO.output(MOTOR2_PINS, GPIO.LOW)
                    print("Projector mat up")
                elif cmd == 14:
                    GPIO.output(LED_PINS, GPIO.LOW)
                    time.sleep(2)
                    GPIO.output(MOTOR1_PINS[0], GPIO.LOW)
                    GPIO.output(MOTOR1_PINS[1], GPIO.HIGH)
                    time.sleep(2)
                    GPIO.output(MOTOR1_PINS, GPIO.LOW)
                    time.sleep(2)
                    GPIO.output(MOTOR2_PINS[0], GPIO.HIGH)
                    GPIO.output(MOTOR2_PINS[1], GPIO.LOW)
                    time.sleep(2)
                    GPIO.output(MOTOR2_PINS, GPIO.LOW)
                    autoLight=False
                    projector = True
                    print("Presentation Mode: ON")
                elif cmd == 15:
                    lcd.clear()
                    GPIO.output(MOTOR1_PINS[0], GPIO.HIGH)
                    GPIO.output(MOTOR1_PINS[1], GPIO.LOW)
                    time.sleep(2)
                    GPIO.output(MOTOR1_PINS, GPIO.LOW)
                    time.sleep(2)
                    GPIO.output(MOTOR2_PINS[0], GPIO.LOW)
                    GPIO.output(MOTOR2_PINS[1], GPIO.HIGH)
                    time.sleep(2)
                    GPIO.output(MOTOR2_PINS, GPIO.LOW)
                    autoLight=True
                    projector = False
                    print("Default Mode: ON")
                elif cmd == 16:
                    break
                
                
                else:
                    print("Invalid command")
        

except KeyboardInterrupt:
    pass

finally:
    GPIO.cleanup()

# pip install RPi.GPIO dht11 RPLCD