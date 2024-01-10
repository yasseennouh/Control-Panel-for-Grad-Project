import RPi.GPIO as GPIO

import time
from Adafruit_CharLCD import Adafruit_CharLCD
import Adafruit_DHT

# Define GPIO pins
DHT_PIN = 17  # GPIO pin for DHT sensor
RELAY1_PIN = 27
RELAY2_PIN = 22
LED_PINS = [18, 23, 24, 25]
MOTOR1_PINS = [20, 21]
MOTOR2_PINS = [16, 12]

# Initialize GPIO
GPIO.setmode(GPIO.BCM)
GPIO.setup(DHT_PIN, GPIO.IN)
GPIO.setup(RELAY1_PIN, GPIO.OUT)
GPIO.setup(RELAY2_PIN, GPIO.OUT)
for pin in LED_PINS + MOTOR1_PINS + MOTOR2_PINS:
    GPIO.setup(pin, GPIO.OUT)

# Initialize DHT sensor
DHT_SENSOR= Adafruit_DHT.DHT11

# Initialize LCD
lcd = Adafruit_CharLCD(rs=26, en=19,
                       d4=13, d5=6, d6=5, d7=11,
                       cols=16, lines=2)

def is_printable(c):
    return 32 <= ord(c) <= 126

try:
    while True:
        
        
        humidity , temperature = Adafruit_DHT.read(DHT_SENSOR, 17)
        
        if humidity is not None and temperature is not None:
            lcd.clear()
            lcd.cursor_pos = (1, 0)
            lcd.message(f"Temperature: {temperature}C")
            lcd.cursor_pos = (2, 0)
            lcd.message(f"Humidity: {humidity}%")
            print(ff"Temperature: {temperature} C\n Humidity: {humidity} %")


            if temperature >= 22:
                GPIO.output(RELAY1_PIN, GPIO.LOW)
            elif temperature <= 20:
                GPIO.output(RELAY1_PIN, GPIO.HIGH)
        if GPIO.input(RELAY1_PIN) == GPIO.LOW:
            lcd.se1t_cursor = (1, 15)
            lcd.message("AC: OFF")
        else:
            lcd.set_cursor = (1, 15)
            lcd.message("AC: ON")

        #if GPIO.input(RELAY2_PIN) == GPIO.LOW:
         #   lcd.cursor_pos = (1, 0)
         #   lcd.message("Lights: OFF")

        cmd = input("Enter command: ")

        if cmd.isdigit():
            cmd = int(cmd)
            if cmd == 0:
                GPIO.output(LED_PINS + MOTOR1_PINS + MOTOR2_PINS, GPIO.LOW)
                GPIO.output(RELAY1_PIN, GPIO.LOW)
                print("All devices turned off")
            elif cmd == 1 or cmd == 2:
                GPIO.output(LED_PINS[2 * (cmd - 1)], GPIO.HIGH)
                GPIO.output(LED_PINS[2 * (cmd - 1) + 1], GPIO.HIGH)
                print(f"Light row {cmd}: ON")
                #lcd.message("Light row 1: ON")
            elif 3 <= cmd <= 4:
                GPIO.output(LED_PINS[2 * (cmd - 3)], GPIO.LOW)
                GPIO.output(LED_PINS[2 * (cmd - 3) + 1], GPIO.LOW)
                print(f"Light row {cmd - 2}: OFF")
            elif 5 <= cmd <= 8:
                GPIO.output(RELAY1_PIN, GPIO.LOW)
                GPIO.output(RELAY2_PIN, GPIO.LOW)
                print("AC: OFF")
            elif cmd == 9:
                GPIO.output(MOTOR1_PINS[0], GPIO.LOW)
                GPIO.output(MOTOR1_PINS[1], GPIO.HIGH)
                time.sleep(5)
                GPIO.output(MOTOR1_PINS, GPIO.LOW)
                print("Curtains down")
            elif cmd == 10:
                GPIO.output(MOTOR1_PINS[0], GPIO.HIGH)
                GPIO.output(MOTOR1_PINS[1], GPIO.LOW)
                time.sleep(5)
                GPIO.output(MOTOR1_PINS, GPIO.LOW)
                print("Curtains up")
            elif cmd == 11:
                GPIO.output(MOTOR2_PINS[0], GPIO.HIGH)
                GPIO.output(MOTOR2_PINS[1], GPIO.LOW)
                time.sleep(5)
                GPIO.output(MOTOR2_PINS, GPIO.LOW)
                print("Projector mat down")
            elif cmd == 12:
                GPIO.output(MOTOR2_PINS[0], GPIO.LOW)
                GPIO.output(MOTOR2_PINS[1], GPIO.HIGH)
                time.sleep(5)
                GPIO.output(MOTOR2_PINS, GPIO.LOW)
                print("Projector mat up")
            else:
                print("Invalid command")
                
        lcd.clear()
        lcd.message("command: " + str(cmd))

except KeyboardInterrupt:
    pass

finally:
    GPIO.cleanup()

# pip install RPi.GPIO dht11 RPLCD