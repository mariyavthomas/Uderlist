class Validator {
   //-----------------------------------name---------------------------
  String? nameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    }

    return null;
  }
  //-----------------------------------number---------------------------
  String? numberValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a number';
    }

    if (!RegExp(r'^\+\d{1,3}\d{4,}$').hasMatch(value)) {
      return 'Please enter a valid number with country code';
    }
    return null;
  }
//-----------------------------------age---------------------------
String? ageValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your age';
  }

  final int? age = int.tryParse(value);
  if (age == null) {
    return 'Please enter a valid number';
  }

  if (age <= 0 || age > 150) {
    return 'Please enter a realistic age';
  }

  return null; // Validation passed
}

}