part of "group_bloc.dart";

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

// ignore: must_be_immutable
final class AddStudentToGroup extends GroupEvent {
  int groupId;
  List<int> studentsId;
  AddStudentToGroup({required this.groupId, required this.studentsId});
}

final class GetStudentGroups extends GroupEvent {}
