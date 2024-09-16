import '../models/destination.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'destination_repository.g.dart';

@riverpod
DestinationRepository destinationRepository(DestinationRepositoryRef ref) =>
    DestinationRepository();

class DestinationRepository {
  Future<List<Destination>> getDestinations() async {
    return Future.delayed(
      const Duration(milliseconds: 300),
      () => Destination.sampleDestinations,
    );
  }

  Future<Destination?> getDestinationByName(String name) async {
    return Future.delayed(
      const Duration(milliseconds: 300),
      () => Destination.sampleDestinations
          .firstWhere((destination) => destination.name == name),
    );
  }
}
