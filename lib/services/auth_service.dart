import 'package:dio/dio.dart';
import 'package:uep/services/dio/dio_client.dart';
import 'package:uep/services/local_db/local_db.dart';

class AuthService {
  final DioClient dioClient = DioClient();

  Future<Map<String, dynamic>?> signUp(Map<String, dynamic> newData) async {
    String url = "/api/register";
    try {
      final response = await dioClient.dio.post(url, data: newData);

      
      final token = response.data["data"]["token"];
      if (token != null) {
        await LocalDb.saveToken(token);
      } else {
        throw Exception("Token not found in response");
      }
      return response.data;
    } on DioException catch (e) {
      
      throw e.response?.data["data"];
    }
  }

  Future<Map<String, dynamic>?> signIn(Map<String, dynamic> newData) async {
    String url = "/api/login";
    try {
      final response = await dioClient.dio.post(url, data: newData);

      final token = response.data["data"]["token"];
      if (token != null) {
        await LocalDb.saveToken(token);
      } else {
        throw Exception("Token not found in response");
      }

      return response.data;
    } on DioException catch (e) {
      
      throw e.response?.data["data"];
    }
  }

  Future<void> logout() async {
    String url = '/api/logout';
    try {
      
      final response = await dioClient.dio.post(url);
      
      await LocalDb.deleteToken();
      if (response.statusCode == 200) {
      } else {
        throw Exception('Failed to sign out: ${response.statusCode}');
      }
    } on DioException catch (e) {
      
      throw e.response?.data["data"];
    }
  }

  // Future<void> socialLogin(Map<String, dynamic> data) async {
  //   try {
  //     final response = await dioClient.dio.post(
  //       '/api/social-login',
  //       data: data,
  //     );
  //     
  //     final token = response.data["data"]["token"];
  //     if (token != null) {
  //       await LocalDb.saveToken(token);
  //     } else {
  //       throw Exception("Token not found in response");
  //     }
  //   } on DioException catch (e) {
  //     
  //     throw (e.response?.data);
  //   } catch (e) {
  //     
  //     rethrow;
  //   }
  // }

  // Future<Map<String, dynamic>> fetchGitHubUserProfile(
  //     String accessToken) async {
  //   try {
  //     final response = await Dio().get(
  //       'https://api.github.com/user',
  //       options: Options(
  //         headers: {
  //           'Authorization': 'Bearer $accessToken',
  //         },
  //       ),
  //     );

  //     if (response.statusCode == 200) {
  //       final profile = json.decode(response.data);
  //       Map<String, dynamic> data = {
  //         "name": profile['name'],
  //         "email": profile['email'],
  //       };

  //       
  //       
  //       return data;
  //     } else {
  //       
  //           'GitHub foydalanuvchi ma\'lumotlarini olishda xato: ${response.data}');
  //       throw Exception("Xatolik GitHub orqali kirish Ishlamadi!");
  //     }
  //   } on DioException catch (e) {
  //     
  //     throw e.response?.data;
  //   } catch (e) {
  //     
  //     rethrow;
  //   }
  // }

  Future<bool> isAuthenticated() async {
    return await LocalDb.getIdToken() != null;
  }
}
