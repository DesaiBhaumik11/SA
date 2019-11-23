import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:vegetos_flutter/Animation/slide_route.dart';
import 'package:vegetos_flutter/Utils/const.dart';

import 'add_balance.dart';

class Wallet extends StatefulWidget {
  @override
  _WalletState createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEDEDEE),
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
            'Wallet'
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
        child: Column(
          children: <Widget>[

            Container(
              width: double.infinity,
              height: 110,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                image: DecorationImage(
                  image: AssetImage('wallet-bg.png'),
                  fit: BoxFit.cover
                )
              ),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    Text('₹ 100', style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 25,
                      color: Colors.white
                    ),),

                    Text('available balance', style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w500
                    ),)

                  ],
                ),
              ),
            ),

            SizedBox(height: 12,),


            Row(
              children: <Widget>[
                Expanded(
                  child: RaisedButton(
                    onPressed: (){
                      Navigator.push(context, SlideLeftRoute(page: AddBalance()));
                    },
                    color: Theme.of(context).primaryColor,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 13),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                         Image.asset('add-balance-wallet.png', height: 20,),

                         SizedBox(width: 10,),

                         Text('Add balance', style: TextStyle(
                           color: Colors.white,
                           fontWeight: FontWeight.w500,
                           fontSize: 16
                         ),)
                        ],
                      ),
                    )
                  ),
                )
              ],
            ),

            Padding(
              padding: EdgeInsets.only(top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Recent Transtions', style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  ),
                ],
              ),
            ),


            Expanded(child: buildList(context),)

          ],
        ),
      ),
    );
  }


  ListView buildList(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: (){},
          child: Card(
            child: Column(
              children: <Widget>[

                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 15, right: 10),
                  child: Row(
                    children: <Widget>[
                      Image.asset('purchase-wallet.png', height: 40,),
                      SizedBox(width: 10,),

                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[

                          Text('Top Up', style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15
                          ),),

                          SizedBox(height: 3,),

                          Text('Vegetos wallet', style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 12
                          ),),

                        ],
                      ),

                      Expanded(
                        flex: 1,
                        child: Container(),
                      ),

                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[

                          Text('+ ₹ 6,800', style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).primaryColor
                          ),),

                          Text('From HDFC Debit Card', style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),)

                        ],
                      ),


                    ],
                  ),
                ),

                Divider(color: Colors.grey,),

                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, bottom: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[

                      Text('Date: 5 jun 2019, 11:25',style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                      ),),

                      Text('Txn ID: 123456',style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                      ),)

                    ],
                  ),
                )

              ],
            )
          ),
        );
      },
      itemCount: 4,
      padding: EdgeInsets.fromLTRB(5, 0, 5, 20),
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
    );
  }

}
