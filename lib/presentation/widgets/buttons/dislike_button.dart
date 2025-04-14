import 'package:flutter/material.dart';

class DislikeButton extends StatelessWidget {
  final VoidCallback onPressed;
  final double size;

  const DislikeButton({
    Key? key,
    required this.onPressed,
    this.size = 40,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.cancel, color: Colors.red, size: size),
      onPressed: onPressed,
    );
  }
}
