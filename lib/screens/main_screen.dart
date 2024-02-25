import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(180, 0, 255, 1),
          elevation: 0,
          title: Container(
            height: 40,
            padding: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Icon(Icons.search),
                SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Your Problem',
                      border: InputBorder.none,
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
              SizedBox(
                width: 200,
                height: 200,
                child: ElevatedButton(
                  onPressed: () {
                    // Handle SOS action
                  },
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100.0),
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.all<Color>(Color.fromRGBO(180, 0, 255, 1),), // Using Neon Purple color
                  ),
                  child: Text(
                    'SOS',
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  List<dynamic> jsonData = await fetchData();
                  print(jsonData);
                },
                child: Text('Find Hospitals Nearby'),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                },
                child: Text('Find Dispensaries Nearby'),
              ),
            ],
          ),
        ),
      ),
      onWillPop: onWillPop,
    );
  }
  
  Future<List<dynamic>> fetchData() async {
    final response = await http.get(Uri.parse('http://localhost:3000/api/nearby'));
    print(response.body);
    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON as a list
      return json.decode(response.body);
    } else {
      // If the server did not return a 200 OK response, throw an exception
      throw Exception('Failed to load data');
    }
  }

  void _exitApp() {
    SystemNavigator.pop();
  }

  Future _openExitDialog() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
            content: Container(
                constraints: BoxConstraints.tightFor(height: 100.0),
                child: Center(
                  child: Column(
                    children: [
                      const Text(
                        'Confirm Exit?',
                        style: TextStyle(fontSize: 22.0),
                      ),
                      const SizedBox(height: 20.0),
                      ElevatedButton(onPressed: _exitApp, child: Text('Exit'))
                    ],
                  ),
                ))),
      );


  Future<bool> onWillPop() async {
    await _openExitDialog();
    return false;
  }
}
