import 'package:dio/dio.dart';
import 'package:uep/models/subject_model.dart';
import 'package:uep/services/dio/dio_client.dart';

class SubjectService {
  Dio dio = DioClient().dio;

  Future<List<Subject>> getSubjects() async {
    String url = "/api/subjects";
    try {
      final response = await dio.get(url);
      print("Subjects Response: $response");
      return (response.data["data"] as List)
          .map((e) => Subject.fromJson(e))
          .toList();
    } on DioException catch (e) {
      print("Error Dio all ${e.response?.data}");
      throw e.response?.data;
    } catch (e) {
      print("Error all $e");
      rethrow;
    }
  }

  Future<void> addSubject(Map<String, dynamic> data) async {
    String url = "/api/subjects";
    try {
      final response = await dio.post(url, data: data);
      print("Add Subject Response: $response");
    } on DioException catch (e) {
      print("Error Dio Add ${e.response?.data}");
      throw e.response?.data;
    } catch (e) {
      print("Error Add $e");
      rethrow;
    }
  }

  Future<Subject> getOneSubject(int id) async {
    String url = "/api/subjects/$id";
    try {
      final response = await dio.get(url);
      print("One Subject Response: $response");
      return response.data["data"];
    } on DioException catch (e) {
      print("Error Dio one ${e.response?.data}");
      throw e.response?.data;
    } catch (e) {
      print("Error one $e");
      rethrow;
    }
  }

  Future<void> editSubject(int id, Map<String, dynamic> data) async {
    String url = "/api/subjects/$id";
    try {
      final response = await dio.put(url, data: data);
      print("Edit Subject Response: $response");
    } on DioException catch (e) {
      print("Error Dio edit ${e.response?.data}");
      throw e.response?.data;
    } catch (e) {
      print("Error edit $e");
      rethrow;
    }
  }

  Future<void> deleteSubject(int id) async {
    String url = "/api/subjects/$id";
    try {
      final response = await dio.delete(url);
      print("Delete Subject Response: $response");
    } on DioException catch (e) {
      print("Error Dio delete ${e.response?.data}");
      throw e.response?.data;
    } catch (e) {
      print("Error delete $e");
      rethrow;
    }
  }
}
