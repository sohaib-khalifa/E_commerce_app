import 'package:flutter/material.dart';
import 'package:login_app_test/core/utils/size_config.dart';
import 'package:login_app_test/core/widgets/custom_general_button.dart';
import 'package:login_app_test/features/onboarding/widgets/custom_page_view.dart';
import 'package:login_app_test/features/onboarding/widgets/dots_indicator.dart';
import 'package:login_app_test/features/auth/view/login_page.dart';

class OnBoardingBody extends StatefulWidget {
  const OnBoardingBody({super.key});

  @override
  State<OnBoardingBody> createState() => _OnBoardingBodyState();
}

class _OnBoardingBodyState extends State<OnBoardingBody> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Column(
      children: [
        const SizedBox(height: 60),

        // زرار Skip
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.only(right: 20),
            child: GestureDetector(
              onTap: () {
                Navigator.pushReplacementNamed(context, LoginPage.routeName);
              },
              child: const Text(
                'Skip',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xff898989),
                ),
              ),
            ),
          ),
        ),

        const SizedBox(height: 30),

        // PageView للصور
        Expanded(
          child: CustomPageView(controller: _pageController),
        ),

        const SizedBox(height: 20),

        // Dots Indicator
        DotsIndicator(currentIndex: _currentPage),

        const SizedBox(height: 30),

        // زر Next
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: CustomGeneralButton(
            text: _currentPage == 2 ? "Get Started" : "Next",
            onTap: () {
              if (_currentPage < 2) {
                _pageController.nextPage(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeInOut,
                );
              } else {
                Navigator.pushReplacementNamed(context, LoginPage.routeName);
              }
            },
          ),
        ),

        const SizedBox(height: 40),
      ],
    );
  }

  @override
  void initState() {
    super.initState();

    // نتابع التغيير في الصفحة
    _pageController.addListener(() {
      int newPage = _pageController.page!.round();
      if (newPage != _currentPage) {
        setState(() {
          _currentPage = newPage;
        });
      }
    });
  }
}
