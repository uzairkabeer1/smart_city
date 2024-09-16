import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:smart_city/models/photo_image.dart';

import '../../models/place.dart';
import '../../repositories/maps_repository.dart';

part 'place_details_provider.g.dart';

@riverpod
Future<(Place, PhotoImage)> placeDetails(
  PlaceDetailsRef ref,
  String address,
  LatLng latLng,
) async {
  final mapsRepository = ref.watch(mapsRepositoryProvider);
  return mapsRepository.getDetailedPlaceFromAddress(address, latLng);
}
