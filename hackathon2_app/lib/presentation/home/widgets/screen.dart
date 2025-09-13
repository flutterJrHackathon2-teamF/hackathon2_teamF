import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hackathon2_app/presentation/home/widgets/components/header.dart';
import 'package:hackathon2_app/presentation/home/widgets/components/hourly_chart.dart';
import 'package:hackathon2_app/presentation/home/widgets/components/twitter_post.dart';
import 'package:hackathon2_app/utils/color.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColor.lightBlue,
        child: ListView(
          children: [
            const HomeScreenHeader(),
            // const Gap(12),
            // const StampCard(),
            // const Gapx(24),
            // const HomeScreenButtons(),
            const Gap(12),
            HourlyBarChart(),
            const Gap(24),
            const SocialMediaEmbed(
              url: 'https://x.com/heiwayu_ikeda',
              title: 'X (Twitter) Timeline',
            ),
            const Gap(24),
            const SocialMediaEmbed(
              url: 'https://www.instagram.com/heiwaonsen/',
              title: 'Instagram',
            ),
          ],
        ),
      ),
    );
  }
}
