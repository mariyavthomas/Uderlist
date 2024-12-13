// ignore_for_file: use_build_context_synchronously

import 'package:brototypeuserlist/models/usermodel.dart';
import 'package:brototypeuserlist/utils/custom_text.dart';
import 'package:brototypeuserlist/view_models/auth_provider.dart';
import 'package:brototypeuserlist/views/home/screen/home.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class OtpVerificationscreen extends StatefulWidget {
  final String? verificationId;

  const OtpVerificationscreen({
    this.verificationId,
    super.key,
  });

  @override
  State<OtpVerificationscreen> createState() => _OtpVerificationscreenState();
}

class _OtpVerificationscreenState extends State<OtpVerificationscreen> {
  final TextEditingController otpController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String? otpcode;
  double _offset = 50.0;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        _offset = 0.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:const Color.fromARGB(255, 238, 238, 238) ,
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 100),
        Center(
          child: Container(
            height: 145.74,
            width: 220,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/image/Authimage.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      
        SizedBox(
          height: 40,
        ),
        CustomText(
          text: "OTP Verification",
          fontWeight: FontWeight.w600,
          fontSize: 15,
        ),
        SizedBox(height: 10),
        CustomText(
          text:
              "Enter the verification code we just sent to your number +91 *******21.",
          fontWeight: FontWeight.w400,
          fontSize: 14,
          color: Colors.black,
        ),
        const SizedBox(height: 10), // Space between text and form
        Form(
          key: formKey,
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Pinput(
              length: 6,
              showCursor: true,
              defaultPinTheme: PinTheme(
                 
                width: 50,
                height: 50,
                decoration: BoxDecoration(

                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: const Color.fromARGB(255, 84, 84, 84),
                    width: 2
                  ),
                ),
                textStyle: const TextStyle(
                  fontSize: 20,
                  color: Colors.red,
                  fontWeight: FontWeight.w600,
                ),
              ),
              
              onCompleted: (value) {
                setState(() {
                  otpcode = value;
                });
              },
            ),
          ]),
        ),
        const SizedBox(height: 3),
        Center(
          child: CustomText(
            text: '59 Sec',
            color: Colors.red,
            fontWeight: FontWeight.w600,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText(text: "Don't Get OTP? ",
             fontWeight: FontWeight.w500,
             fontSize: 12,
                ),
            Text("Resend", style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline,fontWeight: FontWeight.w600)),
          ],
        ),
        // Space before the button
        Padding(
            padding: const EdgeInsets.all(20.0),
            child: InkWell(
                onTap: () {
                  if (otpcode != null) {
                    verifyOtp(context, otpcode!);
                  } else {
                    ScaffoldMessenger(
                      child: Text(' "Enter 6-Digit code"'),
                    );
                  }
                },
                child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(60)),
                    child: Center(
                      child: Text(
                        'Verify',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    )))),
      ],
    ));
    // Pu)shes content up
  }

  // verify otp
  // verify otp
  void verifyOtp(BuildContext context, String userOtp) {
    final ap = Provider.of<AuthPhoneProvider>(context, listen: false);
    ap.verifyOtp(
      context: context,
      verificationId: widget.verificationId!,
      userOtp: userOtp,
      onSuccess: () {
        // checking whether user exists in the db
        ap.checkExistingUser().then(
          (value) async {
            if (value == true) {
              // user exists in our app
              ap.getDataFromFirestore().then(
                    (value) => ap.saveUserDataToSP().then(
                          (value) => ap.setSignIn().then(
                                (value) => Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => HomeScreen(),
                                    ),
                                    (route) => false),
                              ),
                        ),
                  );
            } else {
              // new user
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                  (route) => false);
            }
          },
        );
      },
    );
  }

  // store user data to database
  void storeData() async {
    final ap = Provider.of<AuthPhoneProvider>(context, listen: false);
    UserModel userModel = UserModel(
      phoneNumber: "",
      uid: "",
    );
    // ignore: unnecessary_null_comparison
    if (userModel != null) {
      ap.saveUserDataToFirebase(
        context: context,
        userModel: userModel,
        onSuccess: () {
          ap.saveUserDataToSP().then(
                (value) => ap.setSignIn().then(
                      (value) => Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomeScreen(),
                          ),
                          (route) => false),
                    ),
              );
        },
      );
    } else {}
  }
}
