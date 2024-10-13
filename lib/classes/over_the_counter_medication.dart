import 'medication.dart';  // Import the Medication class

class OverTheCounterMedication extends Medication {
  final bool isControlled = false;  // Always set to false for OTC medications

  OverTheCounterMedication({
    required int id,
    required String name,
    required String time,
    required double dose,
    required String manufacturer,
  }) : super(id: id, name: name, time: time, dose: dose, manufacturer: manufacturer);

  @override
  void displayDetails() {
    super.displayDetails();
    print('Medication: $name, Controlled: $isControlled');
  }

  // Override toString method to customize string representation
  @override
  String toString() {
    return 'OverTheCounterMedication(id: $id, name: $name, dose: $dose, manufacturer: $manufacturer, controlled: $isControlled)';
  }
}
