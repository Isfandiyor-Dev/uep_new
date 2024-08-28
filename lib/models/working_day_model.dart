import 'package:uep/models/day_model.dart';

class WorkingDay {
  final int id;
  final int dayId;
  final bool isWorkingDay;
  final String? openingTime;
  final String? closingTime;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Day day;

  WorkingDay({
    required this.id,
    required this.dayId,
    required this.isWorkingDay,
    this.openingTime,
    this.closingTime,
    this.createdAt,
    this.updatedAt,
    required this.day,
  });

  factory WorkingDay.fromJson(Map<String, dynamic> json) {
    return WorkingDay(
      id: json['id'],
      dayId: json['day_id'],
      isWorkingDay: json['is_working_day'],
      openingTime: json['opening_time'],
      closingTime: json['closing_time'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
      day: Day.fromJson(json['day']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'day_id': dayId,
      'is_working_day': isWorkingDay,
      'opening_time': openingTime,
      'closing_time': closingTime,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'day': day.toJson(),
    };
  }
}
