import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:smart_city/models/direction.dart';

class RoutesApiClient {
  final String _baseUrl;
  final http.Client _httpClient;
  final String _apiKey;

  RoutesApiClient({
    http.Client? httpClient,
    required String apiKey,
  }) : this._(
          baseUrl: 'https://routes.googleapis.com/directions',
          httpClient: httpClient,
          apiKey: apiKey,
        );

  RoutesApiClient._({
    required String baseUrl,
    http.Client? httpClient,
    required String apiKey,
  })  : _baseUrl = baseUrl,
        _httpClient = httpClient ?? http.Client(),
        _apiKey = apiKey;

  // https://developers.google.com/maps/documentation/places/web-service/search-find-place
  Future<Direction> getDirections(
    String origin,
    String destination, {
    String? travelMode,
    List<String>? waypoints,
  }) async {
    final uri = Uri.parse('$_baseUrl/v2:computeRoutes');
    final response = await _httpClient.post(
      uri,
      headers: {
        "Content-Type": "application/json",
        "X-Goog-Api-Key": _apiKey,
        "X-Goog-FieldMask":
            "routes.duration,routes.distanceMeters,routes.polyline.encodedPolyline,routes.legs.steps.start_location,routes.legs.steps.end_location"
      },
      body: jsonEncode({
        'origin': {'address': origin},
        'destination': {'address': destination},
        'computeAlternativeRoutes': true,
        'travelMode': travelMode ?? 'DRIVE', // DRIVE / WALK / TWO_WHEELER
        'intermediates': waypoints != null
            ? waypoints.map((waypoint) => {'address': waypoint}).toList()
            : [],
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Error getting the directions.');
    }

    final directionJson = jsonDecode(response.body);

    print(directionJson);
    // if (directionJson['status'] != 'OK') {
    //   throw Exception('Error: ${directionJson['status']}');
    // }

    return Direction.fromJson(directionJson);
  }
}
