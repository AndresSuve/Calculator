import 'package:flutter/material.dart';

class CalculatorButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color backgroundColor;

  const CalculatorButton({super.key, required this.text,
    required this.onPressed, this.backgroundColor = Colors.grey,
    required Color textColor});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        padding: const EdgeInsets.all(20.0),
        textStyle: const TextStyle(fontSize: 20.0),
      ),
      child: Text(text),
    );
  }
}
