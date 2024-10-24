import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:dartz/dartz.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationHelper {
  static Future<Position> getCurrentLocation() async {
    // Check if location services are enabled
    bool isServicesEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isServicesEnabled) {
      throw Exception('Location services are disabled.'); // Notify that location services are disabled
    }

    // Check permission status
    LocationPermission permission = await Geolocator.checkPermission();

    // Request permission if it is denied
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied.'); // Notify that permissions are denied
      }
    }

    // Check if permission is permanently denied
    if (permission == LocationPermission.deniedForever) {
      throw Exception(
          'Location permissions are permanently denied. We cannot request permissions.'); // Notify that permissions are permanently denied
    }

    // If we reach this point, permissions are granted and services are enabled
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }
  // static Future<Either<String, LatLng>> getCurrentLocation() async {
  //
  //   try{
  //     LocationPermission permission = await Geolocator.checkPermission();
  //     // If permission is already granted, return true
  //     if (permission == LocationPermission.whileInUse ||
  //         permission == LocationPermission.always) {
  //       final position =  await Geolocator.getCurrentPosition(
  //           desiredAccuracy: LocationAccuracy.high);
  //       return Right(LatLng(position.latitude,position.longitude));
  //     }
  //     // Request permission if it is denied
  //     permission = await Geolocator.requestPermission();
  //
  //     // Return location if permission is granted, false otherwise
  //     if (permission == LocationPermission.whileInUse ||
  //         permission == LocationPermission.always) {
  //       final position =  await Geolocator.getCurrentPosition(
  //           desiredAccuracy: LocationAccuracy.high);
  //       return Right(LatLng(position.latitude,position.longitude));
  //     }
  //     else{
  //       return const Left("Please Enable Location Services To Find Nearest Station For You");
  //     }
  //
  //   }catch (e) {
  //     // Log the exception or handle it as needed
  //     print('Error checking or requesting location permission: $e');
  //     return const Left("Error checking or requesting location permission");
  //   }
  // }

  static Future<bool> checkLocationPermission() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();

      // If permission is already granted, return true
      if (permission == LocationPermission.whileInUse ||
          permission == LocationPermission.always) {
        return true;
      }

      // Request permission if it is denied
      permission = await Geolocator.requestPermission();

      // Return true if permission is granted, false otherwise
      return permission == LocationPermission.whileInUse ||
          permission == LocationPermission.always;
    } catch (e) {
      // Log the exception or handle it as needed
      print('Error checking or requesting location permission: $e');
      return false; // Return false if there's an error
    }
  }

  static Future<Either<String, Location>> getLatLngFromAddress(String address) async {
    // Make sure to handle permissions if needed
    if (await checkLocationPermission()) {
      try {

        String fullAddress = "$address, Egypt";
        List<Location> locations = await locationFromAddress(fullAddress);

        if (locations.isNotEmpty) {
          Location location = locations.first;
          return Right(location); // Success
        } else {
          return Left('No locations found for the address'); // Error
        }
      } catch (e) {
        return Left('Error getting location: $e'); // Error
      }
    } else {
      // Handle the case where the permission is denied and return a Left
      return Left('Please enable your location'); // Error when location is disabled
    }
  }

}
