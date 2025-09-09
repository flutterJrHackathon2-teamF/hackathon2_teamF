import 'package:flutter/material.dart';
import 'package:hackathon2_app/ui/home/widgets/components/stamp_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Column(children: [StampCard()]));
  }
}
