import 'package:flutter/material.dart';

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
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              // Handle action
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
              onPressed: () {
                // Handle Find Hospitals action
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
}