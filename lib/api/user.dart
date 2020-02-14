import 'package:ah_mobile/utilities/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:ah_mobile/models/models.dart';

final String profileUrl = '$baseUrl/profiles';

Future<ProfileData> getProfile(String userId, String token) async {
  final headers = {
    'Content-Type': 'application/json',
    'Authorization': token,
  };

  try {
    final response = await http.get(
      '$profileUrl/$userId',
      headers: headers,
    );

    if (response.statusCode == 200) {
      return ProfileData.fromJson(json.decode(response.body)['profile']);
    } else {
      return null;
    }
  } catch (e) {
    throw Exception('get profile failed');
  }
}
