// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_details_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$placeDetailsHash() => r'377be0cda0b77f5db09d43eca00ef7c43abc1670';

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

typedef PlaceDetailsRef = AutoDisposeFutureProviderRef<(Place, PhotoImage)>;

/// See also [placeDetails].
@ProviderFor(placeDetails)
const placeDetailsProvider = PlaceDetailsFamily();

/// See also [placeDetails].
class PlaceDetailsFamily extends Family<AsyncValue<(Place, PhotoImage)>> {
  /// See also [placeDetails].
  const PlaceDetailsFamily();

  /// See also [placeDetails].
  PlaceDetailsProvider call(
    String address,
    LatLng latLng,
  ) {
    return PlaceDetailsProvider(
      address,
      latLng,
    );
  }

  @override
  PlaceDetailsProvider getProviderOverride(
    covariant PlaceDetailsProvider provider,
  ) {
    return call(
      provider.address,
      provider.latLng,
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
  String? get name => r'placeDetailsProvider';
}

/// See also [placeDetails].
class PlaceDetailsProvider
    extends AutoDisposeFutureProvider<(Place, PhotoImage)> {
  /// See also [placeDetails].
  PlaceDetailsProvider(
    this.address,
    this.latLng,
  ) : super.internal(
          (ref) => placeDetails(
            ref,
            address,
            latLng,
          ),
          from: placeDetailsProvider,
          name: r'placeDetailsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$placeDetailsHash,
          dependencies: PlaceDetailsFamily._dependencies,
          allTransitiveDependencies:
              PlaceDetailsFamily._allTransitiveDependencies,
        );

  final String address;
  final LatLng latLng;

  @override
  bool operator ==(Object other) {
    return other is PlaceDetailsProvider &&
        other.address == address &&
        other.latLng == latLng;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, address.hashCode);
    hash = _SystemHash.combine(hash, latLng.hashCode);

    return _SystemHash.finish(hash);
  }
}
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
