import 'dart:io' show Platform;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ExpressiveLoading extends StatelessWidget {
  final Color? color;
  final double size;
  final double? progress;

  const ExpressiveLoading({
    super.key,
    this.color,
    this.size = 48.0,
    this.progress,
  });

  @override
  Widget build(BuildContext context) {
    if (!kIsWeb && Platform.isAndroid) {
      return AndroidView(
        viewType: 'expressive_loading',
        layoutDirection: TextDirection.ltr,
        creationParams: <String, dynamic>{
          'color': (color ?? Theme.of(context).colorScheme.primary).value,
          'size': size,
          'progress': progress,
        },
        creationParamsCodec: const StandardMessageCodec(),
      );
    }
    // iOS/Web fallback
    return CircularProgressIndicator(
      value: progress,
      color: color,
    );
  }
}
