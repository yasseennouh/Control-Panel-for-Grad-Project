import 'package:flutter/material.dart';

class AcControl extends StatefulWidget {
  final Function(String) sendMessageCallback;
  final String message;

  const AcControl({
    required this.sendMessageCallback,
    required this.message,
  });
  @override

  _AcControlState createState() => _AcControlState();
}

class _AcControlState extends State<AcControl> {
  // Placeholder values for temperature and humidity

  double temperature = 0.0;
  double humidity = 0.0;

  @override
  void initState() {
    super.initState();

    // Call the function when the widget is initialized
    updateTemperatureHumidity(widget.message);
  }

  @override
  void didUpdateWidget(covariant AcControl oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Call the function when the 'message' property changes
    if (widget.message != oldWidget.message) {
      updateTemperatureHumidity(widget.message);
    }
  }

  // Function to update temperature and humidity based on message content
  void updateTemperatureHumidity(String _message) {
    // Convert the message to lowercase for case-insensitive matching
    String lowerCaseMessage = _message.toLowerCase();

    // Regular expression to match temperature and humidity values
    RegExp regex = RegExp(r'(\d+(\.\d+)?)');

    // Match temperature and humidity values
    List<String> matches = regex.allMatches(lowerCaseMessage).map((match) => match.group(0)!).toList();

    if (matches.length >= 2) {
      setState(() {
        temperature = double.tryParse(matches[0]) ?? 0.0;
        humidity = double.tryParse(matches[1]) ?? 0.0;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Temperature and Humidity'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Temperature: $temperature°C\nHumidity: $humidity%',
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                widget.sendMessageCallback('6');
              },
              child: Text('AC On'),
            ),
            ElevatedButton(
              onPressed: () {
                widget.sendMessageCallback('5');
              },
              child: Text('AC Off'),
            ),
            ElevatedButton(
              onPressed: () {
                widget.sendMessageCallback('7');
              },
              child: Text('AC Low'),
            ),
            ElevatedButton(
              onPressed: () {
                widget.sendMessageCallback('8');
              },
              child: Text('AC Medium'),
            ),
            ElevatedButton(
              onPressed: () {
                widget.sendMessageCallback('9');
              },
              child: Text('AC High'),
            ),
          ],
        ),
      ),
    );
  }

}