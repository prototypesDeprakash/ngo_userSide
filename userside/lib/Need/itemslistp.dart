// import 'package:clgproject/Need/UserInterface.dart';
// import 'package:clgproject/Need/emegencypage.dart';
// import 'package:clgproject/Need/qp.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// class ItemListPage extends StatefulWidget {
//   const ItemListPage({Key? key}) : super(key: key);

//   @override
//   _ItemListPageState createState() => _ItemListPageState();
// }

// class _ItemListPageState extends State<ItemListPage> {
//   void emergen() {
//     Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => emergencypage(),
//         ));
//   }

//   void qp() {
//     Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => qpage(),
//         ));
//   }

//   String searchQuery = '';

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Items List'),
//         backgroundColor: Colors.amber,
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: TextField(
//               onChanged: (value) {
//                 setState(() {
//                   searchQuery = value.toLowerCase();
//                 });
//               },
//               decoration: InputDecoration(
//                 labelText: 'Search',
//                 border: OutlineInputBorder(),
//                 prefixIcon: Icon(Icons.search),
//               ),
//             ),
//           ),
//           SizedBox(height: 30),
//           Center(
//             child: Row(
//               children: [
//                 SizedBox(width: 50),
//                 ElevatedButton(
//                   onPressed: emergen,
//                   child: Text(
//                     'EMERGENCY',
//                     style: TextStyle(color: Colors.black, fontSize: 20),
//                   ),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.amber,
//                     padding:
//                         EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(30.0),
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: 50),
//                 ElevatedButton(
//                   onPressed: qp,
//                   child: Text(
//                     'QUERY',
//                     style: TextStyle(color: Colors.black, fontSize: 25),
//                   ),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.amber,
//                     textStyle: TextStyle(color: Colors.black, fontSize: 20),
//                     padding:
//                         EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(30.0),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(height: 30),
//           Expanded(
//             child: StreamBuilder<QuerySnapshot>(
//               stream: FirebaseFirestore.instance
//                   .collection('requirements')
//                   .snapshots(),
//               builder: (context, snapshot) {
//                 if (snapshot.hasError) {
//                   return Center(child: Text('Error: ${snapshot.error}'));
//                 }

//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return Center(child: CircularProgressIndicator());
//                 }

//                 final data = snapshot.data;

//                 // Filter the documents based on the search query
//                 final filteredDocs = data?.docs.where((doc) {
//                       final pname = doc['pname']?.toLowerCase() ?? '';
//                       final pdes = doc['pdes']?.toLowerCase() ?? '';
//                       return pname.contains(searchQuery) ||
//                           pdes.contains(searchQuery);
//                     }).toList() ??
//                     [];

//                 return ListView.builder(
//                   itemCount: filteredDocs.length,
//                   itemBuilder: (context, index) {
//                     var item =
//                         filteredDocs[index].data() as Map<String, dynamic>;
//                     var pname = item['pname'] ?? 'Unnamed';
//                     var pdes = item['pdes'] ?? 'No description';
//                     var imageUrl =
//                         item.containsKey('imageUrl') ? item['imageUrl'] : '';
//                     var imageCamUrl = item.containsKey('imagecamurl')
//                         ? item['imagecamurl']
//                         : '';
//                     var productLat =
//                         item.containsKey('latitude') ? item['latitude'] : '';
//                     var productLong =
//                         item.containsKey('longitude') ? item['longitude'] : '';

//                     return Card(
//                       margin: EdgeInsets.all(10.0),
//                       elevation: 5.0,
//                       child: Padding(
//                         padding: const EdgeInsets.all(10.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             if (imageUrl.isNotEmpty)
//                               Image.network(
//                                 imageUrl,
//                                 height: 300,
//                                 width: double.infinity,
//                                 fit: BoxFit.cover,
//                               ),
//                             if (imageCamUrl.isNotEmpty)
//                               Image.network(
//                                 imageCamUrl,
//                                 height: 300,
//                                 width: double.infinity,
//                                 fit: BoxFit.cover,
//                               ),
//                             SizedBox(height: 10.0),
//                             Text(
//                               'Product Name: ' + pname,
//                               style: TextStyle(
//                                 fontSize: 18.0,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             SizedBox(height: 10.0),
//                             Text(
//                               'Product Description: ' + pdes,
//                               style: TextStyle(
//                                 fontSize: 16.0,
//                               ),
//                             ),
//                             SizedBox(height: 10.0),
//                             ElevatedButton(
//                               onPressed: () {
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) => userpage1(
//                                       productName: pname,
//                                       productImage: imageUrl.isNotEmpty
//                                           ? imageUrl
//                                           : imageCamUrl,
//                                       productcam_image: imageUrl.isNotEmpty
//                                           ? imageCamUrl
//                                           : imageUrl,
//                                       productLat: productLat,
//                                       productLong: productLong,
//                                     ),
//                                   ),
//                                 );
//                               },
//                               child: Text(
//                                 'Buy',
//                                 style: TextStyle(
//                                     color: Colors.black, fontSize: 20),
//                               ),
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: Colors.amber,
//                                 textStyle: TextStyle(
//                                     color: Colors.black, fontSize: 20),
//                                 padding: EdgeInsets.symmetric(
//                                     vertical: 10.0, horizontal: 20.0),
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(30.0),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:userside/Need/emegencypage.dart';
import 'package:userside/Need/qp.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ItemListPage extends StatelessWidget {
  const ItemListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Center(
              child: Text(
            'Select Aid ',
            style: TextStyle(
              color: Colors.white,
            ),
          )),
          backgroundColor: Color.fromARGB(255, 19, 0, 233),
        ),
        body: Container(
          // adding gradient design background
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

          //end of gradient design

          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => qpage()));
                },
                child: Column(
                  children: [
                    Center(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 25,
                          ),
                          Container(
                            width: 200,
                            height: 200,
                            child: Lottie.asset("assets/animations/help2.json"),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Text(
                            'Request help',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 80),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => emergencypage()));
                },
                child: Column(
                  children: [
                    Container(
                      height: 200,
                      width: 200,
                      child: Lottie.asset("assets/animations/emergency2.json"),
                      // color: Colors.white,
                    ),
                    Text(
                      'Emergency help',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: 40,
              ),
              // GestureDetector(
              //   onTap: () {
              //     Navigator.push(context,
              //         MaterialPageRoute(builder: (context) => emergencypage()));
              //   },
              //   child: Container(
              //     padding: EdgeInsets.all(25.0),
              //     margin: EdgeInsets.symmetric(horizontal: 90),
              //     decoration: BoxDecoration(
              //         color: Colors.amber,
              //         borderRadius: BorderRadius.circular(30.0)),
              //     child: Center(
              //       child: Text(
              //         'EMERGENCY',
              //         style: TextStyle(
              //           color: Colors.black,
              //           fontSize: 20.0,
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
