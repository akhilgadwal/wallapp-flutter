import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wallapp/components/textbox.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});
  final currenuser = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: const Text('Profile'),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Users')
            .doc(currenuser.email)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final userData = snapshot.data!.data() as Map<String, dynamic>;
            return ListView(
              children: [
                const SizedBox(
                  height: 40,
                ),
                const Icon(
                  Icons.person,
                  size: 50,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  currenuser.email.toString(),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 50,
                ),
                Text(
                  'My Details',
                  style: TextStyle(fontSize: 18, color: Colors.grey.shade600),
                ),
                TextBox(
                  text: userData['username'],
                  sectioname: 'Username',
                ),
                TextBox(
                  text: userData['userbio'],
                  sectioname: 'bio',
                ),
                const Text('My Post')
              ],
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error occured ${snapshot.hasError}'),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
