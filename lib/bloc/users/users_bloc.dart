import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uep/models/user_model.dart';
import 'package:uep/services/users_service.dart';
import 'package:equatable/equatable.dart';

part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final UsersService usersService;

  UsersBloc({required this.usersService}) : super(UsersInitial()) {
    on<GetUsers>((event, emit) async {
      emit(UsersLoading());
      try {
        final data = await usersService.getUsers();
        if (data != null) {
          emit(UsersLoaded(data));
        } else {
          emit(const UsersError("Foydalanuvchi ma'lumotlari topilmadi"));
        }
      } catch (e) {
        emit(UsersError("Xatolik yuz berdi: $e"));
      }
    });
  }
}
