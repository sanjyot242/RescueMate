import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:rescuemate/shared-preferences.dart';

class Dispensary {
  final String name;
  final bool isOpen;
  final String address;

  Dispensary({
    required this.name,
    required this.isOpen,
    required this.address,
  });

  factory Dispensary.fromJson(Map<String, dynamic> json) {
    return Dispensary(
      name: json['name'] ?? '',
      isOpen: json['isOpen'] ?? false,
      address: json['address'] ?? '',
    );
  }
}

class ViewDispensaryScreen extends StatefulWidget {
  @override
  _ViewDispensaryScreenState createState() => _ViewDispensaryScreenState();
}

class _ViewDispensaryScreenState extends State<ViewDispensaryScreen> {
  List<Dispensary> dispensaries = [];

  @override
  void initState() {
    super.initState();
    _loadDispensaries();
  }

  Future<void> _loadDispensaries() async {
    String jsonData = SharedPref.getPharmacyData('pharmacyData') ?? '';

    List<dynamic> parsedJson = json.decode(jsonData);
    List<Dispensary> loadedDispensaries =
        parsedJson.map((json) => Dispensary.fromJson(json)).toList();

    setState(() {
      dispensaries = loadedDispensaries;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dispensaries'),
      ),
      body: ListView.builder(
        itemCount: dispensaries.length,
        itemBuilder: (context, index) {
          Dispensary dispensary = dispensaries[index];
          return ListTile(
            title: Text(dispensary.name),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Status: ${dispensary.isOpen ? 'Open' : 'Closed'}'),
                Text('Address: ${dispensary.address}'),
              ],
            ),
          );
        },
      ),
    );
  }
}