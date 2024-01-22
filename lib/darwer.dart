// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thainews2/my_home_page.dart';
import 'package:thainews2/test.dart';
import 'package:thainews2/thai%20news.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Teerasak News',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Welcome'),
            onTap: () {
              Get.to(MyHomePage());
            },
          ),
          ListTile(
            leading: Icon(Icons.login),
            title: Text('Login'),
            onTap: () {
              Get.to(TestLogin());
            },
          ),
          ListTile(
            leading: Icon(Icons.newspaper_rounded),
            title: Text('Teerasak News'),
            onTap: () {
              Get.to(ThaiNews());
            },
          ),
        ],
      ),
    );
  }
}
