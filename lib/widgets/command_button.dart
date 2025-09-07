import 'package:flutter/material.dart';

class CommandButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const CommandButton({
    super.key,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        onPressed: onPressed,
        child: Text(title),
      ),
    );
  }
}
