import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uep/bloc/users/users_bloc.dart';
import 'package:uep/bloc/users/users_event.dart';
import 'package:uep/bloc/users/users_state.dart';
import 'package:uep/models/user_model.dart';
import 'package:uep/ui/admin/pages/users/users_tabs/users_tabs.dart';
import 'package:uep/ui/admin/widget/user_page_shimmer.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Users"),
          centerTitle: true,
        ),
        body: BlocBuilder<UsersBloc, UsersState>(
          bloc: context.read<UsersBloc>()..add(GetUsers()),
          builder: (context, state) {
            if (state is UsersLoading) {
              return const UsersPageShimmer();
            } else if (state is UsersError) {
              return Center(
                child: Scaffold(
                  body: Center(
                    child: Text("Xatolik yuz berdi: ${state.message}"),
                  ),
                ),
              );
            } else if (state is UsersLoaded) {
              late List<UserModel> students = state.users;

              return DefaultTabController(
                length: 4,
                child: Column(
                  children: [
                    const Expanded(
                      flex: 1,
                      child: TabBar(
                        tabs: [
                          Text("All Users"),
                          Text("Students"),
                          Text("Teachers"),
                          Text("Admins"),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 12,
                      child: TabBarView(
                        children: [
                          UsersTabs(
                            roleId: 0,
                            students: students,
                          ),
                          UsersTabs(
                            roleId: 1,
                            students: students,
                          ),
                          UsersTabs(
                            roleId: 2,
                            students: students,
                          ),
                          UsersTabs(
                            roleId: 3,
                            students: students,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ));
  }
}
