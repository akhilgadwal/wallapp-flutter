import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wallapp/components/textfiled.dart';
import 'package:wallapp/components/wall_post.dart';
import 'package:wallapp/pages/profilepage.dart';

import '../components/drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  final currentUser = FirebaseAuth.instance.currentUser!;
  bool obsureText = false;
  final TextEditingController controller = TextEditingController();

  void postMessage() {
    if (controller.text.isNotEmpty) {
      FirebaseFirestore.instance.collection('Users post').add({
        'Useremail': currentUser.email,
        'Message': controller.text,
        'Timestamp': Timestamp.now(),
        'Likes': []
      });
    }
    setState(() {
      controller.clear();
    });
  }

  //
  void gotoprofile() {
    Navigator.pop(context);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ProfilePage()));
  }

  //
  void gotohomepage() {
    Navigator.pop(context);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const HomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: const Center(child: Text('WallApp')),
        actions: [
          IconButton(onPressed: signOut, icon: const Icon(Icons.logout))
        ],
      ),
      drawer: MyDrawer(
        onhometap: gotohomepage,
        onprofiletap: gotoprofile,
      ),
      body: Column(children: [
        //the wall
        Expanded(
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("Users post")
                .orderBy('Timestamp', descending: false)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final post = snapshot.data!.docs[index];
                      return WallPost(
                        post: post['Message'],
                        user: post['Useremail'],
                        postId: post.id,
                        like: List<String>.from(post['Likes'] ?? []),
                      );
                    });
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error${snapshot.hasError}'),
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),

        //post message
        Padding(
          padding: const EdgeInsets.all(25.0),
          child: Row(
            children: [
              Expanded(
                child: MyTextField(
                    obsureText: obsureText,
                    controller: controller,
                    hintText: 'Write something on the wall'),
              ),
              IconButton(
                  onPressed: postMessage,
                  icon: const Icon(Icons.arrow_circle_up))
            ],
          ),
        ),

        //logged in as user
        //Text('Logged in as  $currentUser')
      ]),
    );
  }
}
