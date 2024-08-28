import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uep/bloc/auth/auth_bloc.dart';
import 'package:uep/bloc/auth/auth_state.dart';
import 'package:uep/core/auth_gate.dart';
import 'package:uep/ui/auth/login/login_page.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state is AuthenticationLoading) {
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) => const Center(
                child: CircularProgressIndicator.adaptive(
                  backgroundColor: Colors.white,
                ),
              ),
            );
          } else if (state is AuthenticationAuthenticated) {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => const AuthGate(),
              ),
              (route) => false,
            );
          } else if (state is AuthenticationUnauthenticated) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const LoginPage()),
            );
          } else if (state is AuthenticationFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Authentication Error: ${state.error}')),
            );
          }
        },
        child: Scaffold(
          body: Center(
            child: Image.asset(
              "assets/logo.png",
              width: 150,
              height: 150,
              color: Colors.lightBlue,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
