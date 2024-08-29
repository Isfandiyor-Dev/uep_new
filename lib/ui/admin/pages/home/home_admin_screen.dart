import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uep/bloc/auth/auth_bloc.dart';
import 'package:uep/bloc/profile/profile_bloc.dart';
import 'package:uep/models/user_model.dart';
import 'package:uep/ui/admin/pages/home/drawer.dart';
import 'package:uep/ui/auth/login/login_page.dart';
import 'package:uep/ui/global_screens/profile/profile_page.dart';
import 'package:uep/ui/global_screens/widgets/shimmer_home_loading.dart';

class HomeAdminScreen extends StatelessWidget {
  const HomeAdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      bloc: context.read<ProfileBloc>()..add(LoadProfile()),
      builder: (context, state) {
        if (state is ProfileLoading) {
          return const ShimmerLoading();
        } else if (state is ProfileError) {
          return Center(
            child: Scaffold(
              body: Center(
                child: Text(state.message),
              ),
            ),
          );
        } else if (state is ProfileLoaded) {
          UserModel userModel = state.user;

          return Scaffold(
            drawer: const AdminDrawer(),
            appBar: AppBar(
              title: const Text("Home"),
              centerTitle: true,
              toolbarHeight: 80,
              actions: [
                BlocListener<AuthenticationBloc, AuthenticationState>(
                  listener: (context, state) {
                    if (state is AuthenticationUnauthenticated) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ),
                      );
                    }
                  },
                  child: IconButton(
                    onPressed: () {
                      BlocProvider.of<AuthenticationBloc>(context)
                          .add(AuthenticationLoggedOut());
                    },
                    icon: const Icon(Icons.logout_rounded),
                  ),
                ),
                const SizedBox(width: 10),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProfilePage(),
                        ),
                      );
                    },
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.teal,
                      backgroundImage: userModel.photo != null
                          ? NetworkImage(
                              "http://millima.flutterwithakmaljon.uz/storage/avatars/${userModel.photo!}")
                          : null,
                    ),
                  ),
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(15.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Name: ${userModel.name}'),
                    Text('Phone: ${userModel.phone}'),
                    Text('Email: ${userModel.email}'),
                    Text('Role: ${userModel.role.name}'),
                  ],
                ),
              ),
            ),
          );
        } else {
          // Default holat
          return const SizedBox.shrink();
        }
      },
    );
  }
}
