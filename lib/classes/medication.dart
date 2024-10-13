class Medication {
  final int id;
  String _name;           // Make name private
  String _time;          // Make time private
  double _dose;          // Make dose private
  String _manufacturer;  // Private field for manufacturer

  // Constructor with named parameters, including manufacturer
  Medication({
    required this.id,
    required String name,
    required String time,
    required double dose,
    required String manufacturer,
  })  : _name = name,            // Initialize name
        _time = time,            // Initialize time
        _dose = dose,            // Initialize dose
        _manufacturer = manufacturer;  // Initialize manufacturer

  // Getter for name
  String get name => _name;

  // Setter for name with validation
  set name(String value) {
    if (value.isEmpty) {
      throw ArgumentError('Name cannot be empty.');
    }
    _name = value;
  }

  // Getter for time
  String get time => _time;

  // Setter for time with validation
  set time(String value) {
    if (value.isEmpty) {
      throw ArgumentError('Time cannot be empty.');
    }
    _time = value;
  }

  // Getter for dose
  double get dose => _dose;

  // Setter for dose with validation
  set dose(double value) {
    if (value <= 0) {
      throw ArgumentError('Dose must be greater than zero.');
    }
    _dose = value;
  }

  // Getter for manufacturer
  String get manufacturer => _manufacturer;

  // Setter for manufacturer with validation
  set manufacturer(String value) {
    if (value.isEmpty) {
      throw ArgumentError('Manufacturer cannot be empty.');
    }
    _manufacturer = value;
  }

  // Method to display medication details
  void displayDetails() {
    print('Medication: $_name, Time: $_time, Dose: $_dose, Manufacturer: $_manufacturer');
  }
}
