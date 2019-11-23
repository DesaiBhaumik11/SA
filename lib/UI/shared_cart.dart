import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:vegetos_flutter/Animation/slide_route.dart';
import 'package:vegetos_flutter/Utils/Const.dart';

import 'cart_view.dart';

class SharedCart extends StatefulWidget {
  @override
  _SharedCartState createState() => _SharedCartState();
}

class _SharedCartState extends State<SharedCart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Const.appBar,
        elevation: 0,
        leading: InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Image.asset('back.png', height: 25,),
          ),
        ),

        title: Text(
            'Shared Cart'
        ),
      ),
      body: buildList(context),
    );
  }

  ListView buildList(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return InkWell(
            onTap: (){
              Navigator.push(context, SlideLeftRoute(page: CartView()));
            },
            child: Column(
              children: <Widget>[

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Row(
                    children: <Widget>[

                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[

                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'Parth', style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500
                                ),
                                ),

                                SizedBox(width: 5,),

                                Text(Const.startedCart, style: TextStyle(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15
                                ),),

                              ],
                            ),

                            Text('10/6/2019 10:25 AM', style: TextStyle(
                              color: Colors.black54,
                              fontSize: 15,
                              fontStyle: FontStyle.italic,

                            ),),


                          ],
                        ),
                      ),


                      Icon(Icons.keyboard_arrow_right)


                    ],
                  ),
                ),

                Container(
                  width: double.infinity,
                  height: 1,
                  color: Colors.black12,
                ),

              ],
            )
        );
      },
      itemCount: 15,
      padding: EdgeInsets.fromLTRB(10, 5, 10, 20),
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
    );
  }

}
