import 'package:lottie/lottie.dart';
import 'package:userside/Textfield.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:userside/theme_global.dart';

class qpage extends StatefulWidget {
  const qpage({super.key});

  @override
  State<qpage> createState() => _qpageState();
}

class _qpageState extends State<qpage> {
  final TextEditingController quertext = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController discription = TextEditingController();
  String options = 'food';
  var items = {
    'food',
    'cloth',
    'medicine',
    'education',
  };

  Future<void> postQuery() async {
    showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: CircularProgressIndicator(
              color: Colors.amber,
            ),
          );
        });
    if (quertext.text.isNotEmpty &&
            nameController.text.isNotEmpty &&
            phoneController.text.isNotEmpty &&
            addressController.text.isNotEmpty ||
        discription.text.isNotEmpty) {
      try {
        LocationPermission permission = await Geolocator.checkPermission();
        if (permission == LocationPermission.denied) {
          permission = await Geolocator.requestPermission();
        }

        if (permission == LocationPermission.denied ||
            permission == LocationPermission.deniedForever) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Location permission is required')),
          );
          return;
        }

        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);

        await FirebaseFirestore.instance.collection('query').add({
          'queryname': quertext.text,
          'name': nameController.text,
          'phone': phoneController.text,
          'address': addressController.text,
          'latitude': position.latitude,
          'longitude': position.longitude,
          'discription': discription.text,
          'options': options,
        });

        quertext.clear();
        nameController.clear();
        phoneController.clear();
        addressController.clear();
        discription.clear();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Details posted successfully')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to post details: $e')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all fields')),
      );
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
          child: Text(
            'What\'s your need ',
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: But1,
      ),
      body: SingleChildScrollView(
        child: Container(
          //background gradient
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Bg1, Bg2], // Your gradient colors here
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),

          padding: EdgeInsets.all(10.0),
          child: Container(
            child: Column(
              children: [
                Container(
                  child: Lottie.asset(
                    "assets/animations/request_need.json",
                    width: 300,
                    height: 300,
                  ),
                  width: 250,
                  height: 250,
                ),
                Textfield(
                  hinttext: 'Enter your Name',
                  obsecuretext: false,
                  i: Icon(
                    Icons.person,
                    color: ico1,
                  ),
                  controller: nameController,
                ),
                SizedBox(
                  height: 20,
                ),
                Textfield(
                  hinttext: 'Enter the Query',
                  obsecuretext: false,
                  i: Icon(
                    Icons.type_specimen,
                    color: ico1,
                  ),
                  controller: quertext,
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.arrow_drop_down_circle,
                      color: ico1,
                    ),
                    SizedBox(
                      width: 50,
                    ),
                    DropdownButton(
                        dropdownColor: dropdowncol,
                        style: TextStyle(
                            color: const Color.fromARGB(255, 0, 0, 0)),
                        value: options,
                        icon: Icon(
                          Icons.keyboard_arrow_down_outlined,
                          color: ico1,
                          size: 30,
                        ),
                        items: items.map((String items) {
                          return DropdownMenuItem(
                              value: items, child: Text(items));
                        }).toList(),
                        onChanged: (String? newvalue) {
                          setState(() {
                            options = newvalue!;
                          });
                        }),
                    SizedBox(
                      width: 160,
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                Textfield(
                  hinttext: 'Enter the Query Discription ',
                  obsecuretext: false,
                  i: Icon(
                    Icons.type_specimen,
                    color: ico1,
                  ),
                  controller: discription,
                ),
                SizedBox(height: 20.0),
                Textfield(
                  hinttext: 'Enter your Phone Number',
                  obsecuretext: false,
                  i: Icon(
                    Icons.phone,
                    color: ico1,
                  ),
                  controller: phoneController,
                ),
                SizedBox(height: 20.0),
                Textfield(
                  hinttext: 'Enter your Address',
                  obsecuretext: false,
                  i: Icon(
                    Icons.location_city,
                    color: ico1,
                  ),
                  controller: addressController,
                ),
                SizedBox(height: 70.0),
                GestureDetector(
                  onTap: postQuery,
                  child: Container(
                    decoration: mySpecialBoxDecoration,
                    child: Center(
                        child: Text(
                      "Send",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2, // Adds spacing between letters
                      ),
                    )),
                    width: 200,
                    height: 50,
                  ),
                ),
                SizedBox(height: 90.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
