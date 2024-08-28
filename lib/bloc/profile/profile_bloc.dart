import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uep/bloc/profile/profile_event.dart';
import 'package:uep/bloc/profile/profile_state.dart';
import 'package:uep/models/user_model.dart';
import 'package:uep/services/profile_service.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileService profileService;

  ProfileBloc({required this.profileService}) : super(ProfileInitial()) {
    on<LoadProfile>((event, emit) async {
      emit(ProfileLoading());
      try {
        final data = await profileService.getUser();
        if (data != null) {
          final user = UserModel.fromJson(data['data']);
          emit(ProfileLoaded(user));
        } else {
          emit(const ProfileError("Foydalanuvchi ma'lumotlari topilmadi"));
        }
      } catch (e) {
        emit(ProfileError("Xatolik yuz get profile info berdi: $e"));
      }
    });

    on<EditProfile>(_onEditProfile);
  }

  Future<void> _onEditProfile(
      EditProfile event, Emitter<ProfileState> emit) async {
    try {
      await profileService.updateProfile(event.data, image: event.image);
      add(LoadProfile());
    } catch (e) {
      emit(ProfileError("Xatolik yuz edit profile info berdi: $e"));
    }
  }
}
