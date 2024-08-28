import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uep/bloc/group/group_bloc.dart';
import 'package:uep/bloc/group/group_event.dart';
import 'package:uep/bloc/group/group_state.dart';
import 'package:uep/models/group_model.dart';
import 'package:uep/ui/admin/pages/groups/add_group/add_group.dart';
import 'package:uep/ui/admin/pages/groups/group_detail.dart';
import 'package:uep/ui/admin/widget/shimmer_users_loading.dart';

class GroupsPage extends StatelessWidget {
  const GroupsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text("Groups"),
        centerTitle: true,
        backgroundColor: Colors.grey[300],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddGroupPage(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: BlocBuilder<GroupBloc, GroupState>(
        bloc: context.read<GroupBloc>()..add(GetGroups()),
        builder: (context, state) {
          if (state is GroupLoading) {
            return const ShimmerUsersLoading();
          } else if (state is GroupError) {
            return Center(
              child: Scaffold(
                body: Center(
                  child: Text("Xatolik yuz berdi: ${state.message}"),
                ),
              ),
            );
          } else if (state is GroupLoaded) {
            List<Group> groups = state.groups;
            return ListView.builder(
              itemCount: groups.length,
              padding: const EdgeInsets.all(15),
              itemBuilder: (context, index) {
                Group group = groups[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GroupDetail(
                          group: group,
                        ),
                      ),
                    );
                  },
                  child: Card(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(15),
                      leading: const CircleAvatar(
                        backgroundColor: Colors.blue,
                        radius: 35,
                      ),
                      title: Text(group.name),
                      subtitle: Text(group.createdAt.toString()),
                    ),
                  ),
                );
              },
            );
          } else {
            // Default holat
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
