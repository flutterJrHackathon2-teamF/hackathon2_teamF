// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prediction_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$predictionRepositoryHash() =>
    r'226717a36be01e42a271d14a876e8cb2009c3855';

/// See also [predictionRepository].
@ProviderFor(predictionRepository)
final predictionRepositoryProvider = Provider<PredictionRepository>.internal(
  predictionRepository,
  name: r'predictionRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$predictionRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef PredictionRepositoryRef = ProviderRef<PredictionRepository>;
String _$predictionRepositoryCacheHash() =>
    r'bc15e2813ded27ce8702a58c069278aa4337e070';

/// See also [PredictionRepositoryCache].
@ProviderFor(PredictionRepositoryCache)
final predictionRepositoryCacheProvider = NotifierProvider<
    PredictionRepositoryCache, List<VisitorPrediction>?>.internal(
  PredictionRepositoryCache.new,
  name: r'predictionRepositoryCacheProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$predictionRepositoryCacheHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$PredictionRepositoryCache = Notifier<List<VisitorPrediction>?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
