import 'package:brototypeuserlist/view_models/user_provider.dart';
import 'package:flutter/material.dart';

class Capitalize {
  //CapotalizeName Searching Funxtionality
  String capitalizeName(String name) {
    if (name.isEmpty) return name;
    return name
        .split(' ')
        .map((part) => part.isNotEmpty
            ? part[0].toUpperCase() + part.substring(1).toLowerCase()
            : part)
        .join(' ');
  }

  //option of the radio buttion
  Widget buildRadioOption(String title, String value, UserProvider userProvider,
      BuildContext context) {
    return RadioListTile(
      title: Text(title),
      value: value,
      groupValue: userProvider.selectedCategory,
      onChanged: (value) {
        userProvider.selectedCategory = value!;
        Navigator.pop(context);
      },
    );
  }

// show filtering alertbutton
  void showFilterOptions(BuildContext context, UserProvider userProvider) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Sort"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Capitalize()
                  .buildRadioOption("All", "all", userProvider, context),
              Capitalize().buildRadioOption(
                  "Younger", "younger", userProvider, context),
              Capitalize()
                  .buildRadioOption("Elder", "elder", userProvider, context),
            ],
          ),
        );
      },
    );
  }
}
