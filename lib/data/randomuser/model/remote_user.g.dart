// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteUserResponse _$RemoteUserResponseFromJson(Map<String, dynamic> json) =>
    RemoteUserResponse(
      (json['id'] as List<dynamic>).map((e) => RemoteUser.fromJson(e)).toList(),
    );

Map<String, dynamic> _$RemoteUserResponseToJson(RemoteUserResponse instance) =>
    <String, dynamic>{
      'id': instance.results,
    };

RemoteUserName _$RemoteUserNameFromJson(Map<String, dynamic> json) =>
    RemoteUserName(
      json['name'] as String,
    );

Map<String, dynamic> _$RemoteUserNameToJson(RemoteUserName instance) =>
    <String, dynamic>{
      'name': instance.name,
    };

RemoteUserPicture _$RemoteUserPictureFromJson(Map<String, dynamic> json) =>
    RemoteUserPicture(
      json['avatar'] as String,
      // json['medium'] as String,
      // json['thumbnail'] as String,
    );

Map<String, dynamic> _$RemoteUserPictureToJson(RemoteUserPicture instance) =>
    <String, dynamic>{
      'avatar': instance.avatar,
      // 'medium': instance.medium,
      // 'thumbnail': instance.thumbnail,
    };

RemoteUser _$RemoteUserFromJson(Map<String, dynamic> json) => RemoteUser(
      $enumDecodeNullable(_$RemoteUserGenderEnumMap, json['gender']) ??
          RemoteUserGender.etc,
      json['name'],
      json['email'] as String,
      json['phone'] as String,
      json['avatar'] as String,
      json['createdAt'] as String,
      //  RemoteUserPicture.fromJson(json['avatar']),
    );

Map<String, dynamic> _$RemoteUserToJson(RemoteUser instance) =>
    <String, dynamic>{
      'gender': _$RemoteUserGenderEnumMap[instance.gender],
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'avatar': instance.avatar,
      'createdAt': instance.createdAt,
    };

const _$RemoteUserGenderEnumMap = {
  RemoteUserGender.male: 'male',
  RemoteUserGender.female: 'female',
  RemoteUserGender.etc: 'etc',
};
