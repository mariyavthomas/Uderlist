import 'package:brototypeuserlist/utils/custom_text.dart';
import 'package:brototypeuserlist/view_models/user_provider.dart';
import 'package:brototypeuserlist/views/home/custom/custom.dart';
import 'package:brototypeuserlist/views/home/custom/customuserlist.dart';
import 'package:brototypeuserlist/views/home/screen/adduser.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController searchController = TextEditingController();
  final List<String> images = [
    "assets/image/p1.png",
    "assets/image/p2.png",
    "assets/image/p3.png",
    "assets/image/p4.png",
    "assets/image/p6.png",
    "assets/image/p7.png",
  ];

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      backgroundColor: const Color.fromRGBO(228, 228, 228, 1),
      body: Column(
        children: [
          const SizedBox(height: 44),
          Container(
            width: 680,
            child: CommenWidgets().buildHeader(context)),
          const SizedBox(height: 10),
          CommenWidgets().buildSearchAndFilterRow(
              context, userProvider, searchController),
          const SizedBox(height: 10),
          const CustomText(
            padding: EdgeInsets.only(right: 275),
            text: "Users Lists",
            fontWeight: FontWeight.w600,
            fontSize: 15,
            color: Color.fromRGBO(0, 0, 0, 1),
          ),
          Expanded(
            child: Userlist().buildUserList(userProvider, images),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 50, right: 15),
        child: FloatingActionButton(
          onPressed: () {
            AddtoUser().showAddUserDialog(context, userProvider);
          },
          backgroundColor: Colors.black,
          shape: CircleBorder(),
          child: Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }
}
