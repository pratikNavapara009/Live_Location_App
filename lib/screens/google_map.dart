import 'package:flutter/material.dart';
import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../globals/globals_page.dart';


class GoogleMapPage extends StatefulWidget {
  const GoogleMapPage({Key? key}) : super(key: key);

  @override
  State<GoogleMapPage> createState() => _GoogleMapPageState();
}

class _GoogleMapPageState extends State<GoogleMapPage> {
  Completer<GoogleMapController> googleMapController = Completer();

  late CameraPosition currentPosition;

  @override
  void initState() {
    super.initState();
    currentPosition = CameraPosition(
      target: LatLng(Global.lat, Global.long),
      zoom: 15,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Google Map"),
        backgroundColor: Colors.black,
      ),
      body: Stack(
        children: [
          GoogleMap(
            cameraTargetBounds: CameraTargetBounds(
              LatLngBounds(
                southwest: LatLng(Global.lat, Global.long),
                northeast: LatLng(Global.lat, Global.long),
              ),
            ),
            onMapCreated: (GoogleMapController controller) {
              googleMapController.complete(controller);
            },
            initialCameraPosition: currentPosition,
            mapType: MapType.satellite,
            // mapToolbarEnabled: true,
            markers: {
              Marker(
                markerId: const MarkerId("Current Location"),
                position: LatLng(Global.lat, Global.long),
              ),
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () async {
          Geolocator.getPositionStream().listen((Position position) async {
            Global.lat = position.latitude;
            Global.long = position.longitude;
          });
          setState(() {
            currentPosition = CameraPosition(
              zoom: 10,
              target: LatLng(Global.lat, Global.long),
            );
          });
          print("================================");
          print(currentPosition);
          print("================================");
          final GoogleMapController controller =
          await googleMapController.future;
          controller.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                zoom: 80,
                target: LatLng(Global.lat, Global.long),
              ),
            ),
          );
        },
        child: const Icon(
          Icons.my_location_outlined,
          size: 36,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}