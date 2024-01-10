import RPi.GPIO as GPIO
import time

GPIO.cleanup()
MOTOR1_PIN1 = 21
MOTOR1_PIN2 = 20
MOTOR2_PIN1 = 16
MOTOR2_PIN2 = 12

GPIO.setmode(GPIO.BCM)

GPIO.setup(MOTOR1_PIN1, GPIO.OUT)
GPIO.setup(MOTOR1_PIN2, GPIO.OUT)
GPIO.setup(MOTOR2_PIN1, GPIO.OUT)
GPIO.setup(MOTOR2_PIN2, GPIO.OUT)

try:
    while True:
        GPIO.output(MOTOR1_PIN1, GPIO.LOW)
        GPIO.output(MOTOR1_PIN2, GPIO.HIGH)
        GPIO.output(MOTOR2_PIN1, GPIO.LOW)
        GPIO.output(MOTOR2_PIN2, GPIO.HIGH)
        time.sleep(2)
        GPIO.output(MOTOR1_PIN1, GPIO.HIGH)
        GPIO.output(MOTOR1_PIN2, GPIO.LOW)
        GPIO.output(MOTOR2_PIN1, GPIO.HIGH)
        GPIO.output(MOTOR2_PIN2, GPIO.LOW)
finally:
    GPIO.cleanup()
        