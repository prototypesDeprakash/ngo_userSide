import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:userside/Volunteer/Login.dart';
import 'package:userside/Volunteer/menu.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return (FirebaseAuth.instance.currentUser != null &&
            FirebaseAuth.instance.currentUser?.displayName == 'volunteer')
        ? (Deliverypage())
        : Loginpage();
  }
}
