import 'package:equatable/equatable.dart';

sealed class WorkingDayEvent extends Equatable {
  const WorkingDayEvent();

  @override
  List<Object?> get props => [];
}

final class GetWorkingDays extends WorkingDayEvent {}

final class UpdateWorkingDay extends WorkingDayEvent {
  final List<Map<String, dynamic>> data;
  const UpdateWorkingDay({required this.data});
}

final class GetStudentWorkingDayEvent extends WorkingDayEvent {}
