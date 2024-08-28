import 'package:equatable/equatable.dart';
import 'package:uep/bloc/auth/auth_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AuthenticationStarted extends AuthenticationEvent {}

class AuthenticationSignUp extends AuthenticationEvent {
  final Map<String, dynamic> data;
  const AuthenticationSignUp({required this.data});

  @override
  List<Object> get props => [data];
}

class AuthenticationSignIn extends AuthenticationEvent {
  final Map<String, dynamic> data;
  const AuthenticationSignIn({required this.data});

  @override
  List<Object> get props => [data];
}

// final class SocialLoginEvent extends AuthenticationEvent {
//   final SocialLoginTypes type;
//   final int? roleId;

//   const SocialLoginEvent({required this.type, this.roleId});
// }

class AuthenticationLoggedOut extends AuthenticationEvent {}
