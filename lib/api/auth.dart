import 'package:ah_mobile/api/routes.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:ah_mobile/models/models.dart';

final String authUrl = '$baseUrl/users';

Future<AuthData> signUp(SignUp data) async {
  final headers = {
    'Content-Type': 'application/json'
  };

  final response = await http.post(
    '$authUrl/signup',
    headers: headers,
    body: data.toJson(),
  );

  if (response.statusCode == 200) {
    return AuthData.fromJson(json.decode(response.body));
  } else {
    throw Exception('sign up failed');
  }
}

Future<AuthData> signIn(SignIn data) async {
  final headers = {
    'Content-Type': 'application/json'
  };

  final response = await http.post(
    '$authUrl/signin',
    headers: headers,
    body: data.toJson(),
  );

  if (response.statusCode == 200) {
    return AuthData.fromJson(json.decode(response.body));
  } else {
    throw Exception('sign in failed');
  }
}
