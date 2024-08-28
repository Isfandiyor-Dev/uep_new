import 'package:equatable/equatable.dart';

abstract class SubjectEvent extends Equatable {
  const SubjectEvent();

  @override
  List<Object> get props => [];
}

// Barcha Subjects ni olish
class GetSubjectsEvent extends SubjectEvent {}

// Yangi Subject qo'shish
class AddSubjectEvent extends SubjectEvent {
  final Map<String, dynamic> data;

  const AddSubjectEvent(this.data);

  @override
  List<Object> get props => [data];
}

// Bitta Subject ni olish
class GetOneSubjectEvent extends SubjectEvent {
  final int id;

  const GetOneSubjectEvent(this.id);

  @override
  List<Object> get props => [id];
}

// Subjectni tahrirlash
class EditSubjectEvent extends SubjectEvent {
  final int id;
  final Map<String, dynamic> data;

  const EditSubjectEvent(this.id, this.data);

  @override
  List<Object> get props => [id, data];
}

// Subjectni o'chirish
class DeleteSubjectEvent extends SubjectEvent {
  final int id;

  const DeleteSubjectEvent(this.id);

  @override
  List<Object> get props => [id];
}
