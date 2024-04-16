import 'package:flutter/material.dart';

class CalculatorButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;

  const CalculatorButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.backgroundColor = Colors.grey,
    required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        padding: const EdgeInsets.all(20.0),
        textStyle: const TextStyle(fontSize: 20.0),
      ),
      child: Text(
        text,
        style: TextStyle(color: textColor),
      ),
    );
  }
}