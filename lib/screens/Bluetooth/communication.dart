import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
class Communication {
  //Bluetooth
  late FlutterBluetoothSerial fls;
  late BluetoothConnection connection;
  BluetoothState bluetoothState = BluetoothState.UNKNOWN;
  String result = '';
  // Connect to the device via Bluetooth
  Future<void> connectBl(address) async {
    try {
      connection = await BluetoothConnection.toAddress(address);
      print('Connected to the device');
      // Create a listener to receive data
      connection.input?.listen(onDataReceived).onDone(() {});
    } catch (error) {
      print('Cannot connect, exception occurred');
    }
  }
  // When receive information
  void onDataReceived(Uint8List data) {
    // Allocate buffer for parsed data
    int backspacesCounter = 0;
    data.forEach((byte) {
      if (byte == 8 || byte == 127) {
        backspacesCounter++;
      }
    });
    Uint8List buffer = Uint8List(data.length - backspacesCounter);
    int bufferIndex = buffer.length;
    // Apply backspace control character
    backspacesCounter = 0;
    for (int i = data.length - 1; i >= 0; i--) {
      if (data[i] == 8 || data[i] == 127) {
        backspacesCounter++;
      } else {
        if (backspacesCounter > 0) {
          backspacesCounter--;
        } else {
          buffer[--bufferIndex] = data[i];
        }
      }
    }
    // Create message if there is a new line character
    result = String.fromCharCodes(buffer);
  }
  // To send a message
  Future<void> sendMessage(String text) async {
    text = text.trim();
    if (text.length > 0) {
      try {
        connection.output.add(Uint8List.fromList(utf8.encode(text + "\r\n")));
        await connection.output.allSent;
      } catch (e) {
        // Handle error
      }
    }
  }
  Future<void> dispose() async {
    fls.setPairingRequestHandler(null);
    if (connection.isConnected) {
      connection.dispose();
      connection = null as BluetoothConnection;
    }
  }
}