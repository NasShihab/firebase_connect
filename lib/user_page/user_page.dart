import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_connect/user_page/date_picker_widget.dart';
import 'package:firebase_connect/user_page/read_user.dart';
import 'package:firebase_connect/user_page/users_page_model.dart';
import 'package:flutter/material.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  // const UserPage({Key? key}) : super(key: key);
  //
  // final keyValue = GlobalKey<_DatePickFieldState>();

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final ageController = TextEditingController();
    final birthController = TextEditingController();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('User - FireStore'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                style: const TextStyle(fontSize: 40),
                decoration: const InputDecoration(
                    hintText: 'Type your name',
                    hintStyle: TextStyle(fontSize: 30)),
                controller: nameController,
              ),
              TextField(
                keyboardType: TextInputType.number,
                style: const TextStyle(fontSize: 40),
                decoration: const InputDecoration(
                    hintText: 'Type your age',
                    hintStyle: TextStyle(fontSize: 30)),
                controller: ageController,
              ),
              DatePickField(
                birthController: birthController,
              ),
              const SizedBox(
                height: 50,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[700]),
                child: const Text(
                  'Add Firestorm Data',
                  style: TextStyle(fontSize: 30),
                ),
                onPressed: () {
                  final user = Users(
                    id: nameController.text,
                    name: nameController.text,
                    age: int.parse(ageController.text),
                    birthday: DateTime.parse(birthController.text),
                    //birthday: birthday,
                  );
                  createUser(user);
                },
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ReadUser()));
                },
                child: const Text('Read User Data'),
              ),
               SizedBox(
                height: 400,
                child: ReadUser(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future createUser(Users user) async {
    {
      final docUser =
          FirebaseFirestore.instance.collection('users').doc(user.name);

      final json = user.toJson();
      await docUser.set(json);
    }
  }
}
