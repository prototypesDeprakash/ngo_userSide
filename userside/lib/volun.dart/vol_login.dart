import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:userside/Volunteer/Textfield.dart';
import 'package:userside/Volunteer/menu.dart';

class Front_vol_ extends StatefulWidget {
  Front_vol_({super.key});

  @override
  State<Front_vol_> createState() => _FrontState();
}

class _FrontState extends State<Front_vol_> {
  final username = TextEditingController();

  final password = TextEditingController();

  void p() async {
    try {
      User user = (await FirebaseAuth.instance.signInWithEmailAndPassword(
              email: username.text, password: password.text))
          .user!;

      if (user != null && user.displayName == 'volunteer') {
        print("user is not nuull for donate");
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Deliverypage()),
          );
        });
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("USER IS NOT SUITABKE")));
        print("User is null or not suitable");
      }
    } on FirebaseAuthException catch (e) {
      wrongpass(e.code == '');
      print(e.code);
    }
  }

  wrongpass(s) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('WRONG CREDENTIALS'),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('LOGIN PAGE'),
        backgroundColor: Colors.amber,
      ),
      // backgroundColor: Colors.grey.gr,
      body: Column(
        children: [
          Align(alignment: Alignment.center),
          SizedBox(
            height: 60,
          ),
          Center(),
          Icon(
            Icons.lock,
            size: 100,
            color: Colors.amber,
          ),
          SizedBox(height: 40),
          Textfield(
            controller: username,
            hinttext: 'e-mail ',
            obsecuretext: false,
            i: Icon(Icons.email),
          ),
          SizedBox(height: 40),
          Textfield(
            controller: password,
            hinttext: 'password',
            obsecuretext: true,
            i: Icon(Icons.password),
          ),
          SizedBox(height: 30),
          GestureDetector(
            onTap: p,
            child: Container(
              padding: EdgeInsets.all(25.0),
              margin: EdgeInsets.symmetric(horizontal: 90),
              decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(30.0)),
              child: Center(
                child: Text(
                  'Submit',
                  style: TextStyle(color: Colors.black, fontSize: 20.0),
                ),
              ),
            ),
          ),
          SizedBox(height: 35),
        ],
      ),
    );
  }
}
