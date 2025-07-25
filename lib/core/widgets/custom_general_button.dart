import 'package:flutter/material.dart';

class CustomGeneralButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;

  const CustomGeneralButton({super.key, required this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF69A03A),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),  
          ),
        ),
        onPressed: onTap ?? () {}, // لو معملناش onTap مش هيعمل حاجة
        child: Text(
          text,
          style: const TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }
}
