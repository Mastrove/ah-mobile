// Framework imports
import 'package:flutter/material.dart';

// Local imports
import 'package:ah_mobile/utilities/constants.dart';

class HomeScreenCTA extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Text(
            'GREAT AUTHORS',
            style: kHeroTextStyle,
          ),
          Text(
            'GREAT ARTICLES',
            style: kHeroTextStyle,
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
            color: kIconColor,
            height: 1.0,
            width: 230.0,
          ),
          Text(
            '... Platform for the Creative At Heart',
            style: TextStyle(
              fontFamily: 'Poppins',
              color: Color(0xE6000000),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: RaisedButton(
              child: Text(
                "Join Authors' Haven",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Poppins',
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              color: kCTAbuttonColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0),
              ),
              onPressed: () {},
            ),
          )
        ],
      ),
    );
  }
}
