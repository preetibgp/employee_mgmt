import 'package:dio/dio.dart';
import 'package:employee_app/data/randomuser/model/remote_user.dart';
import 'package:employee_app/domain/model/user_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';

@injectable
class RemoteUserDataSource {
  final Dio _dio;

  RemoteUserDataSource(this._dio);

  Future<List<UserData>> fetchInitialUserList() async {
    var reqResponse = await _dio.get(
      '',
      queryParameters: {
        'id': '',
      },
    );
    var rawResponse = reqResponse.data as List;
    var resultList = (rawResponse as List<dynamic>)
        .map((e) => RemoteUser.fromJson(e))
        .toList();
    return resultList
        .map(
          (e) => UserData(
            resultList.indexOf(e),
            '${e.name}',
            e.email,
            e.phone,
            (resultList.indexOf(e) % 4 == 0)
                ? UserStatus.employee
                : UserStatus.employee,
            e.avatar,
            '${e.createdAt}',
           // e.createdAt,
          ),
        )
        .toList();
  }
}
