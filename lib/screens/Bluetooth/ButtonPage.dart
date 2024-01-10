import 'package:flutter/material.dart';

class ButtonPage extends StatelessWidget {
  final Function(String) sendMessageCallback;

  const ButtonPage({required this.sendMessageCallback});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manual Control'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => sendMessageCallback('0'),
                child: Text('Turn off all lights'),
              ),
              ElevatedButton(
                onPressed: () => sendMessageCallback('1'),
                child: Text('Turn on Row 1'),
              ),
              ElevatedButton(
                onPressed: () => sendMessageCallback('2'),
                child: Text('Turn on Row 2'),
              ),ElevatedButton(
                onPressed: () => sendMessageCallback('3'),
                child: Text('Turn off Row 1'),
              ),
              ElevatedButton(
                onPressed: () => sendMessageCallback('4'),
                child: Text('Turn off Row 2'),
              ),
              ElevatedButton(
                onPressed: () => sendMessageCallback('10'),
                child: Text('Curtains down'),
              ),
              ElevatedButton(
                onPressed: () => sendMessageCallback('11'),
                child: Text('Curtains up'),
              ),
              ElevatedButton(
                onPressed: () => sendMessageCallback('12'),
                child: Text('Projector mat down'),
              ),
              ElevatedButton(
                onPressed: () => sendMessageCallback('13'),
                child: Text('Projector mat up'),
              ),
              ElevatedButton(
                onPressed: () => sendMessageCallback('14'),
                child: Text('Presentation Mode'),
              ),
              ElevatedButton(
                onPressed: () => sendMessageCallback('15'),
                child: Text('Default Mode'),
              ),
              ElevatedButton(
                onPressed: () => sendMessageCallback('16'),
                child: Text('Power Off'),
              ),
              SizedBox(height: 20),
              // Add more buttons as needed
            ],
          ),
        ),
      ),
    );
  }
}
