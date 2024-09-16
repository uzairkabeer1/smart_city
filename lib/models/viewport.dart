import 'location.dart';

class ViewPort {
  final Location northeast;
  final Location southwest;

  const ViewPort({
    required this.northeast,
    required this.southwest,
  });

  factory ViewPort.fromJson(Map<String, dynamic> json) {
    return ViewPort(
      northeast: Location.fromJson(json['northeast']),
      southwest: Location.fromJson(json['southwest']),
    );
  }
}
