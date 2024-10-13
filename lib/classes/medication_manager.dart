import 'package:flutter/services.dart' show rootBundle;
import 'medication.dart';  // Import the Medication class
import 'prescription_medication.dart';  // Import PrescriptionMedication class
import 'individual_medicine.dart';  // Import IndividualMedicine class

class MedicationManager {
  List<Medication> _medications = [];

  // Method to load medications from a text file
  Future<void> loadMedicationsFromFile() async {
    final fileContent = await rootBundle.loadString('lib/saves/medications.txt');
    List<String> lines = fileContent.split('\n');

    for (var line in lines) {
      if (line.trim().isNotEmpty) {
        List<String> details = line.split(',');
        int id = int.parse(details[0]);
        String name = details[1];
        String time = details[2];
        double dose = double.parse(details[3]);
        String manufacturer = details[4];

        _medications.add(Medication(
          id: id,
          name: name,
          time: time,
          dose: dose,
          manufacturer: manufacturer,
        ));
      }
    }
  }

  // Add a medication (works for all subclasses of Medication)
  void addMedication(Medication medication) {
    _medications.add(medication);
  }

  // Remove a medication by ID
  void removeMedication(int id) {
    _medications.removeWhere((med) => med.id == id);
  }
// Setter. Sets medication (name, time, dose, and manufacturer)
  void updateMedication(int id, String name, String time, double dose, String manufacturer) {
    for (var med in _medications) {
      if (med.id == id) {
        // Store original values to revert if needed
        String originalName = med.name;
        String originalTime = med.time;
        double originalDose = med.dose;
        String originalManufacturer = med.manufacturer;

        try {
          // Validate and update name
          med.name = name;  // Update name
          med.time = time;  // Update time
          med.dose = dose;  // Update dose
          med.manufacturer = manufacturer;  // Update manufacturer
        } catch (e) {
          // Revert changes if an error occurs
          med.name = originalName;
          med.time = originalTime;
          med.dose = originalDose;
          med.manufacturer = originalManufacturer;
        }
        break;  // Exit loop once the medication is found and attempted to be updated
      }
    }
  }


  // Get all medications
  List<Medication> getMedications() {
    return _medications;
  }

  // Optional I haven't tested this. Get medications of a specific type
  List<PrescriptionMedication> getPrescriptionMedications() {
    return _medications.whereType<PrescriptionMedication>().toList();
  }
}
