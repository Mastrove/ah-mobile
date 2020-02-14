// framework imports
import 'package:ah_mobile/models/auth.dart';
import 'package:ah_mobile/screens/auth_screen.dart';
import 'package:ah_mobile/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class _SignUpDrawerHeader extends StatelessWidget {

  const _SignUpDrawerHeader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return DrawerHeader(
      child: Center(
        child: ListView(
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          shrinkWrap: true,
          children: <Widget>[
            OutlineButton(
              borderSide: BorderSide(
                color: kCTAbuttonColor,
                width: 1.4
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
              color: Colors.white,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => AuthScreen(AuthTabs.signIn)
                  )
                );
              },
              child: Text(
                'Sign In',
                style: TextStyle(
                  color: kCTAbuttonColor,
                  fontFamily: 'Poppins',
                  fontSize: 16,
                ),
              ),
            ),
            RaisedButton(
              color: kCTAbuttonColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
              child: Text('Sign Up',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Poppins',
                    fontSize: 16,
                  )),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => AuthScreen(AuthTabs.signUp)
                  )
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SignUpDrawerHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<Auth>(
      builder: (_, model, __) => _SignUpDrawerHeader(),
    );
  }
}

