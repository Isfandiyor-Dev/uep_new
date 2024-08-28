import 'package:dio/dio.dart';
import 'package:uep/models/group_model.dart';
import 'package:uep/services/dio/dio_client.dart';

class GroupService {
  final Dio dio = DioClient().dio;

  Future<List<Group>?> getGroups() async {
    String url = "/api/groups";
    try {
      final response = await dio.get(url);
      print("Bu response: $response");
      List<dynamic> data = response.data["data"];
      return data
          .map((e) => Group.fromJson((e as Map<String, dynamic>)))
          .toList();
    } on DioException catch (e) {
      print("Group get dio Error: ${e.response?.data}");
      rethrow;
    } catch (e) {
      print("Groups get Error: $e");
      rethrow;
    }
  }

  Future<List<Group>?> getStudentGroups() async {
    String url = "/api/student/groups";
    try {
      final response = await dio.get(url);
      print("Bu response: $response");
      List<dynamic> data = response.data["data"];
      return data
          .map((e) => Group.fromJson((e as Map<String, dynamic>)))
          .toList();
    } on DioException catch (e) {
      print("Group get dio Error: ${e.response?.data}");
      rethrow;
    } catch (e) {
      print("Groups get Error: $e");
      rethrow;
    }
  }

  Future<void> addGroup(Map<String, dynamic> data) async {
    String url = "/api/groups";
    try {
      final response = await dio.post(url, data: data);
      print("Bu add group response: $response");
    } on DioException catch (e) {
      print("Group add dio Error: ${e.response?.data}");
      rethrow;
    } catch (e) {
      print("Groups add Error: $e");
      rethrow;
    }
  }
}
