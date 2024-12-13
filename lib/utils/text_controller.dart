import 'package:flutter/material.dart';

class StandardTextController {
  static TextEditingController create({String? initialValue}) {
    TextEditingController controller = TextEditingController();
    if (initialValue != null) {
      controller.text = initialValue;
    }
    return controller;
  }
}
