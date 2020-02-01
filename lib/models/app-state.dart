import 'package:ah_mobile/reducers/auth.dart';

class AppState {
  final Auth auth;

  AppState({
    this.auth = const Auth(),
  });
}
