import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class WallPost extends StatelessWidget {
  const WallPost({
    super.key,
    required this.post,
    required this.user,
  });
  final String post;
  final String user;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.only(left: 25, right: 25, top: 25),
      padding: const EdgeInsets.all(25),
      child: Row(children: [
        Column(
          children: [
            Container(
              decoration: BoxDecoration(color: Colors.grey.shade300),
              child: const Icon(Icons.person),
            ),
            Text(
              user,
              style: TextStyle(color: Colors.grey.shade500),
            ),
            Text(post)
          ],
        )
      ]),
    );
  }
}
