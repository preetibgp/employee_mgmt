import 'package:json_annotation/json_annotation.dart';

part 'remote_user.g.dart';

@JsonSerializable()
class RemoteUserResponse {
  final List<RemoteUser> results;

  RemoteUserResponse(this.results);

  dynamic toJson() => _$RemoteUserResponseToJson(this);
  factory RemoteUserResponse.fromJson(dynamic json) =>
      _$RemoteUserResponseFromJson(json);
}

@JsonSerializable()
class RemoteUserName {
  final String name;

  RemoteUserName(this.name);

  dynamic toJson() => _$RemoteUserNameToJson(this);
  factory RemoteUserName.fromJson(dynamic json) =>
      _$RemoteUserNameFromJson(json);
}

@JsonSerializable()
class RemoteUserPicture {
  final String avatar;

  RemoteUserPicture(this.avatar);

  dynamic toJson() => _$RemoteUserPictureToJson(this);
  factory RemoteUserPicture.fromJson(dynamic json) =>
      _$RemoteUserPictureFromJson(json);
}

@JsonSerializable()
class RemoteUser {
  @JsonKey(defaultValue: RemoteUserGender.etc)
  final RemoteUserGender gender;
  final String name;
  final String email;
  final String phone;
  final String avatar;
  final String createdAt;

  RemoteUser(this.gender, this.name, this.email, this.phone, this.avatar,
      this.createdAt);

  toJson() => _$RemoteUserToJson(this);
  factory RemoteUser.fromJson(dynamic json) => _$RemoteUserFromJson(json);
}

enum RemoteUserGender { male, female, etc }
