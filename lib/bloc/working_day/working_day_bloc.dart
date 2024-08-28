import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uep/bloc/working_day/working_day_event.dart';
import 'package:uep/bloc/working_day/working_day_state.dart';
import 'package:uep/models/working_day_model.dart';
import 'package:uep/services/working_day_service.dart';

class WorkingDayBloc extends Bloc<WorkingDayEvent, WorkingDayState> {
  final WorkingDayService workingDayService;

  WorkingDayBloc({required this.workingDayService})
      : super(WorkingDayInitial()) {
    on<GetWorkingDays>((event, emit) async {
      emit(WorkingDayLoading());
      try {
        List<WorkingDay>? data = await workingDayService.getWorkingDays();
        if (data != null) {
          emit(WorkingDayLoaded(data));
        } else {
          emit(const WorkingDayError("Foydalanuvchi ma'lumotlari topilmadi"));
        }
      } catch (e) {
        emit(WorkingDayError("Xatolik yuz berdi: $e"));
      }
    });
    on<UpdateWorkingDay>(updateWorkingDay);
  }

  Future<void> updateWorkingDay(
      UpdateWorkingDay event, Emitter<WorkingDayState> emit) async {
    try {
      await workingDayService.updateWorkingDay(event.data);
    } catch (e) {
      emit(WorkingDayError("Xatolik yuz berdi: $e"));
    }
  }
}
