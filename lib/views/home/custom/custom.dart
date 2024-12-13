import 'package:brototypeuserlist/models/newusermodel.dart';
import 'package:brototypeuserlist/utils/custom_text.dart';
import 'package:brototypeuserlist/view_models/auth_provider.dart';
import 'package:brototypeuserlist/view_models/user_provider.dart';
import 'package:brototypeuserlist/views/home/custom/capitalizename.dart';
import 'package:brototypeuserlist/views/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CommenWidgets {
//UserDeatilCard

  Widget buildUserCard(NewUserModel user, int index, List images) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: SizedBox(
        width: 340,
        height: 76,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage(images[index % images.length]),
              ),
            ),
            const SizedBox(width: 16.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  text: Capitalize().capitalizeName(user.name!),
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  color: Colors.black,
                ),
                CustomText(
                  padding: const EdgeInsets.only(top: 5),
                  text: "Age: ${user.age}",
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: Colors.black,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

//SearchFilter

  Widget buildSearchAndFilterRow(BuildContext context,
      UserProvider userProvider, TextEditingController searchController) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.grey),
              ),
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Icon(Icons.search, color: Colors.black),
                  ),
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        hintText: 'Search by name',
                        hintStyle: GoogleFonts.montserrat(
                          textStyle: const TextStyle(color: Colors.grey),
                        ),
                        border: InputBorder.none,
                      ),
                      style: GoogleFonts.montserrat(),
                      onChanged: (value) => userProvider.searchQuery = value,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 10),
          Container(
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(10),
            ),
            child: IconButton(
              icon:
                  const Icon(Icons.filter_list, color: Colors.white, size: 30),
              onPressed: () =>
                  Capitalize().showFilterOptions(context, userProvider),
            ),
          ),
        ],
      ),
    );
  }

//Header of the Home Page

  Widget buildHeader(BuildContext context) {
    final ap = Provider.of<AuthPhoneProvider>(context);
    return Container(
      height: 69,
      color: Colors.black,
      child: Row(
        children: [
          const Icon(Icons.location_on, color: Colors.white),
          const SizedBox(width: 8),
          const CustomText(
            text: "Nilabure",
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
          Spacer(),
          IconButton(onPressed: (){
          ap.userSignOut(); 
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>SignUpScreen()), (rotues)=>false);
          }, icon: Icon(Icons.logout))
        ],
      ),
    );
  }
}
