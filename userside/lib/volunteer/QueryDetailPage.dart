import 'package:flutter/material.dart';

class QueryDetailPage extends StatelessWidget {
  final Map<String, dynamic> data;
  final String documentId;

  const QueryDetailPage(
      {super.key, required this.data, required this.documentId});

  @override
  Widget build(BuildContext context) {
    final address = data['address'] ?? 'No address available';
    final latitude = data['latitude']?.toString() ?? 'No latitude';
    final longitude = data['longitude']?.toString() ?? 'No longitude';
    final name = data['name'] ?? 'No name available';
    final phone = data['phone'] ?? 'No phone number available';
    final queryName = data['queryname'] ?? 'No query name available';

    return Scaffold(
      appBar: AppBar(
        title: Text('Query Details'),
        backgroundColor: Colors.amber,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Address: $address', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Latitude: $latitude', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Longitude: $longitude', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Name: $name', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Phone: $phone', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Query Name: $queryName', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
