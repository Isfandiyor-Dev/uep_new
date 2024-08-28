import 'package:equatable/equatable.dart';
import 'package:uep/models/subject_model.dart';

abstract class SubjectState extends Equatable {
  const SubjectState();

  @override
  List<Object> get props => [];
}

// Initial state
class SubjectInitial extends SubjectState {}

// Barcha Subjects yuklanmoqda
class SubjectsLoading extends SubjectState {}

// Barcha Subjects yuklandi
class SubjectsLoaded extends SubjectState {
  final List<Subject> subjects;

  const SubjectsLoaded(this.subjects);

  @override
  List<Object> get props => [subjects];
}

// Bitta Subject yuklanmoqda
class SubjectLoading extends SubjectState {}

// Bitta Subject yuklandi
class SubjectLoaded extends SubjectState {
  final Subject subject;

  const SubjectLoaded(this.subject);

  @override
  List<Object> get props => [subject];
}

// Subject qo'shildi
class SubjectAdded extends SubjectState {}

// Subject tahrirlandi
class SubjectEdited extends SubjectState {}

// Subject o'chirildi
class SubjectDeleted extends SubjectState {}

// Xato holati
class SubjectError extends SubjectState {
  final String message;

  const SubjectError(this.message);

  @override
  List<Object> get props => [message];
}
