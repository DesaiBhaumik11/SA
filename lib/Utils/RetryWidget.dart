import 'package:flutter/material.dart';

class RetryWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return RetryWidgetState();
  }
}

  class RetryWidgetState extends State<RetryWidget>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return somethingWentWrong();
  }

  Widget somethingWentWrong() {
    return InkWell(
      onTap: () {
        //1 == Best Selling
        //2 == Vegetos Exclusive
        //3 == Recommended
      },
      child: Container(
        height: 275.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.error, color: Colors.red, size: 25.0,),
            Container(
              margin: EdgeInsets.fromLTRB(10.0, 10.0, 5.0, 5.0),
              child: Text("Items not loaded",
                  style: TextStyle(fontSize: 15.0, fontFamily: 'GoogleSans',
                      fontWeight: FontWeight.w700,
                      color: Colors.black)),
            ),
          ],
        ),
      ),
    );
  }
}

