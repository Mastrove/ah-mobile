import 'package:ah_mobile/utilities/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:ah_mobile/models/models.dart';
import 'file_upload.dart';

final String authUrl = '$baseUrl/users';

typedef void OnUploadProgressCallback(int sent, int total);

Future<AuthData> signUp(SignUp data, OnUploadProgressCallback callback) async {
  final headers = {'Content-Type': 'application/json'};
  try {
    if (data.displayPicture != null) {
      data.image = await fileUpload(
        file: data.displayPicture,
        folderPath: 'authors_haven/profile_pictures',
        onUploadProgress: callback,
      );
    }

    if (data.image == null) {
      callback(1, 1);
    }

    final response = await http.post(
      '$authUrl/signup',
      headers: headers,
      body: data.toJson(),
    );

    if (response.statusCode == 201) {
      return AuthData.fromJson(json.decode(response.body));
    } else {
      throw Exception('sign up failed');
    }
  } catch (e) {
    throw Exception('sign up failed');
  }
}

Future<AuthData> signIn(SignIn data) async {
  final headers = {'Content-Type': 'application/json'};

  try {
    final response = await http.post(
      '$authUrl/login',
      headers: headers,
      body: data.toJson(),
    );

    if (response.statusCode == 200) {
      return AuthData.fromJson(json.decode(response.body)['user']);
    } else {
      throw Exception('sign in failed');
    }
  } catch (e) {
    print(e);
    throw Exception('sign in failed');
  }
}
