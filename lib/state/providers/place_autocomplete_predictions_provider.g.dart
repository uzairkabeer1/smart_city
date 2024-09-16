// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_autocomplete_predictions_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$placeAutocompletePredictionsHash() =>
    r'b8a511f80859029031a9ad20992a22ba2223ddab';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

typedef PlaceAutocompletePredictionsRef
    = AutoDisposeFutureProviderRef<List<PlaceAutocompletePrediction>>;

/// See also [placeAutocompletePredictions].
@ProviderFor(placeAutocompletePredictions)
const placeAutocompletePredictionsProvider =
    PlaceAutocompletePredictionsFamily();

/// See also [placeAutocompletePredictions].
class PlaceAutocompletePredictionsFamily
    extends Family<AsyncValue<List<PlaceAutocompletePrediction>>> {
  /// See also [placeAutocompletePredictions].
  const PlaceAutocompletePredictionsFamily();

  /// See also [placeAutocompletePredictions].
  PlaceAutocompletePredictionsProvider call(
    String input,
  ) {
    return PlaceAutocompletePredictionsProvider(
      input,
    );
  }

  @override
  PlaceAutocompletePredictionsProvider getProviderOverride(
    covariant PlaceAutocompletePredictionsProvider provider,
  ) {
    return call(
      provider.input,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'placeAutocompletePredictionsProvider';
}

/// See also [placeAutocompletePredictions].
class PlaceAutocompletePredictionsProvider
    extends AutoDisposeFutureProvider<List<PlaceAutocompletePrediction>> {
  /// See also [placeAutocompletePredictions].
  PlaceAutocompletePredictionsProvider(
    this.input,
  ) : super.internal(
          (ref) => placeAutocompletePredictions(
            ref,
            input,
          ),
          from: placeAutocompletePredictionsProvider,
          name: r'placeAutocompletePredictionsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$placeAutocompletePredictionsHash,
          dependencies: PlaceAutocompletePredictionsFamily._dependencies,
          allTransitiveDependencies:
              PlaceAutocompletePredictionsFamily._allTransitiveDependencies,
        );

  final String input;

  @override
  bool operator ==(Object other) {
    return other is PlaceAutocompletePredictionsProvider &&
        other.input == input;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, input.hashCode);

    return _SystemHash.finish(hash);
  }
}
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
