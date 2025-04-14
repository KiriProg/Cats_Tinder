import 'package:flutter/material.dart';

class LikeButton extends StatelessWidget {
  final VoidCallback onPressed;
  final double size;

  const LikeButton({
    Key? key,
    required this.onPressed,
    this.size = 40,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.favorite, color: Colors.green, size: size),
      onPressed: onPressed,
    );
  }
}
