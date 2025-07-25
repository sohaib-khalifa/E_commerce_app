import 'package:flutter/material.dart';
import 'package:login_app_test/features/onboarding/view/onboarding_view.dart';

class SplashView extends StatefulWidget {
  static const String routeName = "/splash";

  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // ✅ إعداد الانيميشن (Fade In / Fade Out)
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _fadeAnimation =
        Tween<double>(begin: 0.3, end: 1).animate(_animationController);

    // ✅ تكرار الأنيميشن ذهاب وعودة
    _animationController.repeat(reverse: true);

    // ✅ بعد 3 ثواني هينتقل إلى OnBoardingView
    Future.delayed(const Duration(seconds: 3), () {
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(
      //     builder: (_) => const OnBoardingView(),
      //   ),
      // );
      Navigator.pushReplacementNamed(context, OnBoardingView.routeName);
    });
  }

  @override
  void dispose() {
    _animationController.dispose(); // ✅ تنظيف الـ Animation
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF69A03A),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ✅ نص بيتحرك بفيد
            FadeTransition(
              opacity: _fadeAnimation,
              child: const Text(
                'Shop Sphere',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 30),

            // ✅ صورة السبلاتش
            Image.asset(
              'assets/images/splash_view_image.png',
              width: 250,
            ),
          ],
        ),
      ),
    );
  }
}
