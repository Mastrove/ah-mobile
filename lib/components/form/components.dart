import 'package:ah_mobile/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class FormTitleBar extends StatelessWidget {
  FormTitleBar({
    this.mainTitle,
    this.subTitle,
  });

  final String mainTitle;
  final String subTitle;

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
      child: Column(
        children: <Widget>[
          Text(
            mainTitle,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            subTitle,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }
}

class FormButton extends StatelessWidget {
  final void Function() onPressed;
  final Widget child;

  const FormButton({
    Key key,
    @required this.onPressed,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      height: 75,
      width: 160,
      child: RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        color: kCTAbuttonColor,
        child: child,
        onPressed: onPressed,
      ),
    );
  }
}

class AuthButtonText extends StatelessWidget {
  const AuthButtonText(this.content, {Key key}) : super(key: key);

  final String content;

  @override
  Widget build(BuildContext context) {
    return Text(
      content,
      style: TextStyle(
        color: Colors.white,
        fontFamily: 'Poppins',
        fontSize: 18.0,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
