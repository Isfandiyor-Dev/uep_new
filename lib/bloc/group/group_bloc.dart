import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uep/bloc/group/group_event.dart';
import 'package:uep/bloc/group/group_state.dart';
import 'package:uep/models/group_model.dart';
import 'package:uep/services/group_service.dart';

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
