import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_connect/user_page/users_page_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReadUser extends StatelessWidget {
  ReadUser({Key? key}) : super(key: key);

  final CollectionReference ref =
      FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Read User'),
        centerTitle: true,
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          final docUser =
              FirebaseFirestore.instance.collection('users').doc('lak');
          docUser.update({
            'name': 'Eng',
          });
        },
        child: const Text('Update'),
      ),
      body: SafeArea(
        child: StreamBuilder<List<Users>>(
          stream: readUser(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text(
                  'Invalid',
                  style: TextStyle(fontSize: 40),
                ),
              );
            } else if (snapshot.hasData) {
              final users = snapshot.data!;
              // return ListView(
              //   shrinkWrap: true,
              //   children: users.map(buildUser).toList(),
              // );
              return ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) => ListTile(
                  visualDensity: VisualDensity.comfortable,
                  isThreeLine: true,
                  subtitleTextStyle: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                  onTap: () {
                    // Update Data ------------------------
                    // ref.doc(users[index].id.toString()).update({
                    //   'name' : 'NEW'
                    // });
                    // Delete Data -------------------------
                    // ref.doc(users[index].id.toString()).delete();
                  },
                  title: Text(
                    users[index].name,
                    style: const TextStyle(fontSize: 30),
                  ),
                  leading: CircleAvatar(
                    radius: 28,
                    child: Text('${users[index].age}',
                        style: const TextStyle(fontSize: 25)),
                  ),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(DateFormat.yMMMMd('en_US')
                          .format(users[index].birthday)),
                      SizedBox(
                        width: 80,
                        child: Text(users[index].id,
                            overflow: TextOverflow.ellipsis),
                      )
                    ],
                  ),
                  trailing: Column(
                    children: [
                      Expanded(
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.delete,
                              size: 30, color: Colors.red),
                        ),
                      ),
                      Expanded(
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.edit,
                              size: 30, color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

// no need update ----------------------------------<
  Widget buildUser(Users users) => ListTile(
        leading: CircleAvatar(child: Text('${users.age}')),
        title: Text(users.name),
        // subtitle: Text('${users.birthday.day}/${users.birthday.month}/${users.birthday.year}'),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(DateFormat.yMMMMd('en_US').format(users.birthday)),
            Text(users.id)
          ],
        ),
      );
// no need update ---------------------------------->

  // Read User data
  Stream<List<Users>> readUser() => FirebaseFirestore.instance
      .collection('users')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Users.fromJson(doc.data())).toList());
}
