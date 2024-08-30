import 'package:userside/Textfield.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';

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
        addressController.text.isNotEmpty) {
      try {
        // Check location permission
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

        // Get current location
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);

        // Upload all details to Firestore
        await FirebaseFirestore.instance.collection('query').add({
          'queryname': quertext.text,
          'name': nameController.text,
          'phone': phoneController.text,
          'address': addressController.text,
          'latitude': position.latitude,
          'longitude': position.longitude,
        });

        // Clear the text fields
        quertext.clear();
        nameController.clear();
        phoneController.clear();
        addressController.clear();

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
        title: Text('QUERY PAGE'),
        backgroundColor: Colors.amber,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Textfield(
              hinttext: 'Enter the Query',
              obsecuretext: false,
              i: Icon(Icons.query_builder),
              controller: quertext,
            ),
            SizedBox(height: 20.0),
            Textfield(
              hinttext: 'Enter your Name',
              obsecuretext: false,
              i: Icon(Icons.person),
              controller: nameController,
            ),
            SizedBox(height: 20.0),
            Textfield(
              hinttext: 'Enter your Phone Number',
              obsecuretext: false,
              i: Icon(Icons.phone),
              controller: phoneController,
            ),
            SizedBox(height: 20.0),
            Textfield(
              hinttext: 'Enter your Address',
              obsecuretext: false,
              i: Icon(Icons.location_city),
              controller: addressController,
            ),
            SizedBox(height: 20.0),
            GestureDetector(
              onTap: postQuery,
              child: Container(
                padding: EdgeInsets.all(15.0),
                margin: EdgeInsets.symmetric(horizontal: 90),
                decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(30.0)),
                child: Center(
                  child: Text(
                    'SUBMIT',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
