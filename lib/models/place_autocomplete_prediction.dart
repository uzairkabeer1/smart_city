class PlaceAutocompletePrediction {
  final String placeId;
  final String description;

  const PlaceAutocompletePrediction({
    required this.placeId,
    required this.description,
  });

  factory PlaceAutocompletePrediction.fromJson(
    Map<String, dynamic> json,
  ) {
    return PlaceAutocompletePrediction(
      placeId: json['place_id'],
      description: json['description'],
    );
  }
}
