import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rescuemate/route.dart' as route;

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(180, 0, 255, 1), // Using Neon Purple color
        elevation: 0, // Remove shadow
        title: Container(
          height: 40, // Height of the search bar
          padding: EdgeInsets.symmetric(horizontal: 16), // Padding for the search bar
          decoration: BoxDecoration(
            color: Colors.white, // Background color of the search bar
            borderRadius: BorderRadius.circular(20), // Rounded corners
          ),
          child: Row(
            children: [
              Icon(Icons.search), // Search icon on the left
              SizedBox(width: 8), // Spacer between icon and text field
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Your Problem', // Placeholder text
                    border: InputBorder.none, // Remove border
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
  PopupMenuButton(
    itemBuilder: (BuildContext context) {
      return [
        PopupMenuItem(
          child: ListTile(
            leading: Icon(Icons.edit),
            title: Text('Edit SOS Info'),
            onTap: () {
              // Handle action
              Navigator.pushNamed(context, route.editSosInfoScreen);
            },
          ),
        ),
      ];
    },
  ),
],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // SOS Button
            SizedBox(
              width: 200, // Width of the SOS button
              height: 200, // Height of the SOS button
              child: ElevatedButton(
                onPressed: () {
                  // Handle SOS action
                },
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100.0), // Make it round
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all<Color>(Color.fromRGBO(180, 0, 255, 1),), // Using Neon Purple color
                ),
                child: Text(
                  'SOS',
                  style: TextStyle(fontSize: 24), // Adjust font size
                ),
              ),
            ),
            SizedBox(height: 20), // Spacer
            // Find Hospitals Nearby Button
            ElevatedButton(
              onPressed: () async {
                Navigator.pushNamed(context, route.cardScreen);
               List<dynamic> jsonData = await fetchData();
              // Store the JSON data
              // For demonstration, let's just print it
              print(jsonData);
              },
              child: Text('Find Hospitals Nearby'),
            ),
            SizedBox(height: 10), // Spacer
            // Find Dispensaries Nearby Button
            ElevatedButton(
              onPressed: () {
                // Handle Find Dispensaries action
              },
              child: Text('Find Dispensaries Nearby'),
            ),
          ],
        ),
      ),
    );
  }
   // Function to fetch data from an endpoint
  // Function to fetch data from an endpoint
  Future<List<dynamic>> fetchData() async {
    final response = await http.get(Uri.parse('http://localhost:3000/api/hospitals/nearby2'));
    
    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON as a list
      return json.decode(response.body);
    } else {
      // If the server did not return a 200 OK response, throw an exception
      throw Exception('Failed to load data');
    }
  }

}
