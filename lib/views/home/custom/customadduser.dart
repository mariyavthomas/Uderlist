import 'package:brototypeuserlist/utils/custom_text.dart';
import 'package:brototypeuserlist/utils/custom_textformfiled.dart';
import 'package:flutter/material.dart';

class AddUser{
  // Builds a text input field with given parameters
  Widget buildInputField(String label, TextEditingController controller,
      TextInputType keyboardType, String? Function(String?) validator) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: label,
          color: Colors.grey,
        ),
        CustomTextFormField(
          controller: controller,
          keyboardType: keyboardType,
          validator: validator,
          hintText: "Enter the $label", // Hint text for the field
          padding: EdgeInsets.only(left: 5),
          width: 392,
          height: 44,
          enabledBorderColor: const Color.fromARGB(255, 200, 199, 199),
          focusedBorderColor: Colors.purple,
          errorBorderColor: Colors.red,
          borderRadius: 8.0,
          inputTextStyle:
              TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

   // Widget for image picker
  Widget buildImagePicker() {
    return Center(
      child: GestureDetector(
        onTap: () async {
          // Placeholder for image picker logic
          // await userProvider.pickImage();
        },
        child: CircleAvatar(
          radius: 40,
          backgroundColor: Colors.white,
          backgroundImage:
              AssetImage('assets/image/profile.png'), // Placeholder image
        ),
      ),
    );
  }
}