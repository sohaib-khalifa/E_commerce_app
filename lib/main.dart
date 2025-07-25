import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:login_app_test/features/home/view/home_page.dart';
import 'package:login_app_test/features/onboarding/view/onboarding_view.dart';
import 'package:login_app_test/features/splash/view/splash_view.dart';
import 'core/firebase_options.dart';
import 'features/auth/view/login_page.dart';
import 'features/auth/view/register_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const LoginApp());
}

class LoginApp extends StatelessWidget {
  const LoginApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        SplashView.routeName: (context) => const SplashView(),
        OnBoardingView.routeName: (context) => const OnBoardingView(),
        LoginPage.routeName: (context) => LoginPage(),
        RegisterPage.routeName: (context) => RegisterPage(),
        HomePage.routeName: (context) => const HomePage(), // ✅ أضفناها هنا
      },
      initialRoute: SplashView.routeName,
    );
  }
}
