import 'package:bloc/bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

import '../../../data/remote/locatio_repo_impl.dart';
import '../../../domain/model/PlaceSuggesitation.dart';
import '../../../domain/model/place.dart';
import '../../../domain/model/place_direction.dart';


part 'maps_cubi_state.dart';

class MapsCubit extends Cubit<MapsState> {
  final MapsRepository _mapsRepository;

  MapsCubit(this._mapsRepository) : super(MapsInitial());
  void getPlaceSuggestions(String place, String sessionToken) {
    emit(PlacesLoading());
    _mapsRepository.fetchSuggestions(place, sessionToken).then((suggestions) {
      emit(PlacesLoaded(suggestions));
    });
  }

  void getPlaceLocation(String placeId, String sessionToken) {
    _mapsRepository.getPlaceLocation(placeId, sessionToken).then((place) {
      emit(PlaceLocationLoaded(place));
    });
  }
  void getPlaceDirections(LatLng origin, LatLng destination) {
    _mapsRepository.getDirections(origin, destination).then((directions) {
      emit(DirectionsLoaded(directions));
    });
  }
}
