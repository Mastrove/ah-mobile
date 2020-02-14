// framework imports
import 'package:ah_mobile/models/models.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:basic_utils/basic_utils.dart' as utils;

class _UserDrawer extends StatelessWidget {
  final User user;

  const _UserDrawer({
    Key key,
    @required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (user.isLoading) {
      return Text('getting your profile');
    }

    final signOut = Provider.of<Auth>(context).reset;

    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Container(
              height: 100,
              width: 100,
              margin: EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(50),
                image: DecorationImage(image: NetworkImage(user.image), fit: BoxFit.contain),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '${utils.StringUtils.capitalize(user.firstname)} ${utils.StringUtils.capitalize(user.lastname)}',
                style: TextStyle(color: Colors.black54),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                user.email,
                style: TextStyle(color: Colors.blue[300]),
              ),
            ),
            OutlineButton(
              child: Text('sign out'),
              onPressed: signOut,
            ),
            Divider(
              thickness: 0.5,
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}

class UserDrawerHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer2<Auth, User>(
      builder: (_, auth, user, __) => _UserDrawer(
        user: user,
      ),
    );
  }
}
