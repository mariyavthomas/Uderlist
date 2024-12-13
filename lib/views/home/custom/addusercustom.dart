// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

class ShowMesg {
  // Shows a success message dialog
  void showSuccessMsg(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        // Schedule a timer to close the dialog after 1 second
        Future.delayed(const Duration(seconds: 1), () {
          if (Navigator.of(context).canPop()) {
            Navigator.of(context).pop(); // Closes the dialog
          }
        });

        return AlertDialog(
          backgroundColor: Colors.green,
          content: const Text(
            'User added successfully!',
            style: TextStyle(color: Colors.white),
          ),
        );
      },
    );
  }

  // Shows an error dialog if the input is invalid
  void showErrorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: const Text('Please enter valid data'),
        );
      },
    );
  }
}
