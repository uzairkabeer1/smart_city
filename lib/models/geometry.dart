import 'location.dart';
import 'viewport.dart';

class Geometry {
  final Location location;
  final ViewPort viewport;

  const Geometry({
    required this.location,
    required this.viewport,
  });

  factory Geometry.fromJson(Map<String, dynamic> json) {
    return Geometry(
      location: Location.fromJson(json['location']),
      viewport: ViewPort.fromJson(json['viewport']),
    );
  }
}
