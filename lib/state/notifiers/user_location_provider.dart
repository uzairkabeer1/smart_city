import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_location_provider.g.dart';

@riverpod
class UserLocation extends _$UserLocation {
  @override
  String build() {
    return '';
  }

  setUserLocation(String location) {
    state = location;
  }
}
