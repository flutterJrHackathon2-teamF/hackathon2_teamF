import 'dart:io' show Platform;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LinearWavyProgressIndicator extends StatelessWidget {
  final Color? color;
  final double? progress;
  final double height;

  const LinearWavyProgressIndicator({
    super.key,
    this.color,
    this.progress,
    this.height = 4.0,
  });

  @override
  Widget build(BuildContext context) {
    if (!kIsWeb && Platform.isAndroid) {
      return SizedBox(
        height: height,
        child: AndroidView(
          viewType: 'linear_wavy_progress',
          layoutDirection: TextDirection.ltr,
          creationParams: <String, dynamic>{
            'color': (color ?? Theme.of(context).colorScheme.primary).value,
            'progress': progress,
            'height': height,
          },
          creationParamsCodec: const StandardMessageCodec(),
        ),
      );
    }
    // iOS/Web fallback
    return CircularProgressIndicator(value: progress, color: color);
  }
}
