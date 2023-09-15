import 'package:flutter/material.dart';
import 'screen_nol.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CALCULATOR RECOGNITION',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ScreenNol(),
    );
  }
}
