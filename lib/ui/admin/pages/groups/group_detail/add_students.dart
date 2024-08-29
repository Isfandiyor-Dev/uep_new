import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uep/bloc/users/users_bloc.dart';
import 'package:uep/models/user_model.dart';

class AddStudents extends StatefulWidget {
  const AddStudents({super.key});

  @override
  State<AddStudents> createState() => _AddStudentsState();
}

class _AddStudentsState extends State<AddStudents> {
  List<Map<String, dynamic>> studentsWithCheckBox = [];

  @override
  void initState() {
    super.initState();
    context.read<UsersBloc>().add(GetUsers());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Students"),
        centerTitle: true,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            Expanded(
              child: FloatingActionButton(
                onPressed: () {
                  // Tanlangan studentlarni qaytarish
                  List<UserModel> selectedStudents = studentsWithCheckBox
                      .where((element) => element["check"] == true)
                      .map((element) => element["student"] as UserModel)
                      .toList();

                  Navigator.pop(context, selectedStudents);
                },
                child: const Text("Add"),
              ),
            ),
          ],
        ),
      ),
      body: BlocBuilder<UsersBloc, UsersState>(
        builder: (context, state) {
          if (state is UsersLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is UsersError) {
            return Center(
              child: Scaffold(
                body: Center(
                  child: Text("Xatolik yuz berdi: ${state.message}"),
                ),
              ),
            );
          } else if (state is UsersLoaded) {
            if (studentsWithCheckBox.isEmpty) {
              List<UserModel> students =
                  state.users.where((element) => element.roleId == 1).toList();
              studentsWithCheckBox = students
                  .map(
                    (e) => {
                      "student": e,
                      "check": false,
                    },
                  )
                  .toList();
            }

            return ListView.builder(
              itemCount: studentsWithCheckBox.length,
              padding: const EdgeInsets.only(
                left: 15,
                right: 15,
                top: 15,
                bottom: 45,
              ),
              itemBuilder: (context, index) {
                UserModel userModel = studentsWithCheckBox[index]["student"];
                Map<String, dynamic> userMap = studentsWithCheckBox[index];
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
                    trailing: Checkbox(
                      value: userMap["check"],
                      onChanged: (value) {
                        setState(() {
                          userMap["check"] = value;
                        });
                      },
                    ),
                  ),
                );
              },
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
