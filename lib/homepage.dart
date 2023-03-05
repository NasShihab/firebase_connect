import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_connect/user_page/user_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final users = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('HomePage'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${users?.email}',
                style: const TextStyle(fontSize: 40),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                },
                child: const Text(
                  'LogOut',
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: ElevatedButton(
        child: const Text('UserPage',style: TextStyle(fontSize: 40),),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => UserPage()));
        },
      ),
    );
  }
}

