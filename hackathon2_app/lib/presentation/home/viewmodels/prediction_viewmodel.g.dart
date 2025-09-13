// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prediction_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$predictionServiceHash() => r'58254c0ca226c7ed3cfe1e2e3a666d3eb9a6a3b8';

/// See also [predictionService].
@ProviderFor(predictionService)
final predictionServiceProvider = Provider<PredictionService>.internal(
  predictionService,
  name: r'predictionServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$predictionServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef PredictionServiceRef = ProviderRef<PredictionService>;
String _$predictionViewModelHash() =>
    r'9ec1e7c24102db71b2b88be66dfc184b05cea6ab';

/// See also [PredictionViewModel].
@ProviderFor(PredictionViewModel)
final predictionViewModelProvider = AutoDisposeAsyncNotifierProvider<
    PredictionViewModel, List<VisitorPrediction>?>.internal(
  PredictionViewModel.new,
  name: r'predictionViewModelProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$predictionViewModelHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$PredictionViewModel
    = AutoDisposeAsyncNotifier<List<VisitorPrediction>?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
