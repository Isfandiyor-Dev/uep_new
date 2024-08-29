import 'package:dio/dio.dart';
import 'package:uep/models/user_model.dart';
import 'package:uep/services/dio/dio_client.dart';

class UsersService {
  DioClient dioClient = DioClient();

  Future<List<UserModel>?> getUsers() async {
    String url = "/api/users";

    try {
      final response = await dioClient.dio.get(url);
      
      // Dynamic ro'yxatni Map<String, dynamic> ga o'zgartirish
      List<dynamic> users = response.data["data"];
      return users
          .map((e) => UserModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException {
      
      rethrow;
    } catch (e) {
      
      rethrow;
    }
  }
}
