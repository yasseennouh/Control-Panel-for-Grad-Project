#refactored
import RPi.GPIO as GPIO
from gpiozero import LightSensor
import time
from Adafruit_CharLCD import Adafruit_CharLCD
import Adafruit_DHT
import serial
import detect

# Define Bluetooth communication
bluetoothSerial = serial.Serial("/dev/serial0", baudrate=9600, timeout=1)
ignore = False
auto_light = True
reset = False
projector = False
start_time = time.time()

# Messages to send
messages = ["All devices turned off", "Light row: ON", "Light row: OFF"]

# Define GPIO pins
LED_PINS = [18, 23, 24, 25]
MOTOR1_PINS = [21, 20]
MOTOR2_PINS = [16, 12]
AC1_PINS = [4, 22]
AC2_PINS = [9, 10]
ldr = LightSensor(27)

# Initialize GPIO
GPIO.setmode(GPIO.BCM)

# Initialize pins
for pin in LED_PINS + MOTOR1_PINS + MOTOR2_PINS + AC1_PINS + AC2_PINS:
    GPIO.setup(pin, GPIO.OUT)

GPIO.output(MOTOR1_PINS + MOTOR2_PINS, GPIO.LOW)

# Initialize DHT sensor
DHT_SENSOR = Adafruit_DHT.DHT11
DHT_pin = 17

# Initialize LCD
lcd = Adafruit_CharLCD(rs=26, en=19, d4=13, d5=6, d6=5, d7=11, cols=16, lines=2)


def is_printable(c):
    return 32 <= ord(c) <= 126


try:
    while True:
        cmd = bluetoothSerial.readline().decode("utf-8", errors="replace").rstrip()
        humidity, temperature = Adafruit_DHT.read(DHT_SENSOR, DHT_pin)

        if reset:
            start_time = time.time()
            elapsed_time = 0
            reset = False
        else:
            elapsed_time = time.time() - start_time

        if humidity is not None and temperature is not None:
            lcd.clear()
            if projector:
                lcd.message(f"Temperature: {temperature} C\nHumidity: {humidity}%")
            print(f"Temperature: {temperature} C\nHumidity: {humidity} %")

            if not ignore:
                if 27 >= temperature >= 25:
                    GPIO.output(AC1_PINS, [GPIO.LOW, GPIO.HIGH])
                    GPIO.output(AC2_PINS, [GPIO.LOW, GPIO.LOW])
                elif 25 > temperature >= 22:
                    GPIO.output(AC2_PINS, [GPIO.LOW, GPIO.HIGH])
                    GPIO.output(AC1_PINS, [GPIO.LOW, GPIO.LOW])
                elif 22 > temperature >= 20:
                    GPIO.output(AC1_PINS + AC2_PINS, GPIO.LOW)

        if ldr.value > 0.800:
            print("Natural Light Mode has been activated")
            GPIO.output(LED_PINS, GPIO.LOW)
            auto_light = False
        elif not projector:
            auto_light = True

        print(elapsed_time)

        if auto_light and elapsed_time > 30:
            detect.main()
            reset = True

        if cmd:
            if cmd.isdigit():
                cmd = int(cmd)

                if cmd == 0:
                    GPIO.output(LED_PINS + MOTOR1_PINS + MOTOR2_PINS, GPIO.LOW)
                    message = "All Devices: OFF"
                    bluetoothSerial.write(message.encode("utf-8"))
                elif 1 <= cmd <= 2:
                    GPIO.output(LED_PINS[2 * (cmd - 1):2 * (cmd - 1) + 2], GPIO.HIGH)
                    bluetoothSerial.write(messages[1].encode("utf-8"))
                elif 3 <= cmd <= 4:
                    GPIO.output(LED_PINS[2 * (cmd - 3):2 * (cmd - 3) + 2], GPIO.LOW)
                    bluetoothSerial.write(messages[2].encode("utf-8"))
                elif 5 <= cmd <= 9:
                    GPIO.output(AC1_PINS + AC2_PINS, GPIO.LOW)
                    if cmd == 5:
                        ignore = True
                    else:
                        ignore = False
                elif 10 <= cmd <= 15:
                    motor_pins = MOTOR1_PINS if 10 <= cmd <= 11 else MOTOR2_PINS
                    direction = GPIO.LOW if cmd % 2 == 0 else GPIO.HIGH
                    GPIO.output(motor_pins, [GPIO.HIGH, GPIO.LOW])
                    time.sleep(5)
                    GPIO.output(motor_pins, GPIO.LOW)
                    if cmd == 14:
                        auto_light = False
                        projector = True
                    elif cmd == 15:
                        auto_light = True
                        projector = False
                elif cmd == 16:
                    break
                else:
                    print("Invalid command")

except KeyboardInterrupt:
    pass

finally:
    GPIO.cleanup()
