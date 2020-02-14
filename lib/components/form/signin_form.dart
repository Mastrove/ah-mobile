import 'package:ah_mobile/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:ah_mobile/utilities/focus_nodes.dart';
import 'auth_form_input.dart';
import 'components.dart';

typedef OnSaveCallback = void Function(String email, String password);

class _SignInForm extends StatelessWidget {
  static GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  static Fnodes focusNodes = Fnodes();

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context);
    final user = Provider.of<User>(context);
    final signInData = Provider.of<SignInData>(context);
    final email = signInData.email;
    final password = signInData.password;

    return Padding(
      padding: EdgeInsets.fromLTRB(20, 60, 20, 0),
      child: ListView(
        children: <Widget>[
          Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                FormTitleBar(
                  mainTitle: 'Hey!',
                  subTitle: 'Nice to have you back',
                ),
                AuthFormInput(
                  field: email,
                  padding: EdgeInsets.fromLTRB(5, 30, 5, 10),
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  focusNode: focusNodes.getNode('email'),
                  prefixIcon: FormInputIcon(
                    field: email,
                    icon: Icons.email,
                  ),
                  label: 'email',
                  onBlur: email.blur,
                  onChanged: (val) => email.value = val,
                  autofocus: true,
                  onFieldSubmitted: (_) => focusNodes.transferFocus('email', 'password'),
                ),
                AuthFormInput(
                  field: password,
                  textInputAction: TextInputAction.next,
                  focusNode: focusNodes.getNode('password'),
                  obscureText: !password.isVisible,
                  prefixIcon: FormInputIcon(
                    field: password,
                    icon: Icons.lock,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      password.isVisible ? Icons.visibility : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                    onPressed: password.toggleVisibility,
                  ),
                  label: 'password',
                  onBlur: password.blur,
                  onChanged: (val) => password.value = val,
                  onFieldSubmitted: (_) => focusNodes.transferFocus('password'),
                ),
              ],
            ),
          ),
          Center(
            child: FormButton(
              child: auth.loading
                  ? SizedBox(
                      height: 27,
                      width: 27,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        strokeWidth: 2,
                      ),
                    )
                  : AuthButtonText('Submit'),
              onPressed: () async {
                focusNodes.removeFocus();
                await auth.signIn(signInData);
                if (auth.hasError) {
                  showDialog<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Icon(Icons.close),
                            Text(
                              'Sign up failed',
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      );
                    },
                  );
                } else if (auth.isAuthenticated) {
                  user.getProfile(auth.userId, auth.token);
                  Navigator.of(context).pop();
                }
              },
            ),
          )
        ],
      ),
    );
  }
}

class SignInForm extends StatefulWidget {
  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> with AutomaticKeepAliveClientMixin<SignInForm> {
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ChangeNotifierProvider<SignInData>(
      create: (_) => SignInData(),
      child: _SignInForm(),
    );
  }
}
