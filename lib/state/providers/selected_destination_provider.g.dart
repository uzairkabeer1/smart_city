// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'selected_destination_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$selectedDestinationHash() =>
    r'fe221af24696442570c5f91adca9ea83d766b1fc';

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

typedef SelectedDestinationRef = AutoDisposeFutureProviderRef<Destination?>;

/// See also [selectedDestination].
@ProviderFor(selectedDestination)
const selectedDestinationProvider = SelectedDestinationFamily();

/// See also [selectedDestination].
class SelectedDestinationFamily extends Family<AsyncValue<Destination?>> {
  /// See also [selectedDestination].
  const SelectedDestinationFamily();

  /// See also [selectedDestination].
  SelectedDestinationProvider call(
    String name,
  ) {
    return SelectedDestinationProvider(
      name,
    );
  }

  @override
  SelectedDestinationProvider getProviderOverride(
    covariant SelectedDestinationProvider provider,
  ) {
    return call(
      provider.name,
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
  String? get name => r'selectedDestinationProvider';
}

/// See also [selectedDestination].
class SelectedDestinationProvider
    extends AutoDisposeFutureProvider<Destination?> {
  /// See also [selectedDestination].
  SelectedDestinationProvider(
    this.name,
  ) : super.internal(
          (ref) => selectedDestination(
            ref,
            name,
          ),
          from: selectedDestinationProvider,
          name: r'selectedDestinationProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$selectedDestinationHash,
          dependencies: SelectedDestinationFamily._dependencies,
          allTransitiveDependencies:
              SelectedDestinationFamily._allTransitiveDependencies,
        );

  final String name;

  @override
  bool operator ==(Object other) {
    return other is SelectedDestinationProvider && other.name == name;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, name.hashCode);

    return _SystemHash.finish(hash);
  }
}
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
