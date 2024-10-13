import 'medication.dart';  // Import the Medication class

class IndividualMedicine extends Medication {
  DateTime manufacturingDate;
  DateTime expiryDate;
// idk what the app is used for. This would be useful maybe?
  IndividualMedicine({
    required int id,
    required String name,
    required String time,
    required double dose,
    required String manufacturer,
    required this.manufacturingDate,
    required this.expiryDate,  // Initialize dates
  }) : super(id: id, name: name, time: time, dose: dose, manufacturer: manufacturer);

  @override
  void displayDetails() {
    super.displayDetails();
    print('Manufacturing Date: $manufacturingDate, Expiry Date: $expiryDate');
  }

  bool isExpired() {
    return DateTime.now().isAfter(expiryDate);
  }
}
