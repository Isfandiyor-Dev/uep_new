import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/blocs.dart';
import 'package:uep/core/app.dart';
import 'package:uep/firebase_options.dart';
import 'services/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final AuthService authService = AuthService();
  final ProfileService profileService = ProfileService();
  final UsersService usersService = UsersService();
  final GroupService groupService = GroupService();
  final WorkingDayService workingDayService = WorkingDayService();
  final SubjectService subjectService = SubjectService();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthenticationBloc(authService)
            ..add(
              AuthenticationStarted(),
            ),
        ),
        BlocProvider(
          create: (context) => ProfileBloc(
            profileService: profileService,
          ),
        ),
        BlocProvider(
          create: (context) => UsersBloc(usersService: usersService),
        ),
        BlocProvider(
          create: (context) => GroupBloc(groupService: groupService),
        ),
        BlocProvider(
          create: (context) =>
              WorkingDayBloc(workingDayService: workingDayService),
        ),
        BlocProvider(
          create: (context) => SubjectBloc(subjectService),
        ),
      ],
      child: const MainApp(),
    ),
  );
}
