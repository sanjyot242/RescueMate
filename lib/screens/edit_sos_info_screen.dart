import 'package:flutter/material.dart';
import 'package:rescuemate/shared-preferences.dart';

class EditSosInfoScreen extends StatefulWidget {
  @override
  _EditSosInfoScreenState createState() => _EditSosInfoScreenState();
}

class _EditSosInfoScreenState extends State<EditSosInfoScreen> {
  List<TextEditingController> _emergencyContactControllers = [];
  int _emergencyContactCount = 0;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _fetchEmergencyContactCount();
    _populateEmergencyContacts();
  }

  Future<void> _fetchEmergencyContactCount() async {
    String count = SharedPref.getEmergencyContactCount('EmergencyContactCount') ?? '0';
    setState(() {
      _emergencyContactCount = int.tryParse(count ?? '0') ?? 0;
      _emergencyContactControllers = List.generate(_emergencyContactCount, (index) => TextEditingController());
    });
  }

  Future<void> _populateEmergencyContacts() async {
    for (int i = 0; i < _emergencyContactCount; i++) {
      String key = 'EmergencyContact${i + 1}';
      String value = SharedPref.getEmergencyContact(key) ?? '';
      _emergencyContactControllers[i].text = value;
    }
  }

  Future<void> _saveChanges() async {
    for (int i = 0; i < _emergencyContactCount; i++) {
      String key = 'EmergencyContact${i + 1}';
      String value = _emergencyContactControllers[i].text;
      await SharedPref.setEmergencyContact(key, value);
    }
    setState(() {
      _isEditing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit SOS Info'),
        backgroundColor: Color.fromRGBO(180, 0, 255, 1), // Neon Purple color
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Emergency contact text fields
            Expanded(
              child: ListView.builder(
                itemCount: _emergencyContactCount,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: TextField(
                      controller: _emergencyContactControllers[index],
                      decoration: InputDecoration(
                        labelText: 'Emergency Contact ${index + 1}',
                        border: OutlineInputBorder(),
                        suffixIcon: _isEditing
                            ? IconButton(
                                icon: Icon(Icons.save),
                                onPressed: () {
                                  setState(() {
                                    _isEditing = false;
                                  });
                                  // Save the changes for this text field
                                  String key = 'EmergencyContact${index + 1}';
                                  String value = _emergencyContactControllers[index].text;
                                  SharedPref.setEmergencyContact(key, value);
                                },
                              )
                            : IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () {
                                  setState(() {
                                    _isEditing = true;
                                  });
                                  // Enable editing for this text field
                                  _emergencyContactControllers[index].selection = TextSelection.collapsed(offset: _emergencyContactControllers[index].text.length);
                                },
                              ),
                      ),
                      enabled: _isEditing,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
