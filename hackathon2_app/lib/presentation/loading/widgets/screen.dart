import 'package:flutter/material.dart';

import '../../../widgets/m3e_loding.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ロード中')),
      body: Center(child: ExpressiveLoading(size: 48)),
    );
  }
}
