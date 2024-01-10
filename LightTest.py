from gpiozero import LightSensor, Buzzer
import RPi.GPIO as GPIO

LED_PIN1 = 18
GPIO.setmode(GPIO.BCM)
GPIO.setup(LED_PIN1, GPIO.OUT)
ldr = LightSensor(27)
while True:
    print(ldr.value)
    if ldr.value<0.700:
        GPIO.output(LED_PIN1, GPIO.HIGH)
    else:
        GPIO.output(LED_PIN1, GPIO.LOW)
GPIO.cleanup()
    