// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stamp_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$stampRepositoryHash() => r'bb26ad1871599a0313fd84a15e99a1df7f52abc2';

/// See also [stampRepository].
@ProviderFor(stampRepository)
final stampRepositoryProvider = Provider<StampRepository>.internal(
  stampRepository,
  name: r'stampRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$stampRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef StampRepositoryRef = ProviderRef<StampRepository>;
String _$locationRepositoryHash() =>
    r'53082970080a1255b631cc6a6bf8470bddec9358';

/// See also [locationRepository].
@ProviderFor(locationRepository)
final locationRepositoryProvider = Provider<LocationRepository>.internal(
  locationRepository,
  name: r'locationRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$locationRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef LocationRepositoryRef = ProviderRef<LocationRepository>;
String _$stampServiceHash() => r'5297c75f35c8096dd0a7b8b656e8d3f7b334e412';

/// See also [stampService].
@ProviderFor(stampService)
final stampServiceProvider = Provider<StampService>.internal(
  stampService,
  name: r'stampServiceProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$stampServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef StampServiceRef = ProviderRef<StampService>;
String _$locationAllowsStampingHash() =>
    r'ef44a616b4b74d7689d41647f6faf73a072671d7';

/// See also [locationAllowsStamping].
@ProviderFor(locationAllowsStamping)
final locationAllowsStampingProvider = AutoDisposeFutureProvider<bool>.internal(
  locationAllowsStamping,
  name: r'locationAllowsStampingProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$locationAllowsStampingHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef LocationAllowsStampingRef = AutoDisposeFutureProviderRef<bool>;
String _$stampViewModelHash() => r'd899bd47167b470a24603bd68190e33af8cee542';

/// See also [StampViewModel].
@ProviderFor(StampViewModel)
final stampViewModelProvider =
    AutoDisposeAsyncNotifierProvider<StampViewModel, StampData>.internal(
  StampViewModel.new,
  name: r'stampViewModelProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$stampViewModelHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$StampViewModel = AutoDisposeAsyncNotifier<StampData>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
