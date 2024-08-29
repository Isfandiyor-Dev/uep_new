import 'models.dart';

class Group {
  final int id;
  final String name;
  final int mainTeacherId;
  final int assistantTeacherId;
  final int? subjectId; // subjectId ni nullable qilib belgilaymiz
  final DateTime createdAt;
  final DateTime updatedAt;
  final Teacher mainTeacher;
  final Teacher assistantTeacher;
  final List<Student> students;
  final List<Class> classes;
  final Subject? subject; // subject ni nullable qilib belgilaymiz

  Group({
    required this.id,
    required this.name,
    required this.mainTeacherId,
    required this.assistantTeacherId,
    this.subjectId,
    required this.createdAt,
    required this.updatedAt,
    required this.mainTeacher,
    required this.assistantTeacher,
    required this.students,
    required this.classes,
    this.subject,
  });

  factory Group.fromJson(Map<String, dynamic> json) {
    return Group(
      id: json['id'],
      name: json['name'],
      mainTeacherId: json['main_teacher_id'],
      assistantTeacherId: json['assistant_teacher_id'],
      subjectId: json['subject_id'], // nullable qiymat qabul qilish uchun
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      mainTeacher: Teacher.fromJson(json['main_teacher']),
      assistantTeacher: Teacher.fromJson(json['assistant_teacher']),
      students: (json['students'] as List)
          .map((student) => Student.fromJson(student))
          .toList(),
      classes: (json['classes'] as List)
          .map((classJson) => Class.fromJson(classJson))
          .toList(),
      subject: json['subject'] != null
          ? Subject.fromJson(json['subject'])
          : null, // null bo'lish ehtimolini tekshirish
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'main_teacher_id': mainTeacherId,
      'assistant_teacher_id': assistantTeacherId,
      'subject_id': subjectId,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'main_teacher': mainTeacher.toJson(),
      'assistant_teacher': assistantTeacher.toJson(),
      'students': students.map((student) => student.toJson()).toList(),
      'classes': classes.map((classModel) => classModel.toJson()).toList(),
      'subject': subject?.toJson(), // null bo'lishi mumkin
    };
  }
}
