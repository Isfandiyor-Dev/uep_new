import 'dart:io';

import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class LoadProfile extends ProfileEvent {}

class EditProfile extends ProfileEvent {
  final Map<String, dynamic> data;
  final File? image;
  const EditProfile({required this.data, this.image});
}
