import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uep/bloc/profile/profile_bloc.dart';
import 'package:uep/bloc/profile/profile_event.dart';
import 'package:uep/bloc/profile/profile_state.dart';
import 'package:uep/models/user_model.dart';
import 'package:uep/ui/admin/pages/manage_admin_page.dart/manage_admin_page.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      bloc: context.read<ProfileBloc>()..add(LoadProfile()),
      builder: (context, state) {
        if (state is ProfileLoading) {
          return Scaffold(
            body: Center(
              child: Image.asset(
                "assets/logo.png",
                width: 150,
                height: 150,
                color: Colors.lightBlue,
                fit: BoxFit.cover,
              ),
            ),
          );
        } else if (state is ProfileError) {
          return Scaffold(
            body: Center(
              child: Text(state.message),
            ),
          );
        } else if (state is ProfileLoaded) {
          UserModel userModel = state.user;
          // if (userModel.roleId == 3)

          if (userModel.roleId != 0) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const ManageAdminPage(),
                ),
                (route) => false,
              );
            });
            return Scaffold(
              body: Center(
                child: Image.asset(
                  "assets/logo.png",
                  width: 150,
                  height: 150,
                  color: Colors.lightBlue,
                  fit: BoxFit.cover,
                ),
              ),
            );
          } else {
            return const Scaffold(
              body: Center(
                child: Text(
                    'Unauthorized Access (Ya\'ni sen boshqa role bilan kirding!)'),
              ),
            );
          }
        } else {
          return const Scaffold(
            body: Center(
              child: Text('Unexpected state.'),
            ),
          );
        }
      },
    );
  }
}
