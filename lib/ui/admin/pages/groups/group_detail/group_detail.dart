import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uep/bloc/group/group_bloc.dart';
import 'package:uep/models/group_model.dart';
import 'package:uep/models/student_model.dart';
import 'package:uep/models/user_model.dart';
import 'package:uep/ui/admin/pages/groups/group_detail/add_students.dart';

// ignore: must_be_immutable
class GroupDetail extends StatelessWidget {
  Group group;
  GroupDetail({super.key, required this.group});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Group Detail"),
        centerTitle: true,
      ),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(group.name,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    Text('Main Teacher: ${group.mainTeacher.name}'),
                    Text('Assistant Teacher: ${group.assistantTeacher.name}'),
                    Text('Subject: ${group.subject?.name}'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Students this group",
                          style: TextStyle(
                            height: 3,
                            fontSize: 20,
                          ),
                        ),
                        IconButton(
                          onPressed: () async {
                            List<UserModel> students = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AddStudents(),
                              ),
                            );
                            List<int> studentsId =
                                students.map((e) => e.id).toList();
                            // ignore: use_build_context_synchronously
                            BlocProvider.of<GroupBloc>(context).add(
                              AddStudentToGroup(
                                groupId: group.id,
                                studentsId: studentsId,
                              ),
                            );
                          },
                          icon: const Icon(Icons.add),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ];
        },
        body: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          itemCount: group.students.length,
          itemBuilder: (context, index) {
            Student student = group.students[index];
            return Card(
              child: ListTile(
                title: Text(student.name),
                subtitle: Text(student.email ?? student.phone ?? ""),
              ),
            );
          },
        ),
      ),
    );
  }
}
