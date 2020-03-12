import 'package:flutter/material.dart';

import 'const.dart';

class CommonWidget {
  Widget buildNickAddress(BuildContext context, String nickAddress) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 3, right: 3, top: 10),
          child: GestureDetector(
            child: Container(
              decoration: BoxDecoration(
                  color: Const.widgetGreen,
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: Center(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: Text(
                    nickAddress,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Color(0xffffffff),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
