import 'dart:async';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:travel_hub/navigation/maps/services/location_service.dart';


class FullMapController {
  final Completer<GoogleMapController> googleController = Completer();

  CameraPosition? cameraPosition;
  Marker? myMarker;

  Future<void> setInitialLocation(Function refreshUI) async {
    Position pos = await LocationService.determinePosition();

    cameraPosition = CameraPosition(
      target: LatLng(pos.latitude, pos.longitude),
      zoom: 15,
    );

    myMarker = Marker(
      markerId: const MarkerId("me"),
      position: LatLng(pos.latitude, pos.longitude),
      infoWindow: const InfoWindow(title: "My Location"),
    );

    refreshUI();
  }

  Future<void> goToMyLocation(Function refreshUI) async {
    Position pos = await LocationService.determinePosition();
    final controller = await googleController.future;

    controller.animateCamera(
      CameraUpdate.newLatLngZoom(
        LatLng(pos.latitude, pos.longitude),
        16,
      ),
    );
  }

  Future<void> searchLocation(String query, Function refreshUI) async {
    if (query.isEmpty) return;

    final locations = await locationFromAddress(query);
    if (locations.isEmpty) throw Exception("No results found");

    final loc = locations.first;
    final controller = await googleController.future;

    controller.animateCamera(
      CameraUpdate.newLatLngZoom(LatLng(loc.latitude, loc.longitude), 15),
    );

    myMarker = Marker(
      markerId: const MarkerId("searchResult"),
      position: LatLng(loc.latitude, loc.longitude),
      infoWindow: InfoWindow(title: query),
    );

    refreshUI();
  }
}
