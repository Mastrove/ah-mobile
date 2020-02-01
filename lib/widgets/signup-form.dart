import 'package:ah_mobile/actions/auth.dart';
import 'package:ah_mobile/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:validators/validators.dart' as validator;

typedef OnSaveCallback = void Function(String email, String password);

class _SignUpForm extends StatefulWidget {
  final OnSaveCallback onSave;

  _SignUpForm({
    Key key,
    this.onSave,
  }) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<_SignUpForm> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _email;
  String _password;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Column(
        children: <Widget>[
          Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'email'
                  ),
                  initialValue: '',
                  validator: (val) {
                    return validator.isEmail(val.trim())
                      ? null
                      : 'please enter a valid email';
                  },
                  onSaved: (val) => _email = val,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'password',
                  ),
                  initialValue: '',
                  validator: (val) {
                    return validator.isLength(val.trim(), 6, 16)
                      ? null
                      : 'please enter a valid password';
                  },
                  onSaved: (val) => _password = val,
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: RaisedButton(
              child: Text('Submit'),
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  _formKey.currentState.save();
                  widget.onSave(_email, _password);
                }
              },
            ),
          )
        ],
      ),
    );
  }
}

class _ViewModel {
  final Store<AppState> store;

  _ViewModel(
    this.store,
  );

  save(String email, String password) {
    SignUp signUp = SignUp(email: email, password: password);
    store.dispatch(SignUpAction(signUp));
  }

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(store);
  }
}

class SignUpForm extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      distinct: true,
      converter: _ViewModel.fromStore,
      builder: (context, vm) {
        return _SignUpForm(
          onSave: vm.save,
        );
      },
    );
  }
}
