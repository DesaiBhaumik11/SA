import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vegetos_flutter/Utils/Const.dart';

class AddNewAddress extends StatefulWidget {
  @override
  _AddNewAddressState createState() => _AddNewAddressState();
}

class _AddNewAddressState extends State<AddNewAddress> {

  int _radioValue1 = -1;

  var text = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 16
  );


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffff),
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
            'Add New Address'
        ),
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[

          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  new Radio(
                    value: 0,
                    activeColor: Const.orange,
                    groupValue: _radioValue1,
                    onChanged: (int e){
                      setState(() {
                        _radioValue1 = e;
                      });
                    },
                  ),
                  new Text(
                    'Mr.',
                    style: text,
                  ),

                  SizedBox(width: 10,),
                  new Radio(
                    value: 1,
                    activeColor: Const.orange,
                    groupValue: _radioValue1,
                    onChanged: (int e){
                      setState(() {
                        _radioValue1 = e;
                      });
                    },
                  ),
                  new Text(
                    'Mrs.',
                    style: text,
                  ),

                  SizedBox(width: 10,),

                  new Radio(
                    value: 2,
                    activeColor: Const.orange,
                    groupValue: _radioValue1,
                    onChanged: (int e){
                      setState(() {
                        _radioValue1 = e;
                      });
                    },
                  ),
                  new Text(
                    'Miss',
                    style: text,
                  ),
                ],
              ),

//              Divider(
//                color: ,
//              )

            ],
          )

        ],
      ),
    );
  }
}
