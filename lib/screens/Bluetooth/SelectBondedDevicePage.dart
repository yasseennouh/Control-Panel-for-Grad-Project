import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:collection/collection.dart';
import './BluetoothDeviceListEntry.dart';
import 'package:permission_handler/permission_handler.dart';

class SelectBondedDevicePage extends StatefulWidget {
  /// If true, on page start there is performed discovery upon the bonded devices.
  /// Then, if they are not avaliable, they would be disabled from the selection.
  final bool checkAvailability;

  const SelectBondedDevicePage({this.checkAvailability = true});

  @override
  _SelectBondedDevicePage createState() => new _SelectBondedDevicePage();
}

enum _DeviceAvailability {
  no,
  maybe,
  yes,
}

class _DeviceWithAvailability {
  BluetoothDevice device;
  _DeviceAvailability availability;
  int? rssi;
  _DeviceWithAvailability(this.device, this.availability, [this.rssi]);
}

class _SelectBondedDevicePage extends State<SelectBondedDevicePage> {
  List<_DeviceWithAvailability> devices = [];
  StreamSubscription<BluetoothDiscoveryResult>? _discoveryStreamSubscription;
  bool _isDiscovering = false;

  _SelectBondedDevicePage();

  @override
  void initState() {
    super.initState();

    _isDiscovering = widget.checkAvailability;

    if (_isDiscovering) {
      _startDiscovery();
    }

    // Setup a list of the bonded devices
    FlutterBluetoothSerial.instance
        .getBondedDevices()
        .then((List<BluetoothDevice> bondedDevices) {
      setState(() {
        devices = bondedDevices
            .map(
              (device) => _DeviceWithAvailability(
                device,
                widget.checkAvailability
                    ? _DeviceAvailability.maybe
                    : _DeviceAvailability.yes,
              ),
            )
            .toList();
      });
    });
  }

  void _restartDiscovery() {
    setState(() {
      _isDiscovering = true;
    });

    _startDiscovery();
  }

  void _startDiscovery() {
    setState(() {
      _isDiscovering = true;
    });
    _discoveryStreamSubscription =
        FlutterBluetoothSerial.instance.startDiscovery().listen((r) {
          setState(() {
            final alreadyDiscovered = devices.firstWhereOrNull(
                  (_device) => _device.device == r.device,
            );
            if (alreadyDiscovered == null) {
              devices.add(_DeviceWithAvailability(r.device, _DeviceAvailability.yes, r.rssi));
            }
          });
        });
    _discoveryStreamSubscription?.onDone(() {
      setState(() {
        _isDiscovering = false;
      });
    });
  }

  @override
  void dispose() {
    // Avoid memory leak (`setState` after dispose) and cancel discovery
    _discoveryStreamSubscription?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<BluetoothDeviceListEntry> list = devices
        .map((_device) => BluetoothDeviceListEntry(
      device: _device.device,
      rssi: _device.rssi ?? 0,
      enabled: _device.availability == _DeviceAvailability.yes,
      onTap: () {
        Navigator.of(context).pop(_device.device);
      },
      onLongPress: () {},
    ))
        .toList();
    return Scaffold(
      appBar: AppBar(
        title: Text('Select device'),
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            // ...
            ListTile(
              title: const Text('Devices discovery and connection'),
            ),
            ListTile(
              title: TextButton(
                child: const Text('Start Discovery'),
                onPressed: () async {

                  PermissionStatus status = await Permission.location.request();
                  if (status.isGranted) {
                    _startDiscovery();
                  } else {
                      Future<void> _showAlertDialog(BuildContext context) async {
                        await showDialog<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Bluetooth Error'),
                              content: Text('Please Allow Bluetooth to be connected'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

                  }
                },
              ),
            ),
            Column(children: list),
          ],
        ),
      ),
    );
  }
  }

