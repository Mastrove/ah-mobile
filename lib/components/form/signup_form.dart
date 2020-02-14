import 'package:ah_mobile/models/models.dart';
import 'package:ah_mobile/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'signup_page_1.dart';
import 'signup_page_2.dart';
import 'signup_page_3.dart';

class _SignUpFormRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final page1 = SignUpPage1();
    final page2 = SignUpPage2();
    final page3 = SignUpPage3();

    return Stack(
      alignment: Alignment.topLeft,
      children: <Widget>[
        Navigator(
          initialRoute: 'signup/page1',
          onGenerateRoute: (RouteSettings settings) {
            switch (settings.name) {
              case 'signup/page1':
                return FormRoute(page1, initial: true);
              case 'signup/page2':
                return FormRoute(page2);
              case 'signup/page3':
                return FormRoute(page3);
              // case 'signup/submit':
              //   return SignUpSubmitModalRoute(signUpData: signUpData);
              default:
                return FormRoute(page1);
            }
          },
        ),
        TabBars(),
      ],
    );
  }
}

class TabBars extends StatefulWidget {
  @override
  _TabBarsState createState() => _TabBarsState();
}

class _TabBarsState extends State<TabBars> with SingleTickerProviderStateMixin {
  AnimationController controller;
  int previousPage;
  int currentTab;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(duration: const Duration(milliseconds: 400), vsync: this);
    controller.forward();
  }

  @override
  void didChangeDependencies() {
    currentTab = Provider.of<SignUpData>(context).pageHandler.page;
    super.didChangeDependencies();
  }

  Widget buildTabs(bool selected, bool previousSelected, AnimationController animationController) {
    Animation<Decoration> animation;

    if (selected || previousSelected) {
      animation = DecorationTween(
        begin: BoxDecoration(
          color: selected ? Colors.grey : kCTAbuttonColor,
          borderRadius: BorderRadius.circular(5),
        ),
        end: BoxDecoration(
          color: selected ? kCTAbuttonColor : Colors.grey,
          borderRadius: BorderRadius.circular(5),
        ),
      ).animate(animationController);
    }

    final child = Container(
      width: 30,
      height: 5,
      decoration: BoxDecoration(),
    );

    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: selected || previousSelected
          ? DecoratedBoxTransition(
              decoration: animation,
              child: child,
            )
          : DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(5),
              ),
              child: child,
            ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);

    controller
      ..reset()
      ..forward();
  }

  Widget build(BuildContext context) {
    final tab = Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          for (int i = 1; i <= 3; i++)
            buildTabs(
              i == currentTab,
              i == previousPage,
              controller,
            ),
        ],
      ),
    );

    previousPage = currentTab;

    return tab;
  }
}


class SignUpFormControl {
  final void Function() popForm;

  SignUpFormControl(this.popForm);
}

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> with AutomaticKeepAliveClientMixin<SignUpForm> {
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ChangeNotifierProvider<SignUpData>(
      create: (_) => SignUpData(),
      child: _SignUpFormRoute(),
    );
  }
}

class FormRoute extends PageRouteBuilder {
  final Widget form;

  FormRoute(this.form, {bool initial = false})
      : super(
          transitionDuration: Duration(milliseconds: 300),
          pageBuilder: (context, animation, secondaryAnimation) => form,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            if (initial) {
              return SlideTransition(
                position: Tween<Offset>(
                  begin: Offset.zero,
                  end: Offset(-1, 0),
                ).animate(secondaryAnimation),
                child: child,
              );
            }

            return SlideTransition(
              position: Tween<Offset>(
                begin: Offset(1.0, 0.0),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                curve: Curves.linear,
                parent: animation,
              )),
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: Offset.zero,
                  end: Offset(-1, 0),
                ).animate(secondaryAnimation),
                child: child,
              ),
            );
          },
        );
}
