import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uep/models/group_model.dart';
import 'package:uep/services/group_service.dart';
import 'package:equatable/equatable.dart';

part 'group_event.dart';
part 'group_state.dart';

class GroupBloc extends Bloc<GroupEvent, GroupState> {
  final GroupService groupService;

  GroupBloc({required this.groupService}) : super(GroupInitial()) {
    on<GetGroups>((event, emit) async {
      emit(GroupLoading());
      try {
        List<Group>? data = await groupService.getGroups();
        if (data != null) {
          emit(GroupLoaded(data));
        } else {
          emit(const GroupError("Foydalanuvchi ma'lumotlari topilmadi"));
        }
      } catch (e) {
        emit(GroupError("Xatolik yuz get groups berdi: $e"));
      }
    });
    on<AddGroup>(addGroup);
    on<GetStudentGroups>(getStudentGroups);
    on<AddStudentToGroup>(addStudentsToGroup);
  }

  Future<void> addStudentsToGroup(
    AddStudentToGroup event,
    Emitter<GroupState> emit,
  ) async {
    try {
      await groupService.addStudentToGroup(
        groupId: event.groupId,
        studentsId: event.studentsId,
      );
      add(GetGroups());
    } catch (e) {
      emit(GroupError("Xatolik yuz add group berdi: $e"));
    }
  }

  Future<void> addGroup(AddGroup event, Emitter<GroupState> emit) async {
    try {
      await groupService.addGroup(event.data);
      add(GetGroups());
    } catch (e) {
      emit(GroupError("Xatolik yuz add group berdi: $e"));
    }
  }

  Future<void> getStudentGroups(event, emit) async {
    emit(GroupLoading());
    try {
      List<Group>? data = await groupService.getStudentGroups();
      if (data != null) {
        emit(GroupLoaded(data));
      } else {
        emit(const GroupError("Foydalanuvchi ma'lumotlari topilmadi"));
      }
    } catch (e) {
      emit(GroupError("Xatolik yuz get student group berdi: $e"));
    }
  }
}
