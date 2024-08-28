import 'package:flutter/material.dart';
import 'package:uep/models/user_model.dart';

// ignore: must_be_immutable
class UsersTabs extends StatelessWidget {
  List<UserModel> students;
  final int roleId;
  UsersTabs({super.key, required this.roleId, required this.students});

  @override
  Widget build(BuildContext context) {
    if (roleId != 0) {
      students = students.where(
        (user) {
          return user.roleId == roleId;
        },
      ).toList();
    }
    return ListView.builder(
      itemCount: students.length,
      padding: const EdgeInsets.all(15),
      itemBuilder: (context, index) {
        UserModel userModel = students[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 5),
          child: ListTile(
            contentPadding: const EdgeInsets.all(15),
            leading: CircleAvatar(
              backgroundColor: Colors.blue,
              radius: 35,
              backgroundImage: userModel.photo != null
                  ? NetworkImage(
                      "http://millima.flutterwithakmaljon.uz/storage/avatars/${userModel.photo!}")
                  : null,
            ),
            title: Text(userModel.name),
            subtitle: Text(userModel.phone ?? userModel.email ?? ""),
          ),
        );
      },
    );
  }
}
