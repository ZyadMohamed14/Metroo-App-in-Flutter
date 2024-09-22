import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../domain/model/place_direction.dart';
import '../presentation/map/maps_cubi_cubit.dart';

class MapScreen extends StatefulWidget {
  final LatLng currentLocationposition;
  final LatLng stationposition;

  const MapScreen(
      {Key? key,
      required this.currentLocationposition,
      required this.stationposition})
      : super(key: key);

  @override
  State<MapScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MapScreen> {
  Completer<GoogleMapController> _mapController = Completer();
  late CameraPosition _myCurrentLocationCameraPosition;
  late Marker neareStationMarker;
  late Marker currentLocationMarker;
  PlaceDirections? placeDirections;
  late List<LatLng> polylinePoints;
  Set<Marker> markers = Set();

  // Variable to store the updated camera position
  LatLng? currentMapCenterPosition;

  @override
  void initState() {
    super.initState();
    _myCurrentLocationCameraPosition = CameraPosition(
      bearing: 0.0,
      target: widget.currentLocationposition,
      tilt: 0.0,
      zoom: 17,
    );
    // Build the markers
    buildCurrentLocationMarker(
        latitude: widget.currentLocationposition.latitude,
        longitude: widget.currentLocationposition.longitude
    );


    // Request directions from MapsCubit
    BlocProvider.of<MapsCubit>(context).getPlaceDirections(
      widget.currentLocationposition,
      widget.stationposition,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          widget.currentLocationposition != null
              ? _buildMap()
              : Center(
            child: Container(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            ),
          ),
          buildDiretionsBloc(),
        ],
      ),
      floatingActionButton: Container(
        margin: EdgeInsets.fromLTRB(0, 0, 8, 30),
        child: FloatingActionButton(
          backgroundColor: Colors.blue,
          onPressed: _goToMyCurrentLocation,
          child: Icon(Icons.place, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildMap() {
    return GoogleMap(
      mapType: MapType.normal,
      myLocationButtonEnabled: false,
      zoomControlsEnabled: true,
      myLocationEnabled: true,
      markers: markers,
      onTap: _getcurrentLocationPresssedOnMap,
      initialCameraPosition: _myCurrentLocationCameraPosition,
      onMapCreated: (GoogleMapController controller) {
        _mapController.complete(controller);
      },
      polylines: placeDirections != null
          ? {
        Polyline(
            polylineId: const PolylineId('MyPolyID'),
            color: Colors.lightBlue,
            width: 4,
            points: polylinePoints)
      }
          : {},

    );
  }

  Future<void> _goToMyCurrentLocation() async {
    final GoogleMapController controller = await _mapController.future;
    controller.animateCamera(
        CameraUpdate.newCameraPosition(_myCurrentLocationCameraPosition));
  }

  void buildCurrentLocationMarker(
      {required double latitude, required double longitude}) {
    currentLocationMarker = Marker(
      position: LatLng(latitude,
          longitude),
      markerId: MarkerId('2'),
      onTap: () {},
      infoWindow: InfoWindow(title: "Your current Location"),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
    );
    setState(() {
      // Remove the old marker and add the updated one
      markers.removeWhere((marker) => marker.markerId.value == '2');
      markers.add(currentLocationMarker);
    });
  }

  void buildNearstStaionLocationMarker() {
    neareStationMarker = Marker(
      position: widget.stationposition,
      markerId: MarkerId('3'),
      onTap: () {},
      infoWindow: InfoWindow(title: " station Location"),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
    );
    setState(() {
      markers.add(neareStationMarker);
    });
  }

  Widget buildDiretionsBloc() {
    return BlocListener<MapsCubit, MapsState>(
      listener: (context, state) {
        if (state is DirectionsLoaded) {
          placeDirections = (state).placeDirections;
          getPolylinePoints();
          buildNearstStaionLocationMarker();
          _zoomOutToFitPolyline();
        }
      },
      child: SizedBox(),
    );
  }

  void getPolylinePoints() {
    polylinePoints = placeDirections!.polylinePoints
        .map((e) => LatLng(e.latitude, e.longitude))
        .toList();
    setState(() {});
  }

  void _getcurrentLocationPresssedOnMap(LatLng tappedPoint) {
    setState(() {
      currentMapCenterPosition = tappedPoint; // Save the tapped position

      // Update the marker to the new location
      markers.clear(); // Clear any existing markers
      markers.add(
        Marker(
          markerId: MarkerId(tappedPoint.toString()),
          position: tappedPoint,
          infoWindow: InfoWindow(
            title: 'Selected Location',
            snippet: '${tappedPoint.latitude}, ${tappedPoint.longitude}',
          ),
        ),
      );
    });
  }


  void _zoomOutToFitPolyline() async {
    if (polylinePoints.isNotEmpty) {
      LatLngBounds bounds = _calculateLatLngBounds(polylinePoints);

      final GoogleMapController controller = await _mapController.future;
      controller.animateCamera(
          CameraUpdate.newLatLngBounds(bounds, 100)); // padding of 100
    }
  }

  LatLngBounds _calculateLatLngBounds(List<LatLng> points) {
    double southWestLat = points.first.latitude;
    double southWestLng = points.first.longitude;
    double northEastLat = points.first.latitude;
    double northEastLng = points.first.longitude;

    for (var point in points) {
      if (point.latitude < southWestLat) southWestLat = point.latitude;
      if (point.longitude < southWestLng) southWestLng = point.longitude;
      if (point.latitude > northEastLat) northEastLat = point.latitude;
      if (point.longitude > northEastLng) northEastLng = point.longitude;
    }

    return LatLngBounds(
      southwest: LatLng(southWestLat, southWestLng),
      northeast: LatLng(northEastLat, northEastLng),
    );
  }


}
