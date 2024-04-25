import 'package:flutter/material.dart';

import '../utils/kwtheme.dart';

class KWButton extends StatelessWidget {
  const KWButton({super.key, required this.text, required this.onPressed});

  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: KWTheme().primaryColor,
      ),
      child: Text(text,
        style: TextStyle(
          color: KWTheme().backgroundColor,
        ),
      ),
    );
  }
  
}