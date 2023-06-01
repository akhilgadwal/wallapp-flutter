import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wallapp/components/liked_button.dart';

class WallPost extends StatefulWidget {
  const WallPost({
    super.key,
    required this.post,
    required this.user,
    required this.postId,
    required this.like,
  });
  final String post;
  final String user;
  final String postId;
  final List<String> like;

  @override
  State<WallPost> createState() => _WallPostState();
}

class _WallPostState extends State<WallPost> {
  final currentuser = FirebaseAuth.instance.currentUser!;
  bool isLiked = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLiked = widget.like.contains(currentuser.email);
  }

  void toggleLikes() {
    setState(() {
      isLiked = !isLiked;
    });
    DocumentReference postRef =
        FirebaseFirestore.instance.collection('Users post').doc(widget.postId);

    if (isLiked) {
      postRef.update({
        'Likes': FieldValue.arrayUnion([currentuser.email])
      });
    } else {
      postRef.update({
        'Likes': FieldValue.arrayRemove([currentuser.email])
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.only(left: 25, right: 25, top: 25),
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Column(
            children: [
              LikedButton(
                isLiked: isLiked,
                onTap: toggleLikes,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(widget.like.length.toString())
            ],
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.user,
                style: TextStyle(color: Colors.grey.shade500),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(widget.post),
            ],
          )
        ],
        // children: [
        //   Column(
        //     children: [
        //       Column(
        //         children: [
        //           LikedButton(
        //             isLiked: isLiked,
        //             onTap: toggleLikes,
        //             //const
        //           ),
        //           //Text(widget.isLike.toString())
        //         ],
        //       ),
        //       Row(
        //         children: [
        //           Text(
        //             widget.user,
        //             style: TextStyle(color: Colors.grey.shade500),
        //           ),
        //           Text(widget.post),
        //         ],
        //       )
        //     ],
        //   )
        // ],
      ),
    );
  }
}
