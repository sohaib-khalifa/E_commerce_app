import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../core/constants.dart';
import 'widgets/custom_button.dart';
import 'widgets/custom_text_field.dart';
import 'login_page.dart';

class RegisterPage extends StatelessWidget {
  static String routeName = 'RegisterPage';

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? email;
  String? password;

  RegisterPage({super.key});

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
                    'Scholar Chat',
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
                'REGISTER',
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
                text: 'REGISTER',
                onTap: () async {
                  if (formKey.currentState!.validate()) {
                    try {
                      await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                            email: email!,
                            password: password!,
                          );

                      showSnack(
                        context,
                        'Account created successfully ✅',
                        Colors.green,
                      );

                      // بعد التسجيل يرجعه للـ Login
                      Navigator.pushReplacementNamed(
                        context,
                        LoginPage.routeName,
                      );
                    } on FirebaseAuthException catch (e) {
                      handleRegisterError(context, e);
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
                    'Already have an account?',
                    style: TextStyle(color: Colors.white),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Text(
                      '  Login',
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

  void handleRegisterError(BuildContext context, FirebaseAuthException e) {
    String msg;
    switch (e.code) {
      case 'weak-password':
        msg = 'Password is too weak, must be at least 6 characters';
        break;
      case 'email-already-in-use':
        msg = 'This email is already registered';
        break;
      case 'invalid-email':
        msg = 'Invalid email format';
        break;
      default:
        msg = 'Registration failed: ${e.message}';
    }
    showSnack(context, msg, Colors.red);
  }

  void showSnack(BuildContext context, String msg, Color color) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(backgroundColor: color, content: Text(msg)));
  }
}

// class RegisterPage extends StatelessWidget {
//   static String routeName = 'RegisterPage';

//   final GlobalKey<FormState> formKey = GlobalKey<FormState>();
//   String? email;
//   String? password;

//   RegisterPage({super.key});

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
//                 'REGISTER',
//                 style: TextStyle(fontSize: 24, color: Colors.white),
//               ),
//               const SizedBox(height: 20),
//               CustomFormTextField(
//                 hintText: 'Email',
//                 onChanged: (data) => email = data,
//               ),
//               const SizedBox(height: 10),
//               CustomFormTextField(
//                 hintText: 'Password',
//                 obscureText: true,
//                 onChanged: (data) => password = data,
//               ),
//               const SizedBox(height: 20),
//               CustomButton(
//                 text: 'REGISTER',
//                 onTap: () async {
//                   if (formKey.currentState!.validate()) {
//                     try {
//                       await FirebaseAuth.instance
//                           .createUserWithEmailAndPassword(
//                               email: email!, password: password!);

//                       ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(
//                           backgroundColor: Colors.green,
//                           content: Text('Account created successfully'),
//                         ),
//                       );

//                       Navigator.pushReplacementNamed(context, LoginPage.routeName);
//                     } on FirebaseAuthException catch (e) {
//                       if (e.code == 'weak-password') {
//                         showError(context, 'Weak password');
//                       } else if (e.code == 'email-already-in-use') {
//                         showError(context, 'Email already exists');
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
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Text(
//                     'Already have an account?',
//                     style: TextStyle(color: Colors.white),
//                   ),
//                   GestureDetector(
//                     onTap: () => Navigator.pop(context),
//                     child: const Text(
//                       '  Login',
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
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(backgroundColor: Colors.red, content: Text(msg)),
//     );
//   }
// }
