import 'package:flutter/material.dart';
import 'classes/medication.dart';  // Import the Medication class
import 'classes/medication_manager.dart';  // Import the MedicationManager class

class HomeScreen extends StatefulWidget {
  final List<Medication> medications;  // Add this parameter

  HomeScreen({required this.medications});  // Constructor to accept medications

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    List<Medication> medications = widget.medications;  // Access medications

    return Scaffold(
      appBar: AppBar(
        title: Text('Medications'),
        // This is for the back button
        leading: IconButton(
          icon: Icon(Icons.arrow_back),  // Back arrow icon
          onPressed: () {
            _showLogoutConfirmationDialog(context);  // Show confirmation dialog
          },
        ),
      ),
      body: ListView.builder(
        // Displaying the values
        itemCount: medications.length,
        itemBuilder: (context, index) {
          Medication medication = medications[index];
          return ListTile(
            title: Text(medication.name),
            subtitle: Text('Time: ${medication.time}, Dose: ${medication.dose}mg, Manufacturer: ${medication.manufacturer}'),
          );
        },
      ),
    );
  }

  // Method to show the logout confirmation dialog
  Future<void> _showLogoutConfirmationDialog(BuildContext context) async {
    bool? confirmLogout = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Logout"), // Simple logout text
          content: Text("Are you sure you want to log out?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);  // Dismiss the dialog and do not log out
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);  // Confirm logout
              },
              child: Text("Logout"),
            ),
          ],
        );
      },
    );

    if (confirmLogout == true) {
      Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);  // Navigate to login screen and remove all routes
    }
  }
}
