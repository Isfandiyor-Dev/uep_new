import 'package:dio/dio.dart';
import 'package:uep/models/working_day_model.dart';
import 'package:uep/services/dio/dio_client.dart';

class WorkingDayService {
  Dio dio = DioClient().dio;

  Future<List<WorkingDay>?> getWorkingDays() async {
    String url = "/api/working-hours";
    try {
      final response = await dio.get(url);
      print("Bu get Working day response: $response");
      return (response.data["data"] as List<dynamic>)
          .map((e) => WorkingDay.fromJson(e))
          .toList();
    } on DioException catch (e) {
      print("Get Working Day Dio Exception: $e");
      throw e.response?.data;
    } catch (e) {
      print("Get Working day Error: $e");
      throw e;
    }
  }

  Future<void> updateWorkingDay(List<Map<String, dynamic>> data) async {
    String url = "/api/working-hours";
    try {
      final response = await dio.get(
        url,
        data: {"working_hours": data},
      );
      print("Bu Update Working day response: $response");
    } on DioException catch (e) {
      print("Update Working Day Dio Exception: $e");
      throw e.response?.data;
    } catch (e) {
      print("Update Working day Error: $e");
      throw e;
    }
  }
}
