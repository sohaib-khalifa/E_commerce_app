import 'package:flutter/material.dart';

class CustomFormTextField extends StatelessWidget {
  final String? hintText;
  final bool obscureText;
  final Function(String)? onChanged;

  const CustomFormTextField({
    super.key,
    this.hintText,
    this.onChanged,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      validator: (data) {
        if (data == null || data.isEmpty) {
          return '$hintText is required'; 
        }


        if (hintText == 'Email' &&
            !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(data)) {
          return 'Please enter a valid email';
        }

        if (hintText == 'Password' && data.length < 6) {
          return 'Password must be at least 6 characters';
        }

        return null;
      },
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.white),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
    );
  }
}
