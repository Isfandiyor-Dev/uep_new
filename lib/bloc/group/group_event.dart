import 'package:equatable/equatable.dart';

sealed class GroupEvent extends Equatable {
  const GroupEvent();

  @override
  List<Object?> get props => [];
}

final class GetGroups extends GroupEvent {}

final class AddGroup extends GroupEvent {
  final Map<String, dynamic> data;
  const AddGroup({required this.data});
}

final class GetStudentGroups extends GroupEvent {}
