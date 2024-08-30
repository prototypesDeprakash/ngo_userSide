import 'package:userside/Textfield.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';

class userpage1 extends StatefulWidget {
  final String productName;
  final String productImage;
  final String productLat;
  final String productLong;
  final String productcam_image;

  userpage1({
    super.key,
    required this.productName,
    required this.productImage,
    required this.productLat,
    required this.productLong,
    required this.productcam_image,
  });

  @override
  _userpage1State createState() => _userpage1State();
}

class _userpage1State extends State<userpage1> {
  final TextEditingController name = TextEditingController();
  final TextEditingController phonenumber = TextEditingController();
  final TextEditingController address = TextEditingController();

  Future<void> submitneed(BuildContext context) async {
    showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: CircularProgressIndicator(
              color: Colors.amber,
            ),
          );
        });
    if (name.text.isNotEmpty &&
        phonenumber.text.isNotEmpty &&
        address.text.isNotEmpty) {
      try {
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        await FirebaseFirestore.instance.collection('deliverprodu').add({
          'name': name.text,
          'phone_number': phonenumber.text,
          'address': address.text,
          'user_latitude': position.latitude,
          'user_longitude': position.longitude,
          'product_name': widget.productName,
          'product_image': widget.productImage,
          'productcam_image': widget.productcam_image,
          'product_latitude': widget.productLat,
          'product_longitude': widget.productLong,
        });

        name.clear();
        phonenumber.clear();
        address.clear();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Information submitted successfully')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to submit information: $e')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all fields')),
      );
    }
    Navigator.of(context).pop();
  }

  Future<void> getLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      address.text = 'Lat: ${position.latitude}, Long: ${position.longitude}';
    } catch (e) {
      print('Error getting location: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('BUYER'),
        backgroundColor: Colors.amber,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 50.0,
          ),
          Textfield(
              controller: name,
              obsecuretext: false,
              hinttext: 'Name',
              i: Icon(Icons.person)),
          SizedBox(
            height: 50.0,
          ),
          Textfield(
            controller: phonenumber,
            obsecuretext: false,
            hinttext: 'Phone Number',
            i: Icon(Icons.phone),
          ),
          SizedBox(
            height: 50.0,
          ),
          Row(
            children: [
              Expanded(
                child: Textfield(
                  controller: address,
                  obsecuretext: false,
                  hinttext: 'Address',
                  i: Icon(Icons.location_city),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 40.0,
          ),
          GestureDetector(
            onTap: () => submitneed(context),
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
