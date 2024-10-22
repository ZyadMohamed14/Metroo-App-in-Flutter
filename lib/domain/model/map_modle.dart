import 'package:google_maps_flutter/google_maps_flutter.dart';
class MapModel {
  final LatLng currentLocation;
  final LatLng nearestStationLocation;
  final String? currentLocationName;
  final String? nearestStationName;
  final String? destinationStation;

  MapModel({
    required this.currentLocation,
    required this.nearestStationLocation,
    this.currentLocationName,
    this.nearestStationName,
    this.destinationStation,
  });
}