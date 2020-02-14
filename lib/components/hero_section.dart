// Framework
import 'package:flutter/material.dart';

// Local imports
import 'package:ah_mobile/components/home_screen_cta.dart';
import 'package:ah_mobile/utilities/constants.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Image.asset(
          'images/hero.png',
          scale: 0.5,
        ),
        Container(
          margin: EdgeInsets.only(top: 10.0),
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          color: Color(0xE6FFFFFF),
          height: 40.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MaterialButton(
                child: Icon(
                  Icons.menu,
                  color: kIconColor,
                ),
                padding: EdgeInsets.all(0),
                minWidth: 8,
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
              Text(
                "Authors' Haven",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 20.0,
                  color: Color(0xFF4E4E4E),
                ),
              ),
              Icon(
                Icons.search,
                color: kIconColor,
              )
            ],
          ),
        ),
        Positioned(
          top: 80.0,
          left: 85.0,
          child: HomeScreenCTA(),
        ),
      ],
    );
  }
}
