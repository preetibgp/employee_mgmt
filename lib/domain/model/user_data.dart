import 'package:equatable/equatable.dart';
import 'package:flutter/rendering.dart';

enum UserStatus { employee }

class UserData extends Equatable {
  final int id;
  final String name;
  final String email;
  final String phone;
  final UserStatus status;
  final String avatarUrl;
  final String createdAt;

  UserData(this.id, this.name, this.email, this.phone, this.status,
      this.avatarUrl, this.createdAt);

  @override
  List<Object?> get props =>
      [id, name, email, phone, status, avatarUrl, createdAt];
}
