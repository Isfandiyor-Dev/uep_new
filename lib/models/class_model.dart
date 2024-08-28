import 'package:uep/models/day_model.dart';
import 'package:uep/models/room_model.dart';

class Class {
  final int id;
  final int groupId;
  final int roomId;
  final int dayId;
  final String startTime;
  final String endTime;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Day day;
  final Room room;

  Class({
    required this.id,
    required this.groupId,
    required this.roomId,
    required this.dayId,
    required this.startTime,
    required this.endTime,
    required this.createdAt,
    required this.updatedAt,
    required this.day,
    required this.room,
  });

  factory Class.fromJson(Map<String, dynamic> json) {
    return Class(
      id: json['id'],
      groupId: json['group_id'],
      roomId: json['room_id'],
      dayId: json['day_id'],
      startTime: json['start_time'],
      endTime: json['end_time'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      day: Day.fromJson(json['day']),
      room: Room.fromJson(json['room']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'group_id': groupId,
      'room_id': roomId,
      'day_id': dayId,
      'start_time': startTime,
      'end_time': endTime,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'day': day.toJson(),
      'room': room.toJson(),
    };
  }
}
