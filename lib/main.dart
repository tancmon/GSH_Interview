import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'home_screen.dart';
import 'classes/medication.dart';  // Import the Medication class

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Medication App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
      },
      onGenerateRoute: (settings) {
        // Custom navigation logic for passing medications to HomeScreen
        if (settings.name == '/home') {
          final List<Medication> medications = settings.arguments as List<Medication>;
          return MaterialPageRoute(
            builder: (context) => HomeScreen(medications: medications),
          );
        }
        return null;
      },
    );
  }
}
