import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Emergency extends StatefulWidget {
  const Emergency({super.key});

  @override
  State<Emergency> createState() => _EmergencyState();
}

class _EmergencyState extends State<Emergency> {
  void _openMap(String latitude, String longitude) async {
    String googleMapsUri =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    await launchUrlString(googleMapsUri);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('EMERGENCY PAGE'),
        backgroundColor: Colors.amber,
      ),
      body: Column(
        children: [
          SizedBox(height: 30),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('emergency')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasData) {
                  final documents = snapshot.data!.docs;

                  return ListView.builder(
                    itemCount: documents.length,
                    itemBuilder: (context, index) {
                      final data =
                          documents[index].data() as Map<String, dynamic>;

                      final detail = data['detail'] ?? 'No detail available';
                      final happend =
                          data['happend'] ?? 'No information available';
                      final imageUrl = data['image'] ?? '';
                      final imagecamUrl = data['imagecam'] ?? '';
                      final latitude = data['latitude']?.toString();
                      final longitude = data['longitude']?.toString();

                      return Card(
                        margin:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (imageUrl.isNotEmpty)
                              Image.network(imageUrl, fit: BoxFit.cover),
                            if (imagecamUrl.isNotEmpty)
                              Image.network(imagecamUrl, fit: BoxFit.cover),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                'Detail: $detail',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                'Happened: $happend',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                            if (latitude != null && longitude != null)
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: ElevatedButton(
                                  onPressed: () =>
                                      _openMap(latitude, longitude),
                                  child: Text('Open in Google Maps'),
                                ),
                              ),
                          ],
                        ),
                      );
                    },
                  );
                }

                return Center(child: Text('No data found.'));
              },
            ),
          ),
        ],
      ),
    );
  }
}
