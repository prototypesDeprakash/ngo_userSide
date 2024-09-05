import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:userside/volun.dart/vol_main.dart';
import 'package:userside/volunteer/menu.dart';

class vol_auth extends StatefulWidget {
  const vol_auth({super.key});

  @override
  State<vol_auth> createState() => _vol_authState();
}

class _vol_authState extends State<vol_auth> {
  @override
  Widget build(BuildContext context) {
    return (FirebaseAuth.instance.currentUser != null &&
            FirebaseAuth.instance.currentUser?.displayName == 'volunteer')
        ? (Deliverypage())
        : (VolMain());
  }
}
