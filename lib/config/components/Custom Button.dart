import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final TextStyle textStyle;
  final double height; // New parameter for height
  final double width;  // New parameter for width

  CustomButton({
    required this.text,
    required this.onPressed,
    this.color = Colors.teal,
    this.textStyle = const TextStyle(color: Colors.white, fontSize: 16.0),
    this.height = 48.0, // Default height
    this.width = double.infinity, required Widget child, // Default width to take full width
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SizedBox(
        height: height,
        width: width,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            padding: EdgeInsets.symmetric(vertical: 16.0),
          ),
          child: Text(
            text,
            style: textStyle,
          ),
        ),
      ),
    );
  }
}
