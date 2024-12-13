import 'package:brototypeuserlist/models/newusermodel.dart';
import 'package:brototypeuserlist/utils/custom_elevation_button.dart';
import 'package:brototypeuserlist/view_models/user_provider.dart';
import 'package:brototypeuserlist/views/home/custom/addusercustom.dart';
import 'package:flutter/material.dart';

class Buttons {
  // Builds the Save button for the dialog

  Widget buildSaveButton(
      BuildContext context,
      UserProvider userProvider,
      TextEditingController nameController,
      TextEditingController ageController) {
    return RefreshIndicator(
      onRefresh: () async {
        // Placeholder for any future refresh logic
      },
      child: CustomElevatedButton(
        text: "Save",
        fontSize: 12,
        fontWeight: FontWeight.w500,
        backgroundColor: Color.fromRGBO(23, 130, 255, 1),
        fixedSize: Size(100, 20),
        borderRadius: 8,
        onPressed: () {
          final name = nameController.text;
          final age = ageController.text;

          if (name.isNotEmpty && age.isNotEmpty && int.tryParse(age) != null) {
            Navigator.of(context).pop(); // Closes the dialog
            ShowMesg().showSuccessMsg(context); // Shows success message
            final ageuser = int.parse(age);
            userProvider.addUser(
              context: context,
              userlist: NewUserModel(
                name: name,
                age: ageuser,
              ),
            );
            userProvider.refreshUserList(); // Refreshes the user list
            userProvider.fetchUserData(); // Fetches updated user data
            WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback(
                (_) {}); // Ensures actions after UI update
          } else {
            ShowMesg().showErrorDialog(
                context); // Shows error dialog for invalid input
          }
        },
      ),
    );
  }

// Builds the Cancel button for the dialog
  Widget buildCancelButton(BuildContext context) {
    return CustomElevatedButton(
      borderRadius: 8,
      text: "Cancel",
      textColor: Color.fromRGBO(70, 70, 70, 1),
      fontWeight: FontWeight.w500,
      fontSize: 12,
      fixedSize: Size(100, 20),
      onPressed: () {
        Navigator.pop(context); // Closes the dialog
      },
      backgroundColor: Color.fromRGBO(225, 225, 225, 1),
    );
  }
}
