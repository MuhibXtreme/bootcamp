import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapp extends StatefulWidget {
  const GoogleMapp({super.key});

  @override
  State<GoogleMapp> createState() => _GoogleMappState();
}

class _GoogleMappState extends State<GoogleMapp> {
  Completer<GoogleMapController> _controller = Completer();

  Future<Position> getuserlocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) async {
      await Geolocator.requestPermission();
      // print("Error${error.toString()}");
    });
    return await Geolocator.getCurrentPosition();
  }

  final CameraPosition myloc = const CameraPosition(
    target: LatLng(34.0015, 71.5479),
    zoom: 14,
  );

  List<Marker> marker = [
    const Marker(
        markerId: MarkerId('1'),
        position: LatLng(34.0015, 71.5479),
        infoWindow: InfoWindow(title: 'Saddar'))
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: myloc,
        markers: Set.of(marker),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getuserlocation().then((value) async {
            
            marker.add(Marker(
                markerId: const MarkerId('2'),
                position: LatLng(value.latitude, value.longitude),
                infoWindow: const InfoWindow(title: 'Current location')));

            CameraPosition cameraPosition = CameraPosition(
                target: LatLng(value.latitude, value.longitude), zoom: 14);



            final GoogleMapController controller = await _controller.future;
            controller
                .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
            setState(() {});
          });
        },
        child: const Icon(Icons.location_history),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
