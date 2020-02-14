import 'package:ah_mobile/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:ah_mobile/components/form/signin_form.dart';
import 'package:ah_mobile/components/form/signup_form.dart';

enum AuthTabs {
  signUp,
  signIn,
}
class AuthScreen extends StatefulWidget {
  final int index;

  AuthScreen(AuthTabs tab) : index = tab == AuthTabs.signUp ? 0 : 1;

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> with SingleTickerProviderStateMixin {
  TabController _tabController;
  List tabs;

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void initState() {
    super.initState();
    tabs = ['Sign Up', 'Sign In'];
    _tabController = TabController(
      initialIndex: widget.index,
      length: tabs.length,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Todo: This widget may affect the pages scrolling scrolling
    // replace with ListView

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kCTAbuttonColor,
        title: Text("Author's Haven"),
        bottom: PreferredSizeContainer(
          child: TabBar(
            labelStyle:
                TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w700),
            unselectedLabelStyle: TextStyle(
              fontFamily: 'Poppins',
            ),
            indicatorColor: Colors.white54,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            controller: _tabController,
            tabs: tabs.map((e) => Tab(text: e)).toList(),
          ),
        ),
      ),
      body: TabBarView(
        children: <Widget>[
          SignUpForm(),
          SignInForm(),
        ],
        controller: _tabController,
      ),
    );
  }
}

class PreferredSizeContainer extends StatelessWidget implements PreferredSize {
  final Widget child;

  PreferredSizeContainer({this.child});

  @override
  Size get preferredSize => Size.fromHeight(50);

  @override
  Widget build(BuildContext context) {
    return child;
  }
}

// class SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
//   final Widget child;
//   // final double minHeight;
//   // final double maxHeight;
//   final double height;

//   SliverAppBarDelegate({
//     // @required this.minHeight,
//     // @required this.maxHeight,
//     this.height,
//     @required this.child,
//   });

//   @override
//   double get minExtent => height;
//   @override
//   double get maxExtent => height;
//   @override
//   Widget build(
//       BuildContext context, double shrinkOffset, bool overlapsContent) {
//     return SizedBox.expand(child: child);
//   }

//   @override
//   bool shouldRebuild(SliverAppBarDelegate oldDelegate) {
//     // return maxHeight != oldDelegate.maxHeight ||
//     //     minHeight != oldDelegate.minHeight ||
//     //     child != oldDelegate.child;
//     return false;
//   }
// }

// return CustomScrollView(
//   slivers: <Widget>[
//     SliverPersistentHeader(
//       pinned: true,
//       delegate: SliverAppBarDelegate(
//         height: 50,
//         child: Container(
//           color: Colors.white,
//           child: TabBar(
//             // isScrollable: true,
//             labelStyle: TextStyle(
//                 fontFamily: 'Poppins', fontWeight: FontWeight.w700),
//             unselectedLabelStyle: TextStyle(
//               fontFamily: 'Poppins',
//             ),
//             indicatorColor: Color(0xFF3C3A3A),
//             labelColor: Color(0xFF3C3A3A),
//             unselectedLabelColor: Color(0x8C3C3A3A),
//             controller: _tabController,
//             tabs: tabs.map((e) => Tab(text: e)).toList(),
//           ),
//         ),
//       ),
//     ),
//     SliverList(
//       delegate: SliverChildBuilderDelegate(
//         (_, __) => TabBarView(
//           children: <Widget>[
//             SignUpForm(),
//             SignInForm(),
//           ],
//           controller: _tabController,
//         ),
//         childCount: 1,
//       ),
//     )
//   ],
// );
