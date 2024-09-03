import 'package:userside/source/Loginpage.dart';
import 'package:userside/source/donatenewthings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //getData();
  }

  @override
  Widget build(BuildContext context) {
    return (FirebaseAuth.instance.currentUser != null &&
            FirebaseAuth.instance.currentUser?.displayName == 'donate')
        ? (Newthings())
        : (Loginpage());
  }
}
