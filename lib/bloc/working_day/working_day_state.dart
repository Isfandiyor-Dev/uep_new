part of "working_day_bloc.dart";



abstract class WorkingDayState extends Equatable {
  const WorkingDayState();

  @override
  List<Object?> get props => [];
}

class WorkingDayInitial extends WorkingDayState {}

class WorkingDayLoading extends WorkingDayState {}

class WorkingDayLoaded extends WorkingDayState {
  final List<WorkingDay> days;

  const WorkingDayLoaded(this.days);

  @override
  List<Object?> get props => [days];
}

class WorkingDayError extends WorkingDayState {
  final String message;

  const WorkingDayError(this.message);

  @override
  List<Object?> get props => [message];
}
