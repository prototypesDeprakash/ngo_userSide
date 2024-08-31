import 'package:lottie/lottie.dart';
import 'package:userside/Textfield.dart';
import 'package:userside/source/registerpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Loginpage extends StatefulWidget {
  Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: Front());
  }
}

class Front extends StatefulWidget {
  Front({super.key});

  @override
  State<Front> createState() => _FrontState();
}

class _FrontState extends State<Front> {
  final username = TextEditingController();

  final password = TextEditingController();

  void p1() async {
    showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: CircularProgressIndicator(
              color: Colors.amber,
            ),
          );
        });
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: username.text, password: password.text);
    } on FirebaseAuthException catch (e) {
      wrongpass1(e.code == '');
    }
    Navigator.of(context).pop();
  }

  wrongpass1(s) {
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
        title: Center(
          child: Text(
            'Login Page',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Georgia',
            ),
          ),
        ),
        backgroundColor: Color.fromARGB(255, 19, 0, 233),
      ),
      // backgroundColor: Colors.grey.gr,
      body: Container(
        //adding background gradient desing
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 19, 0, 233),
              Color.fromARGB(255, 141, 139, 255)
            ], // Your gradient colors here
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),

        child: Column(
          children: [
            Align(alignment: Alignment.center),
            SizedBox(height: 5),
            Lottie.asset(
              "assets/animations/login.json",
              width: 300,
              height: 300,
            ),
            //SizedBox(height: 5),
            Textfield(
              controller: username,
              hinttext: 'E-mail ',
              obsecuretext: false,
              i: Icon(
                Icons.email,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 40),
            Textfield(
              controller: password,
              hinttext: 'Password',
              obsecuretext: true,
              i: Icon(
                Icons.security,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 50),

            // submoit buttton

            GestureDetector(
              onTap: p1,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 25.0),
                margin: EdgeInsets.symmetric(horizontal: 50),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(255, 115, 0, 255),
                      Color.fromARGB(255, 190, 111, 255)
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(30.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 4), // Shadow position
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    'Submit',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2, // Adds spacing between letters
                    ),
                  ),
                ),
              ),
            ),

//end of button

            SizedBox(height: 50),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Lottie.asset("assets/animations/indicate2.json",
                      width: 100, height: 100),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 0),
                  child: Text(
                    'Not a member ? ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Registerpage()));
                  },
                  child: Text(
                    'Register here',
                    style: TextStyle(
                      color: const Color.fromARGB(255, 49, 0, 209),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
