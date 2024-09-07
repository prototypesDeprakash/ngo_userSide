import 'dart:io';
import 'package:lottie/lottie.dart';
import 'package:userside/Textfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:userside/source/Loginpage.dart';

class Newthings extends StatefulWidget {
  const Newthings({super.key});

  @override
  State<Newthings> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Newthings> {
  final pname = TextEditingController();
  final des = TextEditingController();
  File? _image;
  File? _image1;
  String? lat;
  String? long;
  String options = 'food';
  var items = {
    'food',
    'cloth',
    'medicine',
    'education',
  };
  final CollectionReference _items =
      FirebaseFirestore.instance.collection("requirements");

  Future<void> _pickImage() async {
    final XFile? pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  void signout() async {
    // showDialog(
    //     context: context,
    //     builder: (context) {
    //       return Center(
    //         child: CircularProgressIndicator(
    //           color: const Color.fromARGB(255, 39, 2, 141),
    //         ),
    //       );
    //     });

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Loginpage()));

    await FirebaseAuth.instance.signOut();
  }

  Future<void> _pickImage1() async {
    final XFile? image =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        _image1 = File(image.path);
      });
    }
  }

  Future<void> _getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      lat = position.latitude.toString();
      long = position.longitude.toString();
    });
  }

  Future<String> _uploadImage(File image) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference storageRef =
        FirebaseStorage.instance.ref().child("images/$fileName");

    UploadTask uploadTask = storageRef.putFile(image);
    TaskSnapshot snapshot = await uploadTask;

    return await snapshot.ref.getDownloadURL();
  }

  Future<String?> _uploadCameraImage(File? image) async {
    if (image == null) return null;

    String camname = DateTime.now().microsecondsSinceEpoch.toString();
    Reference storage =
        FirebaseStorage.instance.ref().child("imagescam/$camname");
    UploadTask uploadTask = storage.putFile(image);
    TaskSnapshot snapshot = await uploadTask;
    return await snapshot.ref.getDownloadURL();
  }

  void subm() async {
    showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: CircularProgressIndicator(
              color: Colors.amber,
            ),
          );
        });
    final String proname = pname.text;
    final String pdes = des.text;

    if (_image != null || _image1 != null) {
      try {
        String imageUrl = _image != null ? await _uploadImage(_image!) : '';
        String? imagecamurl =
            _image1 != null ? await _uploadCameraImage(_image1) : null;

        // Store data in Firestore
        await _items.add({
          "pname": proname,
          "pdes": pdes,
          "imageUrl": imageUrl,
          if (imagecamurl != null) "imagecamurl": imagecamurl,
          if (lat != null) "latitude": lat,
          if (long != null) "longitude": long,
          "options": options,
        });

        pname.clear();
        des.clear();
        setState(() {
          _image = null;
          _image1 = null;
        });

        print('Data added successfully');
      } catch (e) {
        print('Error: $e');
      }
    } else {
      print('Please select at least one image');
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 150),
              Lottie.asset('assets/animations/vanakam.json',
                  width: 200, height: 200),
              SizedBox(height: 30),
              Text('Thanks for Donating', style: TextStyle(fontSize: 25.0)),
              SizedBox(height: 30),
              Text(' "Your donation matters" ',
                  style:
                      TextStyle(fontSize: 20.0, fontStyle: FontStyle.italic)),
              SizedBox(height: 30),

              //old button --1
              // ElevatedButton(
              //   onPressed: signout,
              //   child: Text('Logout', style: TextStyle(color: Colors.black)),
              //   style: ElevatedButton.styleFrom(
              //     backgroundColor: Colors.amber,
              //     textStyle: TextStyle(color: Colors.black, fontSize: 20),
              //     padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(30.0),
              //     ),
              //   ),
              // ),

              //new button code
              GestureDetector(
                onTap: signout,
                child: Container(
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
                    "Logout",
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
            ],
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,

      //end of app drawer

      //app bar starts ....

      appBar: AppBar(
        //   leading: IconButton(onPressed: Drawer.new, icon: Icon(Icons.menu)),
        title: Row(
          children: [
            SizedBox(
              width: 90,
            ),
            Text(
              'Donate',
              style: TextStyle(color: const Color.fromARGB(255, 255, 255, 255)),
            ),
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 19, 0, 233),
      ),
      body: Container(
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: Lottie.asset("assets/animations/help2.json",
                    width: 150, height: 150),
                //color: Colors.white,
              ),
              SizedBox(height: 40),
              Textfield(
                controller: pname,
                obsecuretext: false,
                hinttext: 'Product Name',
                i: Icon(
                  Icons.shopping_cart,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20),
              Textfield(
                obsecuretext: false,
                hinttext: 'Product Description',
                controller: des,
                i: Icon(
                  Icons.description,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.arrow_drop_down_circle,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  DropdownButton(
                      dropdownColor: Colors.purple,
                      style: TextStyle(color: Colors.white),
                      value: options,
                      icon: Icon(
                        Icons.keyboard_arrow_down_outlined,
                        color: Colors.white,
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
                ],
              ),
              SizedBox(
                height: 20,
              ),
              //first box

              //first button

              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 15.0, horizontal: 25.0),
                  margin: EdgeInsets.symmetric(horizontal: 50),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(255, 19, 0, 233),
                        Color.fromARGB(255, 141, 139, 255)
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
                  child: Row(
                    //animation
                    children: [
                      _image == null
                          ? Lottie.asset("assets/animations/select.json",
                              width: 50, height: 50)
                          : Lottie.asset("assets/animations/done2.json",
                              width: 50, height: 50),

                      //animation ends
                      //space after animation
                      SizedBox(
                        width: 15,
                      ),

                      Center(
                        child: Text(
                          _image == null ? 'Select from gallery' : 'Selected',
                          style: TextStyle(
                            color: const Color.fromARGB(255, 255, 255, 255),
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              //first button ends here

              //gap before second button

              SizedBox(height: 20.0),

              GestureDetector(
                onTap: _pickImage1,
                child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 15.0, horizontal: 25.0),
                  margin: EdgeInsets.symmetric(horizontal: 50),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(255, 19, 0, 233),
                        Color.fromARGB(255, 141, 139, 255)
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
                  child: Row(
                    //animation
                    children: [
                      _image1 == null
                          ? Lottie.asset("assets/animations/camera2.json",
                              width: 50, height: 50)
                          : Lottie.asset("assets/animations/done2.json",
                              width: 50, height: 50),

                      //animation ends
                      //space after animation
                      SizedBox(
                        width: 15,
                      ),

                      Center(
                        child: Text(
                          _image1 == null ? 'Open camera' : 'Selected',
                          style: TextStyle(
                            color: const Color.fromARGB(255, 255, 255, 255),
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 20.0),

              GestureDetector(
                onTap: () async {
                  try {
                    await _getLocation();
                  } catch (e) {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('$e'),
                          );
                        });
                  }
                },
                child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 15.0, horizontal: 25.0),
                  margin: EdgeInsets.symmetric(horizontal: 50),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(255, 19, 0, 233),
                        Color.fromARGB(255, 141, 139, 255)
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
                  child: Row(
                    //animation
                    children: [
                      long == null
                          ? Lottie.asset("assets/animations/location.json",
                              width: 50, height: 50)
                          : Lottie.asset("assets/animations/done2.json",
                              width: 50, height: 50),

                      //animation ends
                      //space after animation
                      SizedBox(
                        width: 15,
                      ),

                      Center(
                        child: Text(
                          long == null ? 'Get Location' : 'Location Obtained',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 40.0),

              GestureDetector(
                onTap: subm,
                child: Container(
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
                    "Submit",
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
              SizedBox(
                height: 30,
              )
            ],
          ),
        ),
      ),
    );
  }
}
