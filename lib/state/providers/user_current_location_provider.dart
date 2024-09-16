import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../repositories/maps_repository.dart';

part 'user_current_location_provider.g.dart';

@riverpod
Future<String?> userCurrentLocation(UserCurrentLocationRef ref) async {
  final mapsRepository = ref.watch(mapsRepositoryProvider);
  return mapsRepository.getCurrentUserAddress();
}
