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
      await LocalDb.getIdToken();

      final response = await dioClient.dio.get(url);

      return response.data;
    } on DioException catch (e) {
      throw e.response?.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> updateProfile(Map<String, dynamic> data, {File? image}) async {
    String url = "/api/profile/update";
    try {
      await LocalDb.getIdToken();

      FormData formData = FormData.fromMap(data);

      if (image != null) {
        String imageUrl = basename(image.path);
        formData.files.add(MapEntry(
          "photo",
          await MultipartFile.fromFile(image.path, filename: "$imageUrl.jpg"),
        ));
      }

      final response = await dioClient.dio.post(url, data: formData);

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on DioException catch (e) {
      throw e.response?.data;
    } catch (e) {
      rethrow;
    }
  }
}
