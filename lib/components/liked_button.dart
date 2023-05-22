import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';

class LikedButton extends StatelessWidget {
  LikedButton({super.key, required this.isLiked, this.onTap});
  final bool isLiked;
  void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(
        (isLiked ? Icons.favorite : const Icon(Icons.favorite_border))
            as IconData?,
        color: isLiked ? Colors.red : Colors.grey,
      ),
    );
  }
}
