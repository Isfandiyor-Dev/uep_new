import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path/path.dart';
import 'package:uep/services/dio/dio_client.dart';
import 'package:uep/services/local_db/local_db.dart';

class ProfileService {
  DioClient dioClient = DioClient();

  Future<Map<String, dynamic>?> getUser() async {
    String url = "/api/user";
    try {
      final token = await LocalDb.getIdToken();
      print("Bu token: $token");
      final response = await dioClient.dio.get(url);

      return response.data;
    } on DioException catch (e) {
      print("Dio Xatoligi: ${e.response?.data}");
      throw e.response?.data;
    } catch (e) {
      print("Get Userda Xatolik: $e");
      rethrow;
    }
  }

  Future<bool> updateProfile(Map<String, dynamic> data, {File? image}) async {
    String url = "/api/profile/update";
    try {
      final token = await LocalDb.getIdToken();
      print("Bu token: $token");

      FormData formData = FormData.fromMap(data);

      if (image != null) {
        String imageUrl = basename(image.path);
        formData.files.add(MapEntry(
          "photo",
          await MultipartFile.fromFile(image.path, filename: "$imageUrl.jpg"),
        ));
        print("Image path: ${image.path}");
      }

      print("Bu data: $data");

      final response = await dioClient.dio.post(url, data: formData);

      print("Bu response update: ${response.data}");

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on DioException catch (e) {
      print("Update'da Dio Xatoligi: ${e.response?.data}");
      throw e.response?.data;
    } catch (e) {
      print("Update'da Xatolik: $e");
      rethrow;
    }
  }
}
