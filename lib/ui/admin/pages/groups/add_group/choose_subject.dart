import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uep/bloc/subject/subject_bloc.dart';
import 'package:uep/bloc/subject/subject_event.dart';
import 'package:uep/bloc/subject/subject_state.dart';
import 'package:uep/models/subject_model.dart';
import 'package:uep/ui/admin/widget/shimmer_group_loading.dart';

class ChooseSubject extends StatefulWidget {
  const ChooseSubject({super.key});

  @override
  State<ChooseSubject> createState() => _ChooseSubjectState();
}

class _ChooseSubjectState extends State<ChooseSubject> {
  int currentSubject = 0;

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
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: FloatingActionButton(
                      onPressed: () {
                        Navigator.pop(context, subjects[currentSubject]);
                      },
                      child: const Text("Choose"),
                    ),
                  ),
                ],
              ),
            ),
            body: StatefulBuilder(builder: (context, setState) {
              return ListView.builder(
                itemCount: subjects.length,
                padding: const EdgeInsets.all(15),
                itemBuilder: (context, index) {
                  Subject subject = subjects[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: RadioListTile(
                      title: Text(subject.name),
                      contentPadding: const EdgeInsets.all(15),
                      subtitle: Text(subject.name),
                      value: currentSubject,
                      onChanged: (value) {
                        currentSubject = index;
                        setState(() {});
                      },
                      groupValue: index,
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
