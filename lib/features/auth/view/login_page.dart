import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:login_app_test/features/home/view/home_screen.dart';
// import 'package:login_app_test/features/home/view/home_page.dart';
import '../../../core/constants.dart';
import 'widgets/custom_button.dart';
import 'widgets/custom_text_field.dart';
import 'register_page.dart';

class LoginPage extends StatelessWidget {
  static String routeName = 'LoginPage';

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? email;
  String? password;

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              const SizedBox(height: 75),
              SvgPicture.asset('assets/images/login.svg', height: 200),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'ُEcommerce App',
                    style: TextStyle(
                      fontSize: 32,
                      color: Colors.white,
                      fontFamily: 'pacifico',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 75),
              const Text(
                'LOGIN',
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
              const SizedBox(height: 20),

              CustomFormTextField(
                hintText: 'Email',
                onChanged: (data) => email = data,
              ),
              const SizedBox(height: 10),

              CustomFormTextField(
                hintText: 'Password',
                obscureText: true,
                onChanged: (data) => password = data,
              ),
              const SizedBox(height: 20),

              CustomButton(
                text: 'LOGIN',
                onTap: () async {
                  if (formKey.currentState!.validate()) {
                    try {
                      await FirebaseAuth.instance.signInWithEmailAndPassword(
                        email: email!,
                        password: password!,
                      );

                      showSnack(context, 'Login successful ✅', Colors.green);

                      // الانتقال للصفحة الرئيسية مع مسح صفحات الـ stack القديمة
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        ),
                        (route) => false,
                      );
                    } on FirebaseAuthException catch (e) {
                      handleFirebaseError(context, e);
                    } catch (_) {
                      showSnack(
                        context,
                        'Unexpected error occurred ❌',
                        Colors.red,
                      );
                    }
                  }
                },
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Don\'t have an account?',
                    style: TextStyle(color: Colors.white),
                  ),
                  GestureDetector(
                    onTap:
                        () => Navigator.pushNamed(
                          context,
                          RegisterPage.routeName,
                        ),
                    child: const Text(
                      '  Register',
                      style: TextStyle(color: Color(0xffC7EDE6)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void handleFirebaseError(BuildContext context, FirebaseAuthException e) {
    String msg;
    switch (e.code) {
      case 'user-not-found':
        msg = 'No user found with this email';
        break;
      case 'wrong-password':
        msg = 'Incorrect password';
        break;
      case 'invalid-email':
        msg = 'Invalid email address';
        break;
      case 'too-many-requests':
        msg = 'Too many failed attempts, try again later';
        break;
      default:
        msg = 'Login failed: ${e.message}';
    }
    showSnack(context, msg, Colors.red);
  }

  void showSnack(BuildContext context, String msg, Color color) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(backgroundColor: color, content: Text(msg)));
  }
}

// class LoginPage extends StatelessWidget {
//   static String routeName = 'LoginPage';

//   final GlobalKey<FormState> formKey = GlobalKey<FormState>();
//   String? email;
//   String? password;

//   LoginPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: kPrimaryColor,
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 8),
//         child: Form(
//           key: formKey,
//           child: ListView(
//             children: [
//               const SizedBox(height: 75),
//               Image.asset('assets/images/scholar.png', height: 100),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: const [
//                   Text(
//                     'Scholar Chat',
//                     style: TextStyle(
//                       fontSize: 32,
//                       color: Colors.white,
//                       fontFamily: 'pacifico',
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 75),
//               const Text(
//                 'LOGIN',
//                 style: TextStyle(fontSize: 24, color: Colors.white),
//               ),
//               const SizedBox(height: 20),

//               // حقل الإيميل
//               CustomFormTextField(
//                 hintText: 'Email',
//                 onChanged: (data) => email = data,
//               ),
//               const SizedBox(height: 10),

//               // حقل الباسورد
//               CustomFormTextField(
//                 hintText: 'Password',
//                 obscureText: true,
//                 onChanged: (data) => password = data,
//               ),
//               const SizedBox(height: 20),

//               // زر تسجيل الدخول
//               CustomButton(
//                 text: 'LOGIN',
//                 onTap: () async {
//                   if (formKey.currentState!.validate()) {
//                     try {
//                       // تسجيل الدخول في Firebase
//                       await FirebaseAuth.instance.signInWithEmailAndPassword(
//                         email: email!,
//                         password: password!,
//                       );

//                       // نجاح الدخول
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(
//                           backgroundColor: Colors.green,
//                           content: Text('Login successful'),
//                         ),
//                       );

//                       // الانتقال للصفحة الرئيسية بعد النجاح
//                       Navigator.pushReplacementNamed(
//                         context,
//                         HomePage.routeName,
//                       );
//                     } on FirebaseAuthException catch (e) {
//                       if (e.code == 'user-not-found') {
//                         showError(context, 'User not found');
//                       } else if (e.code == 'wrong-password') {
//                         showError(context, 'Wrong password');
//                       } else {
//                         showError(context, 'Something went wrong');
//                       }
//                     } catch (e) {
//                       showError(context, 'Unexpected error');
//                     }
//                   }
//                 },
//               ),

//               const SizedBox(height: 10),

//               // الانتقال للتسجيل
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Text(
//                     'Don\'t have an account?',
//                     style: TextStyle(color: Colors.white),
//                   ),
//                   GestureDetector(
//                     onTap:
//                         () => Navigator.pushNamed(
//                           context,
//                           RegisterPage.routeName,
//                         ),
//                     child: const Text(
//                       '  Register',
//                       style: TextStyle(color: Color(0xffC7EDE6)),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void showError(BuildContext context, String msg) {
//     ScaffoldMessenger.of(
//       context,
//     ).showSnackBar(SnackBar(backgroundColor: Colors.red, content: Text(msg)));
//   }
// }
