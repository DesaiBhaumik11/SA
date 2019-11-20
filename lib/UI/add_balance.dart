import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vegetos_flutter/Utils/Const.dart';

class AddBalance extends StatefulWidget {
  @override
  _AddBalanceState createState() => _AddBalanceState();
}

class _AddBalanceState extends State<AddBalance> {
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
            'Add Balance'
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: ListView(
          physics: BouncingScrollPhysics(),
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
                    ),),

                  ],
                ),
              ),
            ),

            SizedBox(height: 15,),


            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(5))
              ),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[

                    TextFormField(
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 17
                      ),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                          color: Colors.black54
                        ),
                        hintText: '₹ Enter Amount',
                      ),
                    ),

                    Divider(color: Colors.grey,),

                    SizedBox(height: 10,),

                    Row(
                      children: <Widget>[
                        Expanded(
                          child: RaisedButton(
                            onPressed: (){},
                            color: Theme.of(context).primaryColor,
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 12),
                              child: Text(
                                'Procced to add balance', style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.w500
                              ),
                              ),
                            ),
                          ),
                        )
                      ],
                    )

                  ],
                ),
              ),
            )

          ],
        ),
      )
    );
  }
}
