import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Main.dart',
      home: Scaffold(
        appBar: AppBar(title: Text('Main.dart')),
        body: Center(
          child: Text('Main.dart', style: TextStyle(fontSize: 24)),
        ),
      ),
    );
  }
}
