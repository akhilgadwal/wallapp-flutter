import 'package:flutter/material.dart';

class LikedButton extends StatelessWidget {
  LikedButton({super.key, required this.isLiked, this.onTap});
  final bool isLiked;
  void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(
        isLiked ? Icons.favorite : Icons.favorite_border,
        color: isLiked ? Colors.red : Colors.grey,
      ),
    );
  }
}
