import 'package:brototypeuserlist/utils/validator.dart';
import 'package:brototypeuserlist/view_models/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:brototypeuserlist/utils/custom_elevation_button.dart';
import 'package:brototypeuserlist/utils/custom_text.dart';
import 'package:brototypeuserlist/utils/custom_textformfiled.dart';
import 'package:brototypeuserlist/utils/text_controller.dart';

import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  // ignore: use_super_parameters
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController numberController =
      StandardTextController.create();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 244, 244, 244),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            const SizedBox(height: 100),
            Container(
              height: 145.74,
              width: 220,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/image/signupimage.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 50),
            const CustomText(
              padding: EdgeInsets.only(right: 195, bottom: 17),
              text: "Enter Phone Number",
              fontWeight: FontWeight.w700,
              fontSize: 14,
              color: Color.fromRGBO(41, 40, 40, 1),
            ),
            CustomTextFormField(
              width: 370,
              height: 50,
              padding: EdgeInsets.only(bottom: 10),
              controller: numberController,
              hintText: "Phone number",
              keyboardType: TextInputType.phone,
              isRequired: true,
              borderRadius: 8,
              labelText: "Enter Phone Number",
              validator: (value) => Validator().nameValidator(value),
            ),
            const CustomText(
              padding: EdgeInsets.only(left: 20, top: 15),
              fontSize: 12,
              fontWeight: FontWeight.w600,
              textSpans: [
                TextSpan(
                  text: 'By continuing, I agree to TotalX\'s ',
                  style: TextStyle(
                    color: Color.fromARGB(255, 110, 109, 109),
                    fontWeight: FontWeight.normal,
                  ),
                ),
                TextSpan(
                  text: ' Terms and Conditions ',
                  style: TextStyle(
                    color: Color.fromARGB(255, 118, 174, 220),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextSpan(
                  text: " & ",
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextSpan(
                  text: ' Privacy Policy',
                  style: TextStyle(
                    color: Color.fromARGB(255, 118, 174, 220),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 29),
            CustomElevatedButton(
              // width: 360,
              // height: 50,
              fixedSize: Size(360, 50),
              text: "Get OTP",
              fontWeight: FontWeight.w600,
              onPressed: () {
                sendPhoneNumber();
              },
              backgroundColor: Colors.black,
              textColor: Colors.white,
              borderRadius: 60,
            ),
          ],
        ),
      ),
    );
  }

  void sendPhoneNumber() {
    final ap = Provider.of<AuthPhoneProvider>(context, listen: false);
    String phoneNumber = numberController.text.trim();
    ap.signInWithPhone(context, "$phoneNumber!");
  }
}
