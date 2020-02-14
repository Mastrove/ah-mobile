import 'package:ah_mobile/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ah_mobile/utilities/utilities.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';
import 'auth_form_input.dart';
import 'components.dart';

class _SignUpPage1 extends StatelessWidget {
  final AuthFormField firstname;
  final AuthFormField lastname;
  final AuthFormField email;
  final PageHandler pageHandler;
  static GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  static Fnodes focusNodes = Fnodes();

  _SignUpPage1({
    Key key,
    this.firstname,
    this.lastname,
    this.email,
    this.pageHandler,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    focusNodes.provideContext(context);

    bool isFormValid = firstname.isValid == true && lastname.isValid == true && email.isValid;

    return ListView(
      shrinkWrap: true,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(20, 60, 20, 0),
          child: Column(
            children: <Widget>[
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    FormTitleBar(
                      mainTitle: 'Hello!',
                      subTitle: 'Hey there! the basics first',
                    ),
                    AuthFormInput(
                      field: firstname,
                      padding: EdgeInsets.fromLTRB(5, 30, 5, 10),
                      textInputAction: TextInputAction.next,
                      focusNode: focusNodes.getNode('firstname'),
                      prefixIcon: FormInputIcon(
                        field: firstname,
                        icon: Icons.person_outline,
                      ),
                      label: 'first name',
                      onBlur: firstname.blur,
                      onChanged: (val) => firstname.value = val,
                      autofocus: true,
                      onFieldSubmitted: (_) => focusNodes.transferFocus('firstname', 'lastname'),
                    ),
                    AuthFormInput(
                      field: lastname,
                      textInputAction: TextInputAction.next,
                      focusNode: focusNodes.getNode('lastname'),
                      prefixIcon: FormInputIcon(
                        field: lastname,
                        icon: Icons.person_outline,
                      ),
                      label: 'last name',
                      onBlur: lastname.blur,
                      onChanged: (val) => lastname.value = val,
                      onFieldSubmitted: (_) => focusNodes.transferFocus('lastname', 'email'),
                    ),
                    AuthFormInput(
                      field: email,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.emailAddress,
                      focusNode: focusNodes.getNode('email'),
                      prefixIcon: FormInputIcon(
                        field: email,
                        icon: Icons.email,
                      ),
                      label: 'email',
                      onBlur: email.blur,
                      onChanged: (val) => email.value = val,
                      onFieldSubmitted: (_) => focusNodes.transferFocus('email'),
                    ),
                  ],
                ),
              ),
              FormButton(
                child: AuthButtonText('Next'),
                onPressed: isFormValid ? () {
                  focusNodes.removeFocus();
                  pageHandler.next();
                  Navigator.of(context).pushNamed('signup/page2');
                } : null,
              )
            ],
          ),
        ),
      ],
    );
  }
}

class SignUpPage1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Selector<SignUpData, Tuple4<AuthFormField, AuthFormField, AuthFormField, PageHandler>>(
      selector: (_, data) => Tuple4(data.firstname, data.lastname, data.email, data.pageHandler),
      builder: (_, data, __) => _SignUpPage1(
        firstname: data.item1,
        lastname: data.item2,
        email: data.item3,
        pageHandler: data.item4,
      ),
    );
  }
}
