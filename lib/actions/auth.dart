import 'package:ah_mobile/models/models.dart';

class AuthLoading {}

class AuthFailed {}

class AuthSuccessful {
  AuthData authData;

  AuthSuccessful(this.authData);
}

class SignUpAction {
  final SignUp signUp;

  SignUpAction(this.signUp);
}

class SignInAction {
  final SignIn signIn;

  SignInAction(this.signIn);
}
