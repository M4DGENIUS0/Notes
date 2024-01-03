import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/Pages/home.dart';
import 'package:todoapp/Pages/main_Login_Sign_up.dart';

class Auth_Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            // Handle error
            return Text('Error: ${snapshot.error}');
          }
          final user = FirebaseAuth.instance.currentUser;
          if (snapshot.hasData || user != null) {
            print('User UID: ${snapshot.data?.uid}');
            return Home();
          } else {
            return MainPage();
          }
        });
  }
}
