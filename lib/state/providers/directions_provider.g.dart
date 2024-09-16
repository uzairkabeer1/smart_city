// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'directions_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$directionsHash() => r'f823fd3db8faa4f80dd31085158fd4ca78549a6b';

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

typedef DirectionsRef = AutoDisposeFutureProviderRef<Direction>;

/// See also [directions].
@ProviderFor(directions)
const directionsProvider = DirectionsFamily();

/// See also [directions].
class DirectionsFamily extends Family<AsyncValue<Direction>> {
  /// See also [directions].
  const DirectionsFamily();

  /// See also [directions].
  DirectionsProvider call(
    String origin,
    String destination,
  ) {
    return DirectionsProvider(
      origin,
      destination,
    );
  }

  @override
  DirectionsProvider getProviderOverride(
    covariant DirectionsProvider provider,
  ) {
    return call(
      provider.origin,
      provider.destination,
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
  String? get name => r'directionsProvider';
}

/// See also [directions].
class DirectionsProvider extends AutoDisposeFutureProvider<Direction> {
  /// See also [directions].
  DirectionsProvider(
    this.origin,
    this.destination,
  ) : super.internal(
          (ref) => directions(
            ref,
            origin,
            destination,
          ),
          from: directionsProvider,
          name: r'directionsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$directionsHash,
          dependencies: DirectionsFamily._dependencies,
          allTransitiveDependencies:
              DirectionsFamily._allTransitiveDependencies,
        );

  final String origin;
  final String destination;

  @override
  bool operator ==(Object other) {
    return other is DirectionsProvider &&
        other.origin == origin &&
        other.destination == destination;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, origin.hashCode);
    hash = _SystemHash.combine(hash, destination.hashCode);

    return _SystemHash.finish(hash);
  }
}
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
