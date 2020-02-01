import 'dart:convert';

class SignUp {
  final String email;
  final String password;

  SignUp({ this.email, this.password });

  String toJson() => json.encode({
    'email': email,
    'password': password,
  });
}

class SignIn extends SignUp {
  final String email;
  final String password;

  SignIn({ this.email, this.password });
}

// class Auth {
//   final String email;
//   final String token;

//   const Auth({ this.email, this.token });
// }

class AuthData {
  final String email;
  final String token;

  AuthData({ this.email, this.token });

  AuthData.fromJson(Map<String, dynamic> json)
    : email = json['email'], token = json['token'];
}
