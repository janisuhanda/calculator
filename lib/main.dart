import 'package:flutter/material.dart';
import 'database_helper.dart';
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
      home: Initialisasi(),
    );
  }
}

class Initialisasi extends StatefulWidget {
  const Initialisasi({super.key});

  @override
  State<Initialisasi> createState() => _InitialisasiState();
}

class _InitialisasiState extends State<Initialisasi> {
  List<Map<String, dynamic>> myData = [];
  bool _isLoading = true;
  void _refreshData() async {
    final data = await DatabaseHelper.getHistories();
    setState(() {
      myData = data;
      _isLoading = false;
      print("mydata");
      print(myData);
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshData(); // Loading the data when the app starts
  }

  @override
  Widget build(BuildContext context) {
    return (_isLoading)
        ? Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : ScreenNol();
  }
}
