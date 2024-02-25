import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rescuemate/route.dart' as route;
import 'package:rescuemate/shared-preferences.dart';
import 'package:rescuemate/util.dart';

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
    await _requestPermissions();

    var serviceEnabled = await Location().serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await Location().requestService();
      if (!serviceEnabled) {
        _openLocationDeniedDialog();
        return;
      }
    }

    _currentLocation = await Location().getLocation();
    String latitude = _currentLocation!.latitude.toString();
    String longitude = _currentLocation!.longitude.toString();
    SharedPref.setLatitude('Latitude', latitude);
    SharedPref.setLongtitude('Longitude', longitude);
    print('Current Location: ${_currentLocation!.latitude}, ${_currentLocation!.longitude}');

    // Fetching hospital and pharmacy data from API
    ApiUtil.fetchData();
    Navigator.pushNamed(context, route.sosInfoScreen);
  }

  Future<void> _requestPermissions() async {
    var locationStatus = await Permission.location.request();
    if (locationStatus.isDenied) {
      _openLocationDeniedDialog();
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
  
  void _openLocationDeniedDialog() {
    Future _openExitDialog() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Container(
          constraints: BoxConstraints.tightFor(height: 100.0),
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  const Text(
                    'Location Permission needed to show nearby hospitals',
                    style: TextStyle(fontSize: 22.0),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  
  void _openPhonePermissionDeniedDialog() {
    Future _openExitDialog() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Container(
          constraints: BoxConstraints.tightFor(height: 100.0),
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  const Text(
                    'Call Permission needed to send SOS',
                    style: TextStyle(fontSize: 22.0),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
