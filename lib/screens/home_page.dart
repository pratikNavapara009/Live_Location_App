import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  requestPermission() async {
    await Permission.location.request();
  }

  @override
  void initState() {
    super.initState();
    requestPermission();
  }

  double latitude = 0;
  double longitude = 0;

  Placemark? area;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Live Location App",
        ),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Latitude : $latitude, Longitude: $longitude",
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                Geolocator.getPositionStream().listen((Position position) {
                  setState(() {
                    latitude = position.latitude;
                    longitude = position.longitude;
                  });
                });
              },
              child: const Text("Get Location"),
            ),
            Text(
              "$area",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                List<Placemark> placeMark =
                await placemarkFromCoordinates(latitude, longitude);

                setState(() {
                  area = placeMark[0];
                });
              },
              child: const Text(
                "Get Area",
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  Navigator.of(context).pushNamed("GoogleMapPage");
                });
              },
              child: const Text("Google Map"),
            ),
          ],
        ),
      ),
    );
  }
}