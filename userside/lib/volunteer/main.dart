import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:userside/Volunteer/authpage.dart';
import 'package:userside/Volunteer/signup.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Checkvol());
}

class Checkvol extends StatelessWidget {
  Checkvol({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Front(),
    );
  }
}

class Front extends StatelessWidget {
  const Front({super.key});

  @override
  Widget build(BuildContext context) {
    void loginpage() {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AuthPage(),
          ));
    }

    void signup() {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Registerpage(),
          ));
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.amber,
      body: Column(
        children: [
          SizedBox(height: 220),
          Center(
            child: Icon(
              Icons.handshake,
              size: 140.0,
            ),
          ),
          // SizedBox(
          //   height: 20,
          // ),
          Text(
            'NGO APP',
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(
            height: 30.0,
          ),
          GestureDetector(
            onTap: loginpage,
            child: Container(
              padding: EdgeInsets.all(25.0),
              margin: EdgeInsets.symmetric(horizontal: 25),
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(8.0)),
              child: Center(
                child: Text(
                  'LOGIN',
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          GestureDetector(
            onTap: signup,
            child: Container(
              padding: EdgeInsets.all(25.0),
              margin: EdgeInsets.symmetric(horizontal: 25),
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(8.0)),
              child: Center(
                child: Text(
                  'SIGN UP',
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
