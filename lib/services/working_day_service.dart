import 'package:dio/dio.dart';
import 'package:uep/models/working_day_model.dart';
import 'package:uep/services/dio/dio_client.dart';

class WorkingDayService {
  Dio dio = DioClient().dio;

  Future<List<WorkingDay>?> getWorkingDays() async {
    String url = "/api/working-hours";
    try {
      final response = await dio.get(url);
      
      return (response.data["data"] as List<dynamic>)
          .map((e) => WorkingDay.fromJson(e))
          .toList();
    } on DioException catch (e) {
      
      throw e.response?.data;
    } catch (e) {
      
      rethrow;
    }
  }

  Future<void> updateWorkingDay(List<Map<String, dynamic>> data) async {
    String url = "/api/working-hours";
    try {
       await dio.get(
        url,
        data: {"working_hours": data},
      );
      
    } on DioException catch (e) {
      
      throw e.response?.data;
    } catch (e) {
      
      rethrow;
    }
  }
}
