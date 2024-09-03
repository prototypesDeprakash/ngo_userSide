import 'package:userside/Textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:userside/source/donatenewthings.dart';

class Registerpage extends StatefulWidget {
  const Registerpage({super.key});

  @override
  State<Registerpage> createState() => _RegisterpageState();
}

class _RegisterpageState extends State<Registerpage> {
  @override
  Widget build(BuildContext context) {
    final email = TextEditingController();
    final pass = TextEditingController();
    final passcnfm = TextEditingController();
    void dis(s) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(s),
            );
          });
    }

    void passcheck() async {
      showDialog(
          context: context,
          builder: (context) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.amber,
              ),
            );
          });
      if (pass.text == passcnfm.text) {
        try {
          User user =
              (await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: email.text,
            password: pass.text,
          ))
                  .user!;

          if (user != null) {
            user.updateDisplayName("donate");
            print("user details is ${user.displayName}");

            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Newthings()),
              );
            });
          } else {
            print("User authentication faliled");

            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text("NILL")));
          }
        } on FirebaseAuthException catch (e) {
          String x = e.code.toString();
          if (x != '') {
            dis(e.code);
          }
        } catch (e) {
          print(e);
        }
      } else {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Password mismatch'),
              );
            });
      }
      Navigator.of(context).pop();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('SIGNUP PAGE'),
        backgroundColor: Colors.amber,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 60.0,
          ),
          Textfield(
            controller: email,
            hinttext: 'Enter your e-mail',
            obsecuretext: false,
            i: Icon(Icons.email),
          ),
          SizedBox(
            height: 50.0,
          ),
          Textfield(
            controller: pass,
            hinttext: 'Enter your password',
            obsecuretext: true,
            i: Icon(Icons.password),
          ),
          SizedBox(
            height: 50.0,
          ),
          Textfield(
            controller: passcnfm,
            hinttext: 'Enter your password again',
            obsecuretext: true,
            i: Icon(Icons.password),
          ),
          SizedBox(
            height: 50.0,
          ),
          GestureDetector(
            onTap: passcheck,
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
        ],
      ),
    );
  }
}
