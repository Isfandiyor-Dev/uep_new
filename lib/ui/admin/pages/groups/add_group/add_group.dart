import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uep/bloc/group/group_bloc.dart';
import 'package:uep/bloc/group/group_event.dart';
import 'package:uep/models/subject_model.dart';
import 'package:uep/models/user_model.dart';
import 'package:uep/ui/admin/pages/groups/add_group/choose_subject.dart';
import 'package:uep/ui/admin/pages/groups/add_group/choose_teacher.dart';
import 'package:uep/ui/global_screens/widgets/custom_text_field.dart';

class AddGroupPage extends StatefulWidget {
  const AddGroupPage({super.key});

  @override
  State<AddGroupPage> createState() => _AddGroupPageState();
}

class _AddGroupPageState extends State<AddGroupPage> {
  final nameController = TextEditingController();

  final teacherOneController = TextEditingController();
  final teacherTwoController = TextEditingController();
  final subjectController = TextEditingController();

  UserModel? teacherOne;
  UserModel? teacherTwo;
  Subject? subjectField;

  void addGroup() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add group"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            StatefulBuilder(builder: (context, setState) {
              return Column(
                children: [
                  CustomTextField(
                    labelText: "Name",
                    hintText: "Enter name group",
                    controller: nameController,
                    readOnly: false,
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    labelText: "Teacher",
                    readOnly: true,
                    hintText: "Choose Teaceher",
                    controller: teacherOneController,
                    onTap: () async {
                      teacherOne = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ChooseTeacher(),
                        ),
                      );

                      if (teacherOne != null) {
                        teacherOneController.text = teacherOne!.name;
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    labelText: "Asistent Teacher",
                    readOnly: true,
                    hintText: "Choose Asistent teaceher",
                    controller: teacherTwoController,
                    onTap: () async {
                      teacherTwo = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ChooseTeacher(),
                        ),
                      );
                      if (teacherTwo != null) {
                        teacherTwoController.text = teacherTwo!.name;
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    labelText: "Subject",
                    readOnly: true,
                    hintText: "Choose Subject",
                    controller: subjectController,
                    onTap: () async {
                      subjectField = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ChooseSubject(),
                        ),
                      );
                      if (subjectField != null) {
                        subjectController.text = subjectField!.name;
                      }
                    },
                  ),
                ],
              );
            }),
            GestureDetector(
              onTap: () {
                if (teacherOne != null && teacherTwo != null) {
                  BlocProvider.of<GroupBloc>(context).add(
                    AddGroup(
                      data: {
                        "name": nameController.text,
                        "main_teacher_id": teacherOne!.id,
                        "assistant_teacher_id": teacherTwo!.id,
                        "subject_id": subjectField!.id,
                      },
                    ),
                  );
                  Navigator.pop(context);
                }
              },
              child: Container(
                width: double.infinity,
                height: 60,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.deepPurple,
                ),
                child: const Text(
                  "Add Group",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
