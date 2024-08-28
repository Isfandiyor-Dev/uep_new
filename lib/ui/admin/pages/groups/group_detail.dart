import 'package:flutter/material.dart';
import 'package:uep/models/group_model.dart';
import 'package:uep/models/student_model.dart';

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
                    Text('Subject: ${group.subject.name}'),
                    const Row(
                      children: [
                        Text(
                          "Students this group",
                          style: TextStyle(
                            height: 3,
                            fontSize: 20,
                          ),
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
