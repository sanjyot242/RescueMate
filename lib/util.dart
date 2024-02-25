import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rescuemate/shared-preferences.dart';

class ApiUtil {
  static Future<List<dynamic>> fetchData() async {
    final List<dynamic> nearbyData = [];
    double latitude = double.tryParse(SharedPref.getLatitude('Latitude') ?? '') ?? 0.0;
    double longitude = double.tryParse(SharedPref.getLongtitude('Longitude') ?? '') ?? 0.0;
    String type = 'hospital';
    
    try {
      final Uri url = Uri.parse('http://localhost:3000/api/nearby');
      
      Map<String, dynamic> parameters = {
        'latitude': latitude,
        'longitude': longitude,
        'type': type,
      };
      final response1 = await http.get(url.replace(queryParameters: parameters));
      
      if (response1.statusCode == 200) {
        final data1 = jsonDecode(response1.body);
        SharedPref.setHospitalData('hospitalData', jsonEncode(data1));
        nearbyData.add(data1);
      } else {
        print('Failed to load hospital data: ${response1.statusCode}');
      }
      
      type = 'pharmacy';
      parameters['type'] = type;
      final response2 = await http.get(url.replace(queryParameters: parameters));
      
      if (response2.statusCode == 200) {
        final data2 = jsonDecode(response2.body);
        SharedPref.setPharmacyData('pharmacyData', jsonEncode(data2));
        nearbyData.add(data2);
      } else {
        print('Failed to load pharmacy data: ${response2.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }

    return nearbyData;
  }
}