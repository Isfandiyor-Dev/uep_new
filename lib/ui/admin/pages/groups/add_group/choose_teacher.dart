import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uep/bloc/users/users_bloc.dart';
import 'package:uep/models/user_model.dart';
import 'package:uep/ui/admin/widget/shimmer_group_loading.dart';

class ChooseTeacher extends StatefulWidget {
  const ChooseTeacher({super.key});

  @override
  State<ChooseTeacher> createState() => _ChooseTeacherState();
}

class _ChooseTeacherState extends State<ChooseTeacher> {
  int currentUser = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsersBloc, UsersState>(
      bloc: context.read<UsersBloc>()..add(GetUsers()),
      builder: (context, state) {
        if (state is UsersLoading) {
          return const ShimmerGroupLoading();
        } else if (state is UsersError) {
          return Center(
            child: Scaffold(
              body: Center(
                child: Text("Xatolik yuz berdi: ${state.message}"),
              ),
            ),
          );
        } else if (state is UsersLoaded) {
          List<UserModel> teachers =
              state.users.where((user) => user.roleId == 2).toList();
          return Scaffold(
            backgroundColor: Colors.grey[200],
            appBar: AppBar(
              title: const Text("Choose Teacher"),
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
                        Navigator.pop(context, teachers[currentUser]);
                      },
                      child: const Text("Choose"),
                    ),
                  ),
                ],
              ),
            ),
            body: StatefulBuilder(builder: (context, setState) {
              return ListView.builder(
                itemCount: teachers.length,
                padding: const EdgeInsets.all(15),
                itemBuilder: (context, index) {
                  UserModel userModel = teachers[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: RadioListTile(
                      title: Text(userModel.name),
                      contentPadding: const EdgeInsets.all(15),
                      subtitle: Text(userModel.phone ?? userModel.email ?? ""),
                      value: currentUser,
                      onChanged: (value) {
                        currentUser = index;
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
