import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:wallapp/components/list_tile.dart';

class MyDrawer extends StatelessWidget {
  Function()? onprofiletap;
  Function()? onhometap;
  MyDrawer({super.key, required this.onhometap, required this.onprofiletap});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: [
        //icon for head
        DrawerHeader(
          child: Icon(
            Icons.person,
            size: 40,
          ),
        ),
        MyListile(
          icon: Icon(Icons.home),
          title: 'H O M E',
          onTap: onhometap,
        ),
        MyListile(
          icon: Icon(Icons.person),
          title: 'P R O F I L E',
          onTap: onprofiletap,
        ),
        MyListile(
          icon: Icon(Icons.logout),
          title: 'L O G O U T',
          onTap: () {},
        ),
      ]),
      //home
      //profile
      //logout
    );
  }
}
