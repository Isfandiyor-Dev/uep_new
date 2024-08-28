import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uep/bloc/auth/auth_bloc.dart';
import 'package:uep/bloc/auth/auth_event.dart';
import 'package:uep/bloc/group/group_bloc.dart';
import 'package:uep/bloc/profile/profile_bloc.dart';
import 'package:uep/bloc/subject/subject_bloc.dart';
import 'package:uep/bloc/users/users_bloc.dart';
import 'package:uep/bloc/working_day/working_day_bloc.dart';
import 'package:uep/core/app.dart';
import 'package:uep/firebase_options.dart';
import 'package:uep/services/auth_service.dart';
import 'package:uep/services/group_service.dart';
import 'package:uep/services/profile_service.dart';
import 'package:uep/services/subject_service.dart';
import 'package:uep/services/users_service.dart';
import 'package:uep/services/working_day_service.dart';

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
