import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../models/photo_image.dart';
import '../../models/place.dart';
import '../../models/place_autocomplete_prediction.dart';
import '../../models/query_autocomplete_prediction.dart';

class PlacesApiClient {
  final String _baseUrl;
  final http.Client _httpClient;
  final String _apiKey;

  PlacesApiClient({
    http.Client? httpClient,
    required String apiKey,
  }) : this._(
          baseUrl: 'https://maps.googleapis.com/maps/api/place',
          httpClient: httpClient,
          apiKey: apiKey,
        );

  PlacesApiClient._({
    required String baseUrl,
    http.Client? httpClient,
    required String apiKey,
  })  : _baseUrl = baseUrl,
        _httpClient = httpClient ?? http.Client(),
        _apiKey = apiKey;

  /// The Find Place API is a service that allows developers to search for
  /// specific places using the name, address, or a simple keyword.
  ///
  /// [inputText] - the name, address, or keyword to search for
  /// [locationBias] - the preferred area to find places
  Future<Place> findPlaceFromText(
    String inputText,
    String locationBias,
  ) async {
    final uri = Uri.parse('$_baseUrl/findplacefromtext/json').replace(
      queryParameters: <String, String>{
        'fields':
            'place_id,geometry,name,formatted_address,rating,opening_hours,photos',
        'locationbias': locationBias,
        'inputtype': 'textquery',
        'input': inputText,
        'key': _apiKey,
      },
    );

    final response = await _httpClient.get(uri);

    if (response.statusCode != 200) {
      throw Exception('Error finding place from text.');
    }

    final placeJson = jsonDecode(response.body);

    if (placeJson['status'] != 'OK') {
      throw Exception('Error: ${placeJson['status']}');
    }

    final place = Place.fromJson(placeJson['candidates'][0]);
    return place;
  }

  /// The Text Search API is a web-based service that allows developers to search
  /// for places within the vast Google Maps database using natural language queries.
  ///
  /// [query] - The natural language query to search for
  Future<List<Place>> performTextSearch(String query) async {
    final uri = Uri.parse('$_baseUrl/textsearch/json').replace(
      queryParameters: <String, String>{
        'query': query,
        'key': _apiKey,
      },
    );

    final response = await _httpClient.get(uri);

    if (response.statusCode != 200) {
      throw Exception('Error finding place from text.');
    }

    final responseJson = jsonDecode(response.body);
    var results = responseJson['results'] as List;

    return results.map((place) => Place.fromJson(place)).toList();
  }

  /// The Place Autocomplete API provides real-time suggestions as users type
  /// in a search box.
  ///
  /// [input] - The text input to get autocomplete predictions
  Future<List<PlaceAutocompletePrediction>> getAutocompletePredictions(
    String input,
  ) async {
    final uri = Uri.parse('$_baseUrl/autocomplete/json').replace(
      queryParameters: <String, String>{
        'input': input,
        'key': _apiKey,
      },
    );

    final response = await _httpClient.get(uri);

    if (response.statusCode != 200) {
      throw Exception('Error finding place from text.');
    }

    final responseJson = jsonDecode(response.body);
    var predictions = responseJson['predictions'] as List;

    return predictions
        .map((prediction) => PlaceAutocompletePrediction.fromJson(prediction))
        .toList();
  }

  /// The Query Autocomplete service can be used to provide a query prediction
  /// for text-based geographic searches, by returning suggested queries as you type.
  ///
  /// [input] - The text input to get query autocomplete predictions
  Future<List<QueryAutocompletePrediction>> getQueryPredictions(
    String input,
  ) async {
    final uri = Uri.parse('$_baseUrl/queryautocomplete/json').replace(
      queryParameters: <String, String>{
        'input': input,
        'key': _apiKey,
      },
    );

    final response = await _httpClient.get(uri);

    if (response.statusCode != 200) {
      throw Exception('Error finding place from text.');
    }

    final responseJson = jsonDecode(response.body);
    var predictions = responseJson['predictions'] as List;

    return predictions
        .map((prediction) => QueryAutocompletePrediction.fromJson(prediction))
        .toList();
  }

  /// The Place Details API returns more detailed information about a place,
  /// including user reviews.
  ///
  /// [placeId] - The unique ID of the place
  Future<Place> getDetailedPlace(String placeId) async {
    final uri = Uri.parse('$_baseUrl/details/json').replace(
      queryParameters: <String, String>{
        'place_id': placeId,
        'key': _apiKey,
      },
    );

    final response = await _httpClient.get(uri);

    if (response.statusCode != 200) {
      throw Exception('Error finding place from text.');
    }

    final placeJson = jsonDecode(response.body);

    if (placeJson['status'] != 'OK') {
      throw Exception('Error: ${placeJson['status']}');
    }

    final place = Place.fromJson(placeJson['result']);
    return place;
  }

  /// The Place Photos API provides millions of place-related photos.
  ///
  /// [photoReference] - The unique reference of the photo
  /// [height] - The preferred height of the photo
  /// [width] - The preferred width of the photo
  Future<PhotoImage> getPlacePhoto(
    String photoReference,
    int height,
    int width,
  ) async {
    final uri = Uri.parse('$_baseUrl/photo').replace(
      queryParameters: <String, String>{
        'photo_reference': photoReference,
        'maxheight': '$height',
        'maxwidth': '$width',
        'key': _apiKey,
      },
    );

    final response = await _httpClient.get(uri);
    return PhotoImage(imageData: response.bodyBytes);
  }
}


// class PlacesApiClient {
//   final String _baseUrl;
//   final http.Client _httpClient;
//   final String _apiKey;

//   PlacesApiClient({
//     http.Client? httpClient,
//     required String apiKey,
//   }) : this._(
//           baseUrl: 'https://maps.googleapis.com/maps/api/place',
//           httpClient: httpClient,
//           apiKey: apiKey,
//         );

//   PlacesApiClient._({
//     required String baseUrl,
//     http.Client? httpClient,
//     required String apiKey,
//   })  : _baseUrl = baseUrl,
//         _httpClient = httpClient ?? http.Client(),
//         _apiKey = apiKey;

//   // https://developers.google.com/maps/documentation/places/web-service/search-find-place
//   // Future<Place> getPlaceFromText(
//   //   String inputText,
//   //   String locationBias,
//   // ) async {
//   //   final uri = Uri.parse('$_baseUrl/findplacefromtext/json').replace(
//   //     queryParameters: <String, String>{
//   //       'fields':
//   //           'place_id,geometry,name,formatted_address,rating,opening_hours,photos',
//   //       'locationbias': locationBias,
//   //       'inputtype': 'textquery',
//   //       'input': inputText,
//   //       'key': _apiKey,
//   //     },
//   //   );

//   //   final response = await _httpClient.get(uri);

//   //   if (response.statusCode != 200) {
//   //     throw Exception('Error finding place from text.');
//   //   }

//   //   final placeJson = jsonDecode(response.body);

//   //   if (placeJson['status'] != 'OK') {
//   //     throw Exception('Error: ${placeJson['status']}');
//   //   }

//   //   final place = Place.fromJson(placeJson['candidates'][0]);
//   //   return place;
//   // }

//   // // https://developers.google.com/maps/documentation/places/web-service/details
//   // Future<Place> getPlaceDetails(String placeId) async {
//   //   final uri = Uri.parse('$_baseUrl/details/json').replace(
//   //     queryParameters: <String, String>{
//   //       'place_id': placeId,
//   //       'key': _apiKey,
//   //     },
//   //   );

//   //   final response = await _httpClient.get(uri);

//   //   if (response.statusCode != 200) {
//   //     throw Exception('Error finding place from text.');
//   //   }

//   //   final placeJson = jsonDecode(response.body);

//   //   if (placeJson['status'] != 'OK') {
//   //     throw Exception('Error: ${placeJson['status']}');
//   //   }

//   //   final place = Place.fromJson(placeJson['result']);
//   //   return place;
//   // }

//   // https://developers.google.com/maps/documentation/places/web-service/search-text
//   // Future<List<Place>> textSearch(String query) async {
//   //   final uri = Uri.parse('$_baseUrl/textsearch/json').replace(
//   //     queryParameters: <String, String>{
//   //       'query': query,
//   //       'key': _apiKey,
//   //     },
//   //   );

//   //   final response = await _httpClient.get(uri);

//   //   if (response.statusCode != 200) {
//   //     throw Exception('Error finding place from text.');
//   //   }

//   //   final responseJson = jsonDecode(response.body);
//   //   var results = responseJson['results'] as List;

//   //   return results.map((place) => Place.fromJson(place)).toList();
//   // }

//   // https://developers.google.com/maps/documentation/places/web-service/autocomplete
//   // Future<List<PlaceAutocompletePrediction>> getPlaceAutocompletePredictions(
//   //   String input,
//   // ) async {
//   //   final uri = Uri.parse('$_baseUrl/autocomplete/json').replace(
//   //     queryParameters: <String, String>{
//   //       'input': input,
//   //       'key': _apiKey,
//   //     },
//   //   );

//   //   final response = await _httpClient.get(uri);

//   //   if (response.statusCode != 200) {
//   //     throw Exception('Error finding place from text.');
//   //   }

//   //   final responseJson = jsonDecode(response.body);
//   //   var predictions = responseJson['predictions'] as List;

//   //   return predictions
//   //       .map((prediction) => PlaceAutocompletePrediction.fromJson(prediction))
//   //       .toList();
//   // }

//   // https://developers.google.com/maps/documentation/places/web-service/query
//   // Future<List<QueryAutocompletePrediction>> getQueryAutocompletePredictions(
//   //   String input,
//   // ) async {
//   //   final uri = Uri.parse('$_baseUrl/queryautocomplete/json').replace(
//   //     queryParameters: <String, String>{
//   //       'input': input,
//   //       'key': _apiKey,
//   //     },
//   //   );

//   //   final response = await _httpClient.get(uri);

//   //   if (response.statusCode != 200) {
//   //     throw Exception('Error finding place from text.');
//   //   }

//   //   final responseJson = jsonDecode(response.body);
//   //   var predictions = responseJson['predictions'] as List;

//   //   return predictions
//   //       .map((prediction) => QueryAutocompletePrediction.fromJson(prediction))
//   //       .toList();
//   // }

//   // https://developers.google.com/maps/documentation/places/web-service/photos
//   // Future<PhotoImage> getPlacePhoto(
//   //   String photoReference,
//   //   int height,
//   //   int width,
//   // ) async {
//   //   final uri = Uri.parse('$_baseUrl/photo').replace(
//   //     queryParameters: <String, String>{
//   //       'photo_reference': photoReference,
//   //       'maxheight': '$height',
//   //       'maxwidth': '$width',
//   //       'key': _apiKey,
//   //     },
//   //   );

//   //   final response = await _httpClient.get(uri);
//   //   return PhotoImage(imageData: response.bodyBytes);
//   // }
// // }


// // ## Places API
// // ### Find Place
// // <!-- https://developers.google.com/maps/documentation/places/web-service/search-find-place -->
// // The Google Maps Platform Find Place API is a service that allows developers to search for specific places using the name, address, or a simple keyword, returning details about the place including its name, address, and location coordinates. This API works best for applications where the place that a user is searching for is likely to be in their current view of the map. In contrast to the Text Search API, the Find Place API takes a more targeted search string and returns a single result, making it highly suitable for immediate, context-aware place searches.

// // ### Text Search
// // <!-- https://developers.google.com/maps/documentation/places/web-service/search-text -->
// // The Google Maps Platform Text Search API is a web-based service that allows developers to search for places within the vast Google Maps database using natural language queries. These queries can represent business names, points of interest, or virtually any notable public space, returning details about the place including its name, address, coordinates, and more. This service greatly simplifies the task of finding specific locations and retrieving associated metadata, contributing to the development of more user-friendly, location-aware applications. It is particularly useful for apps involving travel, tourism, real estate, and local business search.

// // ### Place Photos
// // <!-- https://developers.google.com/maps/documentation/places/web-service/photos -->
// // The Google Maps Platform Place Photos API provides millions of place-related photos. These photos are a collection of user-contributed photos and Google-sourced photos. The API returns the photo references of the requested place. Each photo reference can be used to retrieve the actual photo from the API, allowing developers to include high-quality photographic content in their applications. It can be useful in a range of applications where visual context is necessary or helpful, including travel, real estate, and local business search applications, offering users a visual experience of the place.

// // ### Place Autocomplete
// // <!-- https://developers.google.com/maps/documentation/places/web-service/autocomplete -->
// // The Google Maps Platform Place Autocomplete API is a service that provides real-time suggestions as users type in a search box. It helps users quickly find and select from a pre-populated list of locations as they start typing, improving the user experience by reducing typing errors and speeding up the search process. The service can autocomplete using a specific location or globally, and can be biased towards a certain region. This API is particularly useful for applications requiring a quick place search option, such as ride-sharing apps, travel apps, or any application where the user needs to input a location.

// // ### Query Autocomplete
// // <!-- https://developers.google.com/maps/documentation/places/web-service/query -->
// // The Query Autocomplete service can be used to provide a query prediction for text-based geographic searches, by returning suggested queries as you type. The Query Autocomplete service allows you to add on-the-fly geographic query predictions to your application. Instead of searching for a specific location, a user can type in a categorical search, such as "pizza near New York" and the service responds with a list of suggested queries matching the string. As the Query Autocomplete service can match on both full words and substrings, applications can send queries as the user types to provide on-the-fly predictions.

