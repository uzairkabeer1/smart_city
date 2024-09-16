import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:smart_city/models/direction.dart';

import '../models/photo_image.dart';
import '../models/place.dart';
import '../models/place_autocomplete_prediction.dart';
import '../services/api/geocoding_api_client.dart';
import '../services/api/places_api_client.dart';
import '../services/api/routes_api_client.dart';
import '../services/location_service.dart';

part 'maps_repository.g.dart';

@riverpod
MapsRepository mapsRepository(MapsRepositoryRef ref) => MapsRepository();

class MapsRepository {
  final PlacesApiClient _placesApiClient;
  final RoutesApiClient _routesApiClient;
  final GeocodingApiClient _geocodingApiClient;
  final LocationService _locationService;

  MapsRepository({
    PlacesApiClient? placesApiClient,
    RoutesApiClient? routesApiClient,
    GeocodingApiClient? geocodingApiClient,
    LocationService? locationService,
  })  : _placesApiClient = placesApiClient ??
            PlacesApiClient(
              apiKey: dotenv.env['API_KEY']!,
            ),
        _routesApiClient = routesApiClient ??
            RoutesApiClient(
              apiKey: dotenv.env['API_KEY']!,
            ),
        _geocodingApiClient = geocodingApiClient ??
            GeocodingApiClient(
              apiKey: dotenv.env['API_KEY']!,
            ),
        _locationService = locationService ?? const LocationService();

  /// Takes an address and latitude-longitude (LatLng) as input and
  /// returns detailed information about the place and a photo of it.
  /// It first finds the place_id of the address and then fetches
  /// detailed information about the place including a photo of it.
  Future<(Place, PhotoImage)> getDetailedPlaceFromAddress(
    String address,
    LatLng latLng,
  ) async {
    final locationBias = 'circle:10000@${latLng.latitude},${latLng.longitude}';

    // Get the place_id from the address
    final place = await _placesApiClient.findPlaceFromText(
      address,
      locationBias,
    );

    // Get detailed place information from the place_id
    final placeDetails = await _placesApiClient.getDetailedPlace(place.placeId);

    // Get one picture from the place
    final placePhoto = await _placesApiClient.getPlacePhoto(
      placeDetails.photos[0].photoReference,
      placeDetails.photos[0].height,
      placeDetails.photos[0].width,
    );

    return (placeDetails, placePhoto);
  }

  /// This method provides real-time suggestions as users type in a search box.
  /// It improves the user experience by reducing typing errors and speeding up the search process.
  Future<List<PlaceAutocompletePrediction>> getPlaceAutocompletePredictions(
    String input,
  ) async {
    final predictions = await _placesApiClient.getAutocompletePredictions(
      input,
    );
    // print(predictions.map((e) => e.description).toList());
    return predictions;
  }

  /// This method fetches directions from origin to destination.
  Future<Direction> getDirections(
    String origin,
    String destination,
  ) async {
    final directions = await _routesApiClient.getDirections(
      origin,
      destination,
    );

    return directions;
  }

  /// Fetches the current location of the user.
  Future<Position?> getCurrentUserLocation() async {
    final location = await _locationService.getCurrentPosition();
    return location;
  }

  /// Fetches the current address of the user.
  Future<String?> getCurrentUserAddress() async {
    final location = await _locationService.getCurrentPosition();
    if (location != null) {
      final geoData = await _geocodingApiClient.getAddress(
        location.latitude,
        location.longitude,
      );

      String? address = geoData['results'][0]['formatted_address'];
      return address;
    } else {
      return null;
    }
  }
}
