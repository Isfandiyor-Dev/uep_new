import 'package:dio/dio.dart';
import 'package:uep/models/subject_model.dart';
import 'package:uep/services/dio/dio_client.dart';

class SubjectService {
  Dio dio = DioClient().dio;

  Future<List<Subject>> getSubjects() async {
    String url = "/api/subjects";
    try {
      final response = await dio.get(url);
      
      return (response.data["data"] as List)
          .map((e) => Subject.fromJson(e))
          .toList();
    } on DioException catch (e) {
      
      throw e.response?.data;
    } catch (e) {
      
      rethrow;
    }
  }

  Future<void> addSubject(Map<String, dynamic> data) async {
    String url = "/api/subjects";
    try {
     await dio.post(url, data: data);
      
    } on DioException catch (e) {
      
      throw e.response?.data;
    } catch (e) {
      
      rethrow;
    }
  }

  Future<Subject> getOneSubject(int id) async {
    String url = "/api/subjects/$id";
    try {
      final response = await dio.get(url);
      
      return response.data["data"];
    } on DioException catch (e) {
      
      throw e.response?.data;
    } catch (e) {
      
      rethrow;
    }
  }

  Future<void> editSubject(int id, Map<String, dynamic> data) async {
    String url = "/api/subjects/$id";
    try {
      await dio.put(url, data: data);
      
    } on DioException catch (e) {
      
      throw e.response?.data;
    } catch (e) {
      
      rethrow;
    }
  }

  Future<void> deleteSubject(int id) async {
    String url = "/api/subjects/$id";
    try {
    await dio.delete(url);
      
    } on DioException catch (e) {
      
      throw e.response?.data;
    } catch (e) {
      
      rethrow;
    }
  }
}
