import 'dart:convert';

import 'package:http/http.dart' as http;

class GeocodingApiClient {
  final String _baseUrl;
  final http.Client _httpClient;
  final String _apiKey;

  GeocodingApiClient({
    http.Client? httpClient,
    required String apiKey,
  }) : this._(
          baseUrl: 'https://maps.googleapis.com/maps/api/geocode',
          httpClient: httpClient,
          apiKey: apiKey,
        );

  GeocodingApiClient._({
    required String baseUrl,
    http.Client? httpClient,
    required String apiKey,
  })  : _baseUrl = baseUrl,
        _httpClient = httpClient ?? http.Client(),
        _apiKey = apiKey;

  // https://developers.google.com/maps/documentation/geocoding/requests-geocoding
  Future<Map<String, dynamic>> getLatLng(String address) async {
    final uri = Uri.parse('$_baseUrl/json').replace(
      queryParameters: <String, String>{
        'address': address,
        'key': _apiKey,
      },
    );
    final response = await _httpClient.get(uri);

    if (response.statusCode != 200) {
      throw Exception('Error getting the address from LatLon.');
    }
    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> getAddress(double lat, double lng) async {
    final uri = Uri.parse('$_baseUrl/json').replace(
      queryParameters: <String, String>{
        'latlng': '$lat,$lng',
        'key': _apiKey,
      },
    );

    final response = await _httpClient.get(uri);

    if (response.statusCode != 200) {
      throw Exception(
          'Error getting the address from LatLon ${response.statusCode}.}');
    }

    return jsonDecode(response.body);
  }
}
