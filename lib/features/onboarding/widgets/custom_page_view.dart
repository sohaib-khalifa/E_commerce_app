import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomPageView extends StatelessWidget {
  final PageController controller;

  const CustomPageView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final List<String> images = [
      'assets/images/onboarding1.svg',
      'assets/images/onboarding2.svg',
      'assets/images/onboarding3.svg',
    ];

    return PageView.builder(
      controller: controller,
      itemCount: images.length,
      itemBuilder: (context, index) {
        return Center(
          child: SvgPicture.asset(
            images[index],
            height: 300,
          ),
        );
      },
    );
  }
}
