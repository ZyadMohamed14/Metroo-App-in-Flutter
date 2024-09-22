import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:dartz/dartz.dart';

class LocationHelper {
  static Future<Position> getCurrentLocation() async {
    bool isServicesEnabel = await Geolocator.isLocationServiceEnabled();

    if (!isServicesEnabel) {
      await Geolocator.requestPermission();
    }
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  static Future<bool> checkPermission() async {
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
    if (await checkPermission()) {
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
