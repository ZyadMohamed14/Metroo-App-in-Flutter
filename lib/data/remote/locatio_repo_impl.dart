
import 'package:google_maps_flutter_platform_interface/src/types/location.dart';

import '../../domain/model/PlaceSuggesitation.dart';
import '../../domain/model/place.dart';
import '../../domain/model/place_direction.dart';
import 'location_service.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';



class MapsRepository{
  Future<List<PlaceSuggestion>>fetchSuggestions(String place, String sessionToken)async{
    final suggestions =
    await placesWebservices.fetchSuggestions(place, sessionToken);

    return suggestions
        .map((suggestion) => PlaceSuggestion.fromJson(suggestion))
        .toList();
  }


  Future<Place> getPlaceLocation(String placeId, String sessionToken) async {
    final place =
    await placesWebservices.getPlaceLocation(placeId, sessionToken);
    // var readyPlace = Place.fromJson(place);
    return Place.fromJson(place);
  }
  final LocationWebservices placesWebservices;
  MapsRepository(this.placesWebservices);
  Future<PlaceDirections> getDirections(
      LatLng origin, LatLng destination) async {
    final directions =
    await placesWebservices.getDirections(origin , destination);

    return PlaceDirections.fromJson(directions);
  }
}