import 'geometry.dart';
import 'opening_hours.dart';
import 'photo.dart';
import 'review.dart';

class Place {
  final String placeId;
  final String name;
  final String formattedAddress;
  final Geometry geometry;
  final List<Photo> photos;
  final List<Review>? reviews;
  final OpeningHours? openingHours;

  const Place({
    required this.placeId,
    required this.name,
    required this.formattedAddress,
    required this.geometry,
    required this.photos,
    this.reviews,
    this.openingHours,
  });

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      placeId: json['place_id'],
      name: json['name'],
      formattedAddress: json['formatted_address'],
      geometry: Geometry.fromJson(json['geometry']),
      photos: (json['photos'] as List).map((i) => Photo.fromJson(i)).toList(),
      reviews:
          (json['reviews'] as List?)?.map((i) => Review.fromJson(i)).toList(),
      openingHours: json['opening_hours'] != null
          ? OpeningHours.fromJson(json['opening_hours'])
          : null,
    );
  }

  @override
  String toString() {
    return 'Place{placeId: $placeId, name: $name, formattedAddress: $formattedAddress, geometry: $geometry, photos: $photos, reviews: $reviews, openingHours: $openingHours}';
  }
}
