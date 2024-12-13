import 'package:brototypeuserlist/models/newusermodel.dart';
import 'package:brototypeuserlist/view_models/user_provider.dart';
import 'package:brototypeuserlist/views/home/custom/custom.dart';
import 'package:flutter/material.dart';

class Userlist {
  // Custom UserLis//

  Widget buildUserList(UserProvider userProvider, List images) {
    return StreamBuilder<List<NewUserModel>>(
      stream: userProvider.getFilteredUsers(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("No users found."));
        } else {
          final users = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            itemCount: users.length,
            itemBuilder: (context, index) {
              return CommenWidgets().buildUserCard(users[index], index, images);
            },
          );
        }
      },
    );
  }
}
