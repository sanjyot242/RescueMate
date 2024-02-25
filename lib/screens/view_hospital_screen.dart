import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rescuemate/shared-preferences.dart';

class Hospital {
  final String name;
  final bool isOpen;
  final String address;

  Hospital({
    required this.name,
    required this.isOpen,
    required this.address,
  });

  factory Hospital.fromJson(Map<String, dynamic> json) {
    return Hospital(
      name: json['name'] ?? '',
      isOpen: json['isOpen'] ?? false,
      address: json['address'] ?? '',
    );
  }
}

class ViewHospitalScreen extends StatefulWidget {
  @override
  _ViewHospitalScreenState createState() => _ViewHospitalScreenState();
}

class _ViewHospitalScreenState extends State<ViewHospitalScreen> {
  List<Hospital> hospitals = [];

  @override
  void initState() {
    super.initState();
    _loadHospitals();
  }

  Future<void> _loadHospitals() async {
    String jsonData = SharedPref.getHospitalData('hospitalData') ?? '';

    List<dynamic> parsedJson = json.decode(jsonData);
    List<Hospital> loadedHospitals =
        parsedJson.map((json) => Hospital.fromJson(json)).toList();

    setState(() {
      hospitals = loadedHospitals;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hospitals'),
      ),
      body: ListView.builder(
        itemCount: hospitals.length,
        itemBuilder: (context, index) {
          Hospital hospital = hospitals[index];
          return ListTile(
            title: Text(hospital.name),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Status: ${hospital.isOpen ? 'Open' : 'Closed'}'),
                Text('Address: ${hospital.address}'),
              ],
            ),
          );
        },
      ),
    );
  }
}