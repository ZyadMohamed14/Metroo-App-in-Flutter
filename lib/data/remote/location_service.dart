import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';
import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../helper/constans.dart';
class LocationWebservices {
  late Dio dio;

  LocationWebservices() {
    BaseOptions options = BaseOptions(
      connectTimeout: Duration(seconds: 20),
      receiveTimeout: Duration(seconds: 20),
      receiveDataWhenStatusError: true,
    );
    dio = Dio(options);
  }
  Future<List<dynamic>> fetchSuggestions(String place, String sessionToken)async {
    try{
      Response response = await dio.get(
        suggestionsBaseUrl,
        queryParameters: {
          'input': place,
          'types': 'address',
          'components': 'country:eg',
          'key': googleAPIKey,
          'sessiontoken': sessionToken
        },
      );
   //   print("zyad"+response.data['predictions']);
      print(response.statusCode);
      return response.data['predictions'];
    }catch (error) {
      print(error.toString());
      return [];
    }
  }
  Future<dynamic> getPlaceLocation(String placeId, String sessionToken) async {
    try {
      Response response = await dio.get(
        placeLocationBaseUrl,
        queryParameters: {
          'place_id': placeId,
          'fields': 'geometry',
          'key': googleAPIKey,
          'sessiontoken': sessionToken
        },
      );
      print('******************************************************');
      print(response.data);
      return response.data;
    } catch (error) {
      return Future.error("Place location error : ",
          StackTrace.fromString(('this is its trace')));
    }
  }
  // origin equals current location
  // destination equals searched for location
  Future<dynamic> getDirections(LatLng origin, LatLng destination) async {
    try {
      Response response = await dio.get(
        directionsBaseUrl,
        queryParameters: {
          'origin': '${origin.latitude},${origin.longitude}',
          'destination': '${destination.latitude},${destination.longitude}',
          'key': googleAPIKey,
        },
      );
      print("******************************************");
      print(response.data);
      return response.data;
    } catch (error) {
      return Future.error("Place location error : ",
          StackTrace.fromString(('this is its trace')));
    }
  }

}
