import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rescuemate/route.dart' as route;

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  LocationData? _currentLocation;

  @override
  void initState() {
    super.initState();
    _fetchLocationAndPermissions();
  }

  Future<void> _fetchLocationAndPermissions() async {
    // Request location and phone permissions
    /*await _requestPermissions();

    // Check if location service is enabled
    var serviceEnabled = await Location().serviceEnabled();
    if (!serviceEnabled) {
      // Request to enable location service
      serviceEnabled = await Location().requestService();
      if (!serviceEnabled) {
        // Location service is still not enabled, handle accordingly
        return;
      }
    }

    // Fetch current location
    _currentLocation = await Location().getLocation();
    // Store current location
    // You can implement the storage logic here, like using shared preferences
    // For simplicity, let's just print the location
    print('Current Location: ${_currentLocation!.latitude}, ${_currentLocation!.longitude}');*/

    // Now you can navigate to the next screen (SOSInfoScreen)
    Navigator.pushNamed(context, route.sosInfoScreen);
  }

  Future<void> _requestPermissions() async {
    // Request location permission
    var locationStatus = await Permission.location.request();
    if (locationStatus.isDenied) {
      // Permission denied, handle accordingly
    }

    // Request phone permission
    var phoneStatus = await Permission.phone.request();
    if (phoneStatus.isDenied) {
      // Permission denied, handle accordingly
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image(image: AssetImage('assets/splash_image.png'), fit: BoxFit.fitWidth),
      ),
    );
  }
}