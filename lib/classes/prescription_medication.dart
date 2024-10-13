import 'medication.dart';  // Import the Medication class

class PrescriptionMedication extends Medication {
  String prescriptionId;
  final bool isControlled = true;  // Always set to false

  PrescriptionMedication({
    required int id,
    required String name,
    required String time,
    required double dose,
    required String manufacturer,
    required this.prescriptionId,
  }) : super(id: id, name: name, time: time, dose: dose, manufacturer: manufacturer);

  @override
  void displayDetails() {
    super.displayDetails();
    print('Prescription ID: $prescriptionId, Controlled: $isControlled');
  }
}
