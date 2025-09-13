// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'visitor_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$visitorRepositoryHash() => r'bf8fc18d4dc00ba99fb00b9d3d4d5fce6c14930e';

/// See also [visitorRepository].
@ProviderFor(visitorRepository)
final visitorRepositoryProvider = Provider<VisitorRepository>.internal(
  visitorRepository,
  name: r'visitorRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$visitorRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef VisitorRepositoryRef = ProviderRef<VisitorRepository>;
String _$visitorRepositoryCacheHash() =>
    r'1a6184b94755611989370272bec754eae628bf6a';

/// See also [VisitorRepositoryCache].
@ProviderFor(VisitorRepositoryCache)
final visitorRepositoryCacheProvider =
    NotifierProvider<VisitorRepositoryCache, VisitorData?>.internal(
  VisitorRepositoryCache.new,
  name: r'visitorRepositoryCacheProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$visitorRepositoryCacheHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$VisitorRepositoryCache = Notifier<VisitorData?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
