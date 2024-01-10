import serial
import time

bluetoothSerial= serial.Serial("/dev/serial0", baudrate=9600,timeout=1)
try:
    while True:
        
        data = bluetoothSerial.readline().decode("utf-8", errors="replace").rstrip()
        test = "tesstt"
        bluetoothSerial.write(test.encode("utf-8"))
        print(test)
        time.sleep(1)
except Exception as e:
    print("error ", e)
finally:
    bluetoothSerial.close()
