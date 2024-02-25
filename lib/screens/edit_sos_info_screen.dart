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
  int _editableIndex = -1;

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
    String key = 'EmergencyContact${_editableIndex + 1}';
    String value = _emergencyContactControllers[_editableIndex].text;
    await SharedPref.setEmergencyContact(key, value);
    setState(() {
      _isEditing = false;
      _editableIndex = -1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit SOS Info'),
        backgroundColor: Color.fromRGBO(180, 0, 255, 1), // Neon Purple color
        actions: [
          if (_isEditing)
            IconButton(
              icon: Icon(Icons.save),
              onPressed: _saveChanges,
            ),
        ],
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
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _emergencyContactControllers[index],
                            decoration: InputDecoration(
                              labelText: 'Emergency Contact ${index + 1}',
                              border: OutlineInputBorder(),
                            ),
                            enabled: _isEditing && _editableIndex == index,
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            setState(() {
                              _isEditing = true;
                              _editableIndex = index;
                            });
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 16), // Spacer
            if (_isEditing)
              ElevatedButton(
                onPressed: _saveChanges,
                child: Text('Save'),
              ),
          ],
        ),
      ),
    );
  }
}
