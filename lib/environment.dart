import 'package:injectable/injectable.dart';

const notWeb = Environment('notWeb');

abstract class AppEnvironment {
  String get userBaseUrl;
  String get databaseFileName;
}

@Singleton(as: AppEnvironment)
class ProdEnvironment extends AppEnvironment {
  @override
  String get databaseFileName => 'app.db';

  @override
  String get userBaseUrl =>
      'https://620dfdda20ac3a4eedcf5a52.mockapi.io/api/employee';
}
