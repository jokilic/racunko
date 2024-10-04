import 'package:flutter/material.dart';

final currencyRegEx = RegExp(r'^\d*\.?\d{0,2}');

TextEditingValue currencyInputFormatter(oldValue, newValue) {
  try {
    final text = newValue.text;
    if (text.isEmpty) {
      return newValue;
    }

    /// Check for leading zero
    if (text.length > 1 && text.startsWith('0') && text[1] != '.') {
      return oldValue;
    }

    if (text.contains('.')) {
      final parts = text.split('.');
      if (parts.length > 2) {
        return oldValue;
      }
      if (parts[1].length > 2) {
        return oldValue;
      }
    }

    /// Ensure the value is a valid, positive number
    if (double.parse(text) <= 0) {
      return oldValue;
    }

    return newValue;
  } catch (e) {
    return oldValue;
  }
}
