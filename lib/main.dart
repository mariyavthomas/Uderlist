// ignore_for_file: use_build_context_synchronously

import 'package:brototypeuserlist/view_models/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:brototypeuserlist/firebase_options.dart';
import 'package:brototypeuserlist/view_models/auth_provider.dart';
import 'package:brototypeuserlist/views/signup.dart';
import 'package:brototypeuserlist/views/home/screen/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthPhoneProvider()),
        ChangeNotifierProvider(create: (context)=>UserProvider())
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthPhoneProvider>(context, listen: false);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder<bool>(
        future: ap.isSignedIn,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data == true) {
              // User is signed in, navigate to HomeScreen
              ap.getDataFromSP().whenComplete(
                () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>  HomeScreen(),
                  ),
                ),
              );
              return  HomeScreen();
            } else {
              // User is not signed in, navigate to RegisterScreen
              return const SignUpScreen();
            }
          } else {
            // Still loading, show a loading indicator
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
