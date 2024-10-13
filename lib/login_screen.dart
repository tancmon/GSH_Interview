import 'package:flutter/material.dart';
import 'classes/medication.dart';  // Import the Medication class
import 'classes/medication_manager.dart';  // Import the MedicationManager class
import 'package:flutter/services.dart' show rootBundle;

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return await _showExitConfirmation(context);  // Ask for confirmation before exiting
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Login'),
          backgroundColor: Colors.blue,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () async {
              bool shouldExit = await _showExitConfirmation(context);
              if (shouldExit) {
                Navigator.of(context).pop();  // Exit the app or go back to previous screen
              }
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Add the image above the TextFields
              Image.asset(
                'lib/images/pills_art.jpg',
                height: 150,  // Set desired height
                width: 150,   // Set desired width
                fit: BoxFit.cover,  // Fit the image nicely
              ),
              SizedBox(height: 16),  // Add some spacing between the image and text fields
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 16),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _passwordVisible ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  ),
                ),
                obscureText: !_passwordVisible,  // Hide or show password
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  String email = emailController.text.trim();
                  String password = passwordController.text.trim();

                  // Verify login
                  if (await verifyLogin(email, password)) {
                    // Load medications from file
                    MedicationManager medicationManager = MedicationManager();
                    await medicationManager.loadMedicationsFromFile(); // Ensure this method exists
                    List<Medication> medications = medicationManager.getMedications();

                    // Navigate to the home screen and pass the medication list
                    Navigator.pushReplacementNamed(context, '/home', arguments: medications);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Login failed. Invalid email or password.'),
                    ));
                  }
                },
                child: Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Method to verify login against accounts.txt
  Future<bool> verifyLogin(String email, String password) async {
    try {
      final fileContent = await rootBundle.loadString('lib/saves/accounts.txt');
      List<String> lines = fileContent.split('\n');

      for (var line in lines) {
        if (line.trim().isNotEmpty) {
          List<String> accountDetails = line.split(',');
          if (accountDetails.length == 2) { // Ensure there are exactly 2 parts (email, password)
            String accountEmail = accountDetails[0].trim();
            String accountPassword = accountDetails[1].trim();

            // Check email (case insensitive) and password
            if (accountEmail.toLowerCase() == email.toLowerCase() && accountPassword == password) {
              return true; // Successful login
            }
          }
        }
      }
    } catch (e) {
      print("Error reading the accounts file: $e"); // just in case
    }
    return false; // Login failed
  }

  // Method to show an exit confirmation dialog
  Future<bool> _showExitConfirmation(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Exit App"),
          content: Text("Are you sure you want to exit the app?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);  // User pressed 'No'
              },
              child: Text("No"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);  // User pressed 'Yes' to exit
              },
              child: Text("Yes"),
            ),
          ],
        );
      },
    ) ?? false;  // Return false if dialog is dismissed
  }
}
