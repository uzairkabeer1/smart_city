import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../models/destination.dart';
import '../../repositories/destination_repository.dart';

part 'selected_destination_provider.g.dart';

@riverpod
Future<Destination?> selectedDestination(
  SelectedDestinationRef ref,
  String name,
) async {
  final destinationRepository = ref.watch(destinationRepositoryProvider);
  return destinationRepository.getDestinationByName(name);
}
