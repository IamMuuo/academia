import 'package:flutter/services.dart';

String? validateAdmissionNumberInput(String? value) {
  // Define the pattern: two digits, a dash, and four digits
  final pattern = RegExp(r'^\d{2}-\d{4}$');

  if (value == null || value.isEmpty) {
    return 'Input is required';
  } else if (!pattern.hasMatch(value)) {
    return 'Invalid format (use: xx-xxxx)';
  }
  return null; // Valid input
}

class AdmnoDashFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final newText = newValue.text;

    // Automatically insert a dash after the first two digits
    if (newText.length == 2 && !newText.contains('-')) {
      return TextEditingValue(
        text: '$newText-',
        selection: const TextSelection.collapsed(offset: 3),
      );
    }

    // Prevent additional dashes or incorrect input
    return newValue;
  }
}

class KenyanPhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Remove any non-digit characters except the '+' sign
    String sanitized = newValue.text.replaceAll(RegExp(r'[^0-9+]'), '');

    // If input starts with +254, keep it
    if (sanitized.startsWith('+254')) {
      // Keep only the first 13 characters (+254 followed by 9 digits)
      if (sanitized.length > 13) {
        sanitized = sanitized.substring(0, 13);
      }
    } else {
      // If it doesn't start with +254, reset to empty
      sanitized = '';
    }

    return TextEditingValue(
      text: sanitized,
      selection: TextSelection.collapsed(offset: sanitized.length),
    );
  }
}

class EmailInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Define a regex for a basic email validation that ends with @daystar.ac.ke
    final emailRegExp = RegExp(r'^[a-zA-Z0-9._%+-]+@daystar\.ac\.ke$');

    // If the new value is empty, return it
    if (newValue.text.isEmpty) {
      return newValue;
    }

    // Check if the input matches the email regex
    if (emailRegExp.hasMatch(newValue.text)) {
      return newValue; // Input is valid, allow it
    }

    // If input is invalid, return the old value
    return oldValue;
  }
}
