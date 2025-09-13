// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'visitor_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$visitorServiceHash() => r'c9c8b6e0081db7c8e9b774edf9241557eeaef624';

/// See also [visitorService].
@ProviderFor(visitorService)
final visitorServiceProvider = Provider<VisitorService>.internal(
  visitorService,
  name: r'visitorServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$visitorServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef VisitorServiceRef = ProviderRef<VisitorService>;
String _$latestVisitorCountHash() =>
    r'bbf6621d35f0965754ea1b21ddc718dd94b39954';

/// See also [latestVisitorCount].
@ProviderFor(latestVisitorCount)
final latestVisitorCountProvider = AutoDisposeFutureProvider<int>.internal(
  latestVisitorCount,
  name: r'latestVisitorCountProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$latestVisitorCountHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef LatestVisitorCountRef = AutoDisposeFutureProviderRef<int>;
String _$visitorViewModelHash() => r'df8f2e9c9021f780e2e5de66c3d9e56d78827e72';

/// See also [VisitorViewModel].
@ProviderFor(VisitorViewModel)
final visitorViewModelProvider =
    AutoDisposeAsyncNotifierProvider<VisitorViewModel, VisitorData?>.internal(
  VisitorViewModel.new,
  name: r'visitorViewModelProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$visitorViewModelHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$VisitorViewModel = AutoDisposeAsyncNotifier<VisitorData?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
