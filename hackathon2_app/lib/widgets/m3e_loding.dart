import 'dart:io';

import 'package:flutter/material.dart';

class ExpressiveLoading extends StatelessWidget {
  const ExpressiveLoading({super.key});
  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      return SizedBox(
        height: 100,
        width: 100,
        child: AndroidView(
          viewType: 'custom_native_view',
          layoutDirection: TextDirection.ltr,
        ),
      );
    } else {
      return const SizedBox(
        height: 100,
        width: 100,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
  }
}
