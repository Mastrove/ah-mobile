import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

import 'signup_submit_modal.dart';
import 'package:ah_mobile/models/models.dart';
import 'package:flutter/material.dart';
import 'package:ah_mobile/utilities/utilities.dart';
import 'auth_form_input.dart';
import 'components.dart';

class _SignUpPage3 extends StatelessWidget {
  final Function(SignUpData data) onSubmit;
  static GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  static Fnodes focusNodes = Fnodes();
  final PasswordAuthFormField password;
  final PasswordAuthFormField password2;
  final PageHandler pageHandler;

  _SignUpPage3({
    Key key,
    this.onSubmit,
    this.password,
    this.password2,
    this.pageHandler,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    focusNodes.provideContext(context);
    final signUpData = Provider.of<SignUpData>(context);
    final auth = Provider.of<Auth>(context);
    final user = Provider.of<User>(context);
    bool isFormValid = password.isValid == true && password2.isValid == true;

    return ListView(
      shrinkWrap: true,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(20, 60, 20, 0),
          child: Column(
            children: <Widget>[
              FormTitleBar(
                mainTitle: 'Finally!',
                subTitle: 'secure your accout',
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    AuthFormInput(
                      field: password,
                      padding: EdgeInsets.fromLTRB(5, 30, 5, 10),
                      obscureText: !password.isVisible,
                      textInputAction: TextInputAction.next,
                      focusNode: focusNodes.getNode('password'),
                      label: 'password',
                      prefixIcon: FormInputIcon(
                        field: password,
                        icon: Icons.lock_outline,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          password.isVisible ? Icons.visibility : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                        onPressed: password.toggleVisibility,
                      ),
                      onBlur: password.blur,
                      onChanged: (val) => password.value = val,
                      autofocus: true,
                      onFieldSubmitted: (_) => focusNodes.transferFocus('password', 'password2'),
                    ),
                    AuthFormInput(
                      field: password2,
                      obscureText: !password2.isVisible,
                      textInputAction: TextInputAction.next,
                      focusNode: focusNodes.getNode('password2'),
                      label: 'confirm password',
                      prefixIcon: FormInputIcon(
                        field: password2,
                        icon: Icons.lock,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          password2.isVisible ? Icons.visibility : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                        onPressed: password2.toggleVisibility,
                      ),
                      onBlur: password2.blur,
                      onChanged: (val) => password2.value = val,
                      onFieldSubmitted: (_) => focusNodes.transferFocus('password2'),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FormButton(
                      child: AuthButtonText('Back'),
                      onPressed: () {
                        focusNodes.removeFocus();
                        pageHandler.previous();
                        Navigator.of(context).pop();
                      },
                    ),
                    FormButton(
                      child: AuthButtonText('Submit'),
                      onPressed: isFormValid
                          ? () async {
                              focusNodes.removeFocus();
                              auth.signUp(signUpData);
                              await showDialog(
                                context: context,
                                builder: (_) => SignUpSubmitModal(),
                              );
                              if(auth.isAuthenticated) {
                                Navigator.of(context, rootNavigator: true).pop();
                                user.getProfile(auth.userId, auth.token);
                              }
                            }
                          : null,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class SignUpPage3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Selector<SignUpData, Tuple3<PasswordAuthFormField, PasswordAuthFormField, PageHandler>>(
      selector: (_, data) => Tuple3(data.password, data.password2, data.pageHandler),
      builder: (_, data, __) => _SignUpPage3(
        password: data.item1,
        password2: data.item2,
        pageHandler: data.item3,
      ),
    );
  }
}
