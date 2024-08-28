import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uep/bloc/subject/subject_bloc.dart';
import 'package:uep/bloc/subject/subject_event.dart';
import 'package:uep/bloc/subject/subject_state.dart';
import 'package:uep/models/subject_model.dart';
import 'package:uep/ui/admin/pages/home/tiles_drawer/subjects/manage_subject.dart';
import 'package:uep/ui/admin/widget/shimmer_group_loading.dart';

class Subjects extends StatefulWidget {
  const Subjects({super.key});

  @override
  State<Subjects> createState() => _SubjectsState();
}

class _SubjectsState extends State<Subjects> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubjectBloc, SubjectState>(
      bloc: context.read<SubjectBloc>()..add(GetSubjectsEvent()),
      builder: (context, state) {
        if (state is SubjectsLoading) {
          return const ShimmerGroupLoading();
        } else if (state is SubjectError) {
          return Center(
            child: Scaffold(
              body: Center(
                child: Text("Xatolik yuz berdi: $state"),
              ),
            ),
          );
        } else if (state is SubjectsLoaded) {
          List<Subject> subjects = state.subjects;
          return Scaffold(
            backgroundColor: Colors.grey[200],
            appBar: AppBar(
              title: const Text("Subjects"),
              centerTitle: true,
              backgroundColor: Colors.grey[300],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                String? name = await showDialog(
                  context: context,
                  builder: (context) => ManageSubjectDiolog(),
                );

                if (name != null) {
                  context.read<SubjectBloc>().add(
                        AddSubjectEvent({"name": name}),
                      );
                }
              },
              child: const Icon(Icons.add),
            ),
            body: StatefulBuilder(builder: (context, setState) {
              return ListView.builder(
                itemCount: subjects.length,
                padding: const EdgeInsets.all(15),
                itemBuilder: (context, index) {
                  Subject subject = subjects[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: ListTile(
                      title: Text(subject.name),
                      contentPadding: const EdgeInsets.all(15),
                      subtitle: Text(subject.name),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              context.read<SubjectBloc>().add(
                                    DeleteSubjectEvent(subject.id),
                                  );
                            },
                            icon: const Icon(Icons.delete),
                          ),
                          IconButton(
                            onPressed: () async {
                              String? name = await showDialog(
                                context: context,
                                builder: (context) => ManageSubjectDiolog(
                                  isAddDiolog: false,
                                ),
                              );

                              if (name != null) {
                                // ignore: use_build_context_synchronously
                                context.read<SubjectBloc>().add(
                                      EditSubjectEvent(
                                          subject.id, {"name": name}),
                                    );
                              }
                            },
                            icon: const Icon(Icons.edit),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
