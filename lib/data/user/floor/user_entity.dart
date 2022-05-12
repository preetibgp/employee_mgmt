import 'package:employee_app/domain/model/user_data.dart';
import 'package:floor/floor.dart';

@entity
class UserEntity {
  @PrimaryKey(autoGenerate: false)
  final int id;
  final String name;
  final String phone;
  final String email;
  final UserStatus status;
  final String avatarUrl;
  final String createdAt;

  UserEntity(this.id, this.name, this.phone, this.email, this.status,
      this.avatarUrl, this.createdAt);

  UserData toUserData() {
    return UserData(id, name, email, phone, status, avatarUrl, createdAt);
  }

  factory UserEntity.fromUserData(UserData data) {
    return UserEntity(data.id, data.name, data.phone, data.email, data.status,
        data.avatarUrl, data.createdAt);
  }
}
