import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isEnabled;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isEnabled ? onPressed : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        decoration: BoxDecoration(
          gradient: isEnabled
              ? const LinearGradient(
            colors: [Colors.indigoAccent, Colors.deepPurple],
          )
              : const LinearGradient(
            colors: [Colors.grey, Colors.black26],
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: isEnabled
              ? [
            BoxShadow(
              color: Colors.deepPurple.withOpacity(0.6),
              blurRadius: 12,
              spreadRadius: 2,
              offset: const Offset(0, 6),
            ),
          ]
              : [],
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isEnabled ? Colors.white : Colors.grey[400],
              shadows: isEnabled
                  ? [
                const Shadow(
                  blurRadius: 8.0,
                  color: Colors.white,
                  offset: Offset(0, 0),
                ),
              ]
                  : [],
            ),
          ),
        ),
      ),
    );
  }
}
