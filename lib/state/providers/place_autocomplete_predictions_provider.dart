import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../models/place_autocomplete_prediction.dart';
import '../../repositories/maps_repository.dart';

part 'place_autocomplete_predictions_provider.g.dart';

@riverpod
Future<List<PlaceAutocompletePrediction>> placeAutocompletePredictions(
  PlaceAutocompletePredictionsRef ref,
  String input,
) async {
  final mapsRepository = ref.watch(mapsRepositoryProvider);
  return mapsRepository.getPlaceAutocompletePredictions(input);
}
