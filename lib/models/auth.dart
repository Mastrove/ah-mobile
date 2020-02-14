import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:ah_mobile/api/auth.dart' as api;
import 'package:ah_mobile/utilities/utilities.dart';

class Auth extends ChangeNotifier {
  String email = '';
  String token = '';
  String userId = '';
  bool _loading = false;
  bool hasError = false;
  bool isAuthenticated = false;
  dynamic error;
  double signUpUploadProgress;

  get loading => _loading;

  void signUp(SignUpData data) async {
    try {
      reset();
      _loading = true;
      notifyListeners();
      final authData = await api.signUp(
        SignUp.fromSignUpData(data),
        this.signUpUploadProgressCallback,
      );
      email = authData.email;
      token = authData.token;
      userId = authData.userId;
      isAuthenticated = true;
    } catch (e) {
      hasError = true;
      error = e;
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  signIn(SignInData data) async {
    try {
      reset();
      _loading = true;
      notifyListeners();
      final authData = await api.signIn(SignIn(data.email.value, data.password.value));
      email = authData.email;
      token = authData.token;
      userId = authData.userId;
      isAuthenticated = true;
    } catch (e) {
      hasError = true;
      error = e;
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  void signUpUploadProgressCallback(int sent, int total) {
    this.signUpUploadProgress = sent / total;
    notifyListeners();
  }

  void reset() {
    email = '';
    token = '';
    _loading = false;
    hasError = false;
    isAuthenticated = false;
    signUpUploadProgress = 0;
    notifyListeners();
  }
}

class AuthData {
  final String email;
  final String token;
  final String userId;

  AuthData({this.email, this.token, this.userId});

  AuthData.fromJson(Map<String, dynamic> json)
      : email = json['email'],
        token = json['token'],
        userId = json['id'];
}

class SignUp {
  final String fristname;
  final String lastname;
  final String email;
  final String password;
  final String bio;
  final String username;
  final File displayPicture;
  String image;

  SignUp({
    @required this.fristname,
    @required this.lastname,
    @required this.email,
    @required this.password,
    @required this.bio,
    @required this.username,
    @required this.displayPicture,
  });

  static SignUp fromSignUpData(SignUpData data) => SignUp(
        fristname: data.firstname.value,
        lastname: data.lastname.value,
        email: data.email.value,
        password: data.password.value,
        bio: data.bio.value,
        username: data.username.value,
        displayPicture: data.profilePic.file,
      );

  String toJson() => json.encode(
        {
          'firstname': fristname,
          'lastname': lastname,
          'email': email,
          'password': password,
          'username': username,
          'bio': bio,
          'image': image,
        },
      );
}

class SignIn {
  final String email;
  final String password;

  SignIn(this.email, this.password);

  String toJson() => json.encode({
        'email': email,
        'password': password,
      });
}

class AuthFormField {
  String _value;
  bool isValid;
  bool isTouched;
  String validationError;
  final String Function(String val) validator;
  final void Function() changeHandler;

  AuthFormField({
    String value,
    @required this.validator,
    this.isValid = false,
    this.isTouched = false,
    this.validationError,
    this.changeHandler,
  }) {
    this._value = value ?? '';
    validate();
  }

  void validate() {
    if (_value == null) return;
    validationError = validator(_value);
    isValid = validationError == null;
  }

  set value(String val) {
    _value = val;
    notify();
  }

  String get value => _value;

  void blur() {
    this.isTouched = true;
    notify();
  }

  void notify() {
    if (changeHandler != null) changeHandler();
  }

  AuthFormField copy() => AuthFormField(
        validator: validator,
        validationError: validationError,
        isTouched: isTouched,
        value: _value,
        isValid: isValid,
        changeHandler: changeHandler,
      );
}

class PasswordAuthFormField extends AuthFormField {
  String _value;
  final String Function(String val) validator;
  bool isVisible;
  final void Function() changeHandler;

  PasswordAuthFormField({
    String value,
    @required this.validator,
    String validationError,
    bool isTouched = false,
    bool isValid,
    this.isVisible = false,
    this.changeHandler,
  }) : super(
          value: value,
          validator: validator,
          isTouched: isTouched,
          isValid: isValid,
          validationError: validationError,
          changeHandler: changeHandler,
        );

  void toggleVisibility() {
    isVisible = !isVisible;
    super.notify();
  }

  PasswordAuthFormField copy() => PasswordAuthFormField(
        validator: validator,
        validationError: validationError,
        isTouched: isTouched,
        value: _value,
        isValid: isValid,
        isVisible: isVisible,
        changeHandler: changeHandler,
      );
}

class FileFormField {
  File _file;
  final void Function() changeHandler;

  FileFormField({
    file,
    this.changeHandler,
  }) {
    _file = file;
  }

  set file(File val) {
    _file = val;
    if (changeHandler != null) changeHandler();
  }

  File get file => _file;

  FileFormField copy() => FileFormField(
        file: file,
        changeHandler: changeHandler,
      );
}

class PageHandler {
  int _page;
  final void Function() changeHandler;

  PageHandler({
    page,
    this.changeHandler,
  }) {
    _page = page;
  }

  int get page => _page;

  void next() {
    _page++;
    changeHandler();
  }

  void previous() {
    _page--;
    changeHandler();
  }

  PageHandler copy() => PageHandler(
        changeHandler: changeHandler,
        page: _page,
      );
}

class SignUpData extends ChangeNotifier {
  AuthFormField email;
  AuthFormField firstname;
  AuthFormField lastname;
  PasswordAuthFormField password;
  PasswordAuthFormField password2;
  AuthFormField bio;
  AuthFormField username;
  FileFormField profilePic;
  PageHandler pageHandler;

  SignUpData() {
    email = AuthFormField(
      validator: (val) => Validator(val).email('enter a valid email').validate(),
      changeHandler: () {
        email = email?.copy();
        notifyListeners();
      },
    );
    firstname = AuthFormField(
      validator: (val) => Validator(val).isLenght(6, 19, 'enter a valid first name').validate(),
      changeHandler: () {
        firstname = firstname?.copy();
        notifyListeners();
      },
    );
    lastname = AuthFormField(
      validator: (val) => Validator(val).isLenght(2, 19, 'enter a valid last name').validate(),
      changeHandler: () {
        lastname = lastname?.copy();
        notifyListeners();
      },
    );
    password = PasswordAuthFormField(
      validator: (val) => Validator(val).isLenght(6, 19, 'enter a valid password').validate(),
      changeHandler: () {
        password = password?.copy();
        password2 = password2.copy();
        notifyListeners();
      },
    );
    password2 = PasswordAuthFormField(
      validator: (val) => Validator(val).isLenght(2, 100, 'enter a valid password').equals(password.value, 'passwords do not match').validate(),
      changeHandler: () {
        password2 = password2?.copy();
        notifyListeners();
      },
    );
    bio = AuthFormField(
      validator: (val) => Validator(val).isLenght(2, 100, 'enter a valid bio').validate(),
      changeHandler: () {
        bio = bio?.copy();
        notifyListeners();
      },
    );
    username = AuthFormField(
      validator: (val) => Validator(val).isLenght(6, 19, 'enter a valid username').validate(),
      changeHandler: () {
        username = username?.copy();
        notifyListeners();
      },
    );
    profilePic = FileFormField(
      file: null,
      changeHandler: () {
        profilePic = profilePic?.copy();
        notifyListeners();
      },
    );
    pageHandler = PageHandler(
      page: 1,
      changeHandler: () {
        pageHandler = pageHandler?.copy();
        notifyListeners();
      },
    );
  }
}

class SignInData extends ChangeNotifier{
  AuthFormField email;
  PasswordAuthFormField password;

  SignInData() {
    email = AuthFormField(
      validator: (val) => Validator(val).email('enter a valid email').validate(),
      changeHandler: () {
        email = email?.copy();
        notifyListeners();
      },
    );
    password = PasswordAuthFormField(
      validator: (val) => Validator(val).isLenght(6, 19, 'enter a valid password').validate(),
      changeHandler: () {
        password = password?.copy();
        notifyListeners();
      },
    );
  }
}
