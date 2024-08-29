import 'package:dio/dio.dart';
import 'package:uep/models/group_model.dart';
import 'package:uep/services/dio/dio_client.dart';

class GroupService {
  final Dio dio = DioClient().dio;

  Future<List<Group>?> getGroups() async {
    String url = "/api/groups";
    try {
      final response = await dio.get(url);

      List<dynamic> data = response.data["data"];
      return data
          .map((e) => Group.fromJson((e as Map<String, dynamic>)))
          .toList();
    } on DioException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Group>?> getStudentGroups() async {
    String url = "/api/student/groups";
    try {
      final response = await dio.get(url);

      List<dynamic> data = response.data["data"];
      return data
          .map((e) => Group.fromJson((e as Map<String, dynamic>)))
          .toList();
    } on DioException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addGroup(Map<String, dynamic> data) async {
    String url = "/api/groups";
    try {
      await dio.post(url, data: data);
    } on DioException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addStudentToGroup(
      {required int groupId, required List<int> studentsId}) async {
    String url = '/api/groups/$groupId/students';
    try {
      final response = await dio.post(url, data: {
        "students": studentsId,
      });

      print("Response add students to group: $response");
    } on DioException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
