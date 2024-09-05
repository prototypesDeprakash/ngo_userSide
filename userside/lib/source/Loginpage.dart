import 'package:lottie/lottie.dart';
import 'package:userside/Textfield.dart';
import 'package:userside/source/donatenewthings.dart';
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
    if (username.text.isEmpty || password.text.isEmpty) {
      wrongpass1('Email or password cannot be empty');
      return;
    }

    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: CircularProgressIndicator(
            color: Colors.amber,
          ),
        );
      },
    );

    try {
      User user = (await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: username.text,
        password: password.text,
      ))
          .user!;
      Navigator.pop(context);

      if (user != null && user.displayName == 'donate') {
        print("User is not null for donate");

        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Newthings()),
          );
        });
      } else {
        print("User is null or not suitable");
        wrongpass1('User not authorized or not found.');
      }
    } on FirebaseAuthException catch (e) {
      wrongpass1(e.message ?? 'An error occurred');
    } finally {}
  }

  void wrongpass1(String errorMessage) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Login Failed'),
          content: Text(errorMessage),
        );
      },
    );
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
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 19, 0, 233),
              Color.fromARGB(255, 141, 139, 255)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Align(alignment: Alignment.center),
              SizedBox(height: 5),
              Lottie.asset(
                "assets/animations/login.json",
                width: 300,
                height: 300,
              ),
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
              GestureDetector(
                onTap: p1,
                child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 15.0, horizontal: 25.0),
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
                        offset: Offset(0, 4),
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
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ),
              ),
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
                  SizedBox(width: 10),
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
      ),
    );
  }
}
