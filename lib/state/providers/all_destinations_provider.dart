import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../models/destination.dart';
import '../../repositories/destination_repository.dart';

part 'all_destinations_provider.g.dart';

@riverpod
Future<List<Destination>> allDestinations(AllDestinationsRef ref) async {
  final destinationRepository = ref.watch(destinationRepositoryProvider);
  return destinationRepository.getDestinations();
}
