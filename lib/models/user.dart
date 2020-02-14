import 'package:flutter/material.dart';
import 'package:ah_mobile/api/user.dart' as api;

class User extends ChangeNotifier {
  String firstname;
  String lastname;
  String email;
  String image;
  String username;
  String bio;
  bool isVerified;
  bool _isLoading = false;

  set isLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  bool get isLoading => _isLoading;

  Future<void> getProfile(String userId, String token) async {
    try {
      isLoading = true;
      final data = await api.getProfile(userId, token);
      email = data.email;
      firstname = data.firstname;
      lastname = data.lastname;
      bio = data.bio;
      username = data.username;
      image = data.image;
      isVerified = data.isVerified;
    } catch (e) {} finally {
      isLoading = false;
    }
  }
}

class ProfileData {
  final String firstname;
  final String lastname;
  final String email;
  final String image;
  final String username;
  final String bio;
  final bool isVerified;

  ProfileData({
    this.firstname,
    this.lastname,
    this.email,
    this.image,
    this.username,
    this.bio,
    this.isVerified,
  });

  ProfileData.fromJson(Map<String, dynamic> json)
      : email = json['email'],
        firstname = json['firstname'],
        lastname = json['lastname'],
        bio = json['bio'],
        image = json['image'],
        username = json['username'],
        isVerified = json['isVerified'];
}
