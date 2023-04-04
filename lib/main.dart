import 'package:flutter/material.dart';
import 'package:live_location_app/screens/google_map.dart';
import 'package:live_location_app/screens/home_page.dart';


void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const HomePage(),
        'GoogleMapPage': (context) => const GoogleMapPage(),
      },
    ),
  );
}