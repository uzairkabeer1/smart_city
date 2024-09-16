class QueryAutocompletePrediction {
  final String description;

  const QueryAutocompletePrediction({
    required this.description,
  });

  factory QueryAutocompletePrediction.fromJson(
    Map<String, dynamic> json,
  ) {
    return QueryAutocompletePrediction(
      description: json['description'],
    );
  }
}
