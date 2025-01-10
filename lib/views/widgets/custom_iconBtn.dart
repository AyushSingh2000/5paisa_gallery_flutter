import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final IconData icon;
  final double size;
  final VoidCallback onPressed;
  final Color color;

  const CustomIconButton({
    Key? key,
    required this.icon,
    required this.size,
    required this.onPressed,
    this.color = Colors.grey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon, size: size, color: color),
      onPressed: onPressed,
    );
  }
}
