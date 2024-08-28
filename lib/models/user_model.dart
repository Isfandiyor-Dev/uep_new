import 'package:uep/models/role_model.dart';

class UserModel {
  final int id;
  final String name;
  final String? email;
  final String? phone;
  final String? photo;
  final DateTime? emailVerifiedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int roleId;
  final Role role;

  UserModel({
    required this.id,
    required this.name,
    this.email,
    required this.phone,
    this.photo,
    this.emailVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.roleId,
    required this.role,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      photo: json['photo'],
      emailVerifiedAt: json['email_verified_at'] != null
          ? DateTime.parse(json['email_verified_at'])
          : null,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      roleId: json['role_id'],
      role: Role.fromJson(json['role']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'photo': photo,
      'email_verified_at': emailVerifiedAt?.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'role_id': roleId,
      'role': role.toJson(),
    };
  }
}
