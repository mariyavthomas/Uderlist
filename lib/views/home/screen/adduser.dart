import 'dart:io';
import 'package:brototypeuserlist/utils/custom_text.dart';
import 'package:brototypeuserlist/utils/validator.dart';
import 'package:brototypeuserlist/view_models/user_provider.dart';
import 'package:brototypeuserlist/views/home/custom/buildbutton.dart';
import 'package:brototypeuserlist/views/home/custom/customadduser.dart';
import 'package:flutter/material.dart';

class AddtoUser {
  // ignore: unused_field
  File? _selectedImage;

  // Shows a dialog to add a new user
  void showAddUserDialog(BuildContext context, UserProvider userProvider) {
    final nameController = TextEditingController();
    final ageController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          titlePadding: EdgeInsets.only(right: 10, top: 9),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: CustomText(
            text: "Add A New User",
            fontWeight: FontWeight.w700,
            fontSize: 13,
            color: Color.fromRGBO(0, 0, 0, 1),
          ),
          contentPadding: EdgeInsets.only(right: 10),
          content: _buildDialogContent(nameController, ageController),
          actions: [
            Buttons().buildCancelButton(context),
            Buttons().buildSaveButton(
                context, userProvider, nameController, ageController),
          ],
        );
      },
    );
  }

  // Builds the content part of the dialog
  Widget _buildDialogContent(TextEditingController nameController,
      TextEditingController ageController) {
    return Container(
      width: 392,
      height: 270,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AddUser().buildImagePicker(), // Image picker for profile picture
          SizedBox(height: 20),
          AddUser().buildInputField("Name", nameController, TextInputType.text,
              (value) => Validator().nameValidator(value)),
          SizedBox(height: 10),
          AddUser().buildInputField("Age", ageController, TextInputType.number,
              (value) => Validator().ageValidator(value)),
        ],
      ),
    );
  }
}
