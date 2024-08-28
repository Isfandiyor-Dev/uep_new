import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uep/bloc/subject/subject_event.dart';
import 'package:uep/bloc/subject/subject_state.dart';
import 'package:uep/services/subject_service.dart';

class SubjectBloc extends Bloc<SubjectEvent, SubjectState> {
  final SubjectService subjectService;

  SubjectBloc(this.subjectService) : super(SubjectInitial()) {
    on<GetSubjectsEvent>((event, emit) async {
      emit(SubjectsLoading());
      try {
        final subjects = await subjectService.getSubjects();
        emit(SubjectsLoaded(subjects));
      } catch (e) {
        emit(SubjectError(e.toString()));
      }
    });

    on<AddSubjectEvent>((event, emit) async {
      try {
        await subjectService.addSubject(event.data);
        emit(SubjectAdded());
        add(GetSubjectsEvent()); // Yangilangan ro'yxatni olish uchun
      } catch (e) {
        emit(SubjectError(e.toString()));
      }
    });

    on<GetOneSubjectEvent>((event, emit) async {
      emit(SubjectLoading());
      try {
        final subject = await subjectService.getOneSubject(event.id);
        emit(SubjectLoaded(subject));
      } catch (e) {
        emit(SubjectError(e.toString()));
      }
    });

    on<EditSubjectEvent>((event, emit) async {
      try {
        await subjectService.editSubject(event.id, event.data);
        emit(SubjectEdited());
        add(GetSubjectsEvent()); // Yangilangan ro'yxatni olish uchun
      } catch (e) {
        emit(SubjectError(e.toString()));
      }
    });

    on<DeleteSubjectEvent>((event, emit) async {
      try {
        await subjectService.deleteSubject(event.id);
        emit(SubjectDeleted());
        add(GetSubjectsEvent()); // Yangilangan ro'yxatni olish uchun
      } catch (e) {
        emit(SubjectError(e.toString()));
      }
    });
  }
}
