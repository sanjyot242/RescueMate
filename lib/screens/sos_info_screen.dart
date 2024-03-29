import 'package:flutter/material.dart';
import 'package:rescuemate/route.dart' as route;
import 'package:rescuemate/shared-preferences.dart';

class SosInfoScreen extends StatefulWidget {
  @override
  _SosInfoScreenState createState() => _SosInfoScreenState();
}

class _SosInfoScreenState extends State<SosInfoScreen> {
  List<TextEditingController> _emergencyContactControllers = [];
  int _maxEmergencyContacts = 5;

  @override
  void initState() {
    super.initState();
    _emergencyContactControllers.add(TextEditingController());
  }

  @override
  void dispose() {
    _emergencyContactControllers.forEach((controller) => controller.dispose());
    super.dispose();
  }

  Future<void> _saveEmergencyContacts() async {
    for (int i = 0; i < _emergencyContactControllers.length; i++) {
      String key = 'EmergencyContact${i + 1}';
      String value = _emergencyContactControllers[i].text;
      await SharedPref.setEmergencyContact(key, value);
    }
    await SharedPref.setEmergencyContactCount('EmergencyContactCount', _emergencyContactControllers.length.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SOS Information'),
        backgroundColor: Color.fromRGBO(180, 0, 255, 1),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _emergencyContactControllers.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: TextField(
                      controller: _emergencyContactControllers[index],
                      decoration: InputDecoration(
                        labelText: 'Emergency Contact ${index + 1}',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: _emergencyContactControllers.length < _maxEmergencyContacts
                  ? () {
                setState(() {
                  _emergencyContactControllers.add(TextEditingController());
                });
              }
                  : null,
              child: Text('Add Emergency Contact'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                await _saveEmergencyContacts();
                Navigator.pushNamed(context, route.mainScreen);
              },
              child: Text('Proceed'),
            ),
          ],
        ),
      ),
    );
  }
}
