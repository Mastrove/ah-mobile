import 'package:ah_mobile/models/auth.dart';
import 'package:ah_mobile/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

class CustomPopupRoute extends PopupRoute {
  CustomPopupRoute({
    @required this.builder,
    RouteSettings setting,
  }) : super(settings: setting);

  final WidgetBuilder builder;

  @override
  Color get barrierColor => Colors.black45;

  @override
  bool get barrierDismissible => true;

  @override
  String get barrierLabel => null;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return builder(context);
  }

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return RotationTransition(
      turns: animation,
      child: ScaleTransition(
        scale: animation,
        child: child,
      ),
    );
  }

  @override
  Duration get transitionDuration => const Duration(milliseconds: 400);
}

class _SignUpSubmitModal extends StatelessWidget {
  final Auth auth;
  final Key key;

  _SignUpSubmitModal({
    this.auth,
    this.key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String statusText;

    if (auth.loading) {
      statusText = 'signing you up...';
    } else if (auth.isAuthenticated) {
      statusText = 'sign up successful';
    } else {
      statusText = 'sign up failed';
    }
    return Align(
      child: Material(
        type: MaterialType.transparency,
        child: FractionallySizedBox(
          widthFactor: 0.7,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  child: Text(
                    'Yay, you made it!!',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                  child: Text(
                    statusText,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                  child: CircularPercentIndicator(
                    percent: auth.signUpUploadProgress ?? 0,
                    radius: 40,
                    progressColor: auth.isAuthenticated ? Colors.green : auth.hasError ? Colors.red : kCTAbuttonColor,
                    backgroundColor: Colors.transparent,
                    lineWidth: 4,
                    animateFromLastPercent: true,
                    animation: true,
                    circularStrokeCap: CircularStrokeCap.round,
                    center: auth.isAuthenticated ? Icon(Icons.done, color: kCTAbuttonColor) : auth.hasError ? Icon(Icons.close, color: Colors.red) : null,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SignUpSubmitModal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<Auth>(
      builder: (_, auth, __) => _SignUpSubmitModal(auth: auth),
    );
  }
}

class SignUpSubmitModalRoute extends CustomPopupRoute {
  final SignUpData signUpData;
  final RouteSettings setting;

  SignUpSubmitModalRoute({
    this.signUpData,
    this.setting,
  }) : super(
          setting: setting,
          builder: (context) => SignUpSubmitModal(),
        );
}
