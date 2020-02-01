import 'package:ah_mobile/actions/auth.dart';
import 'package:redux/redux.dart';
 
class Auth {
  final String email;
  final String token;
  final bool isLoading;
  final dynamic error;

  const Auth({
    this.email = '',
    this.token = '' ,
    this.isLoading = false,
    this.error,
  });

  Auth copyWith({ email, token, isLoading, error }) {
    return Auth(
      email: email ?? this.email,
      token: token ?? this.token,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

Auth _authLoading(Auth store, AuthLoading action) => store.copyWith(isLoading: true);

Auth _authSuccess(Auth store, AuthSuccessful action) => Auth(
  email: action.authData.email,
  token: action.authData.token,
);

Auth _authFailure(Auth store, AuthFailed action) => store.copyWith(
  isLoading: false,
  error: true,
);

final authReducer = combineReducers<Auth>([
  TypedReducer<Auth, AuthLoading>(_authLoading),
  TypedReducer<Auth, AuthSuccessful>(_authSuccess),
  TypedReducer<Auth, AuthFailed>(_authFailure),
]);
