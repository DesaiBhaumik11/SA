import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:vegetos_flutter/Animation/slide_route.dart';
import 'package:vegetos_flutter/UI/add_new_address.dart';
import 'package:vegetos_flutter/Utils/Const.dart';

class MyAddresses extends StatefulWidget {
  @override
  _MyAddressesState createState() => _MyAddressesState();
}

class _MyAddressesState extends State<MyAddresses> {

  var address = TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 15,
      color: Color(0xff2d2d2d)
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEDEDEE),
      appBar: AppBar(
        backgroundColor: Color(0xff47870d),
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
            'My Addresses'
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          GestureDetector(
            onTap: (){
              Navigator.push(context, SlideLeftRoute(page: AddNewAddress()));
            },
            child: Container(
              width: double.infinity,
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: <Widget>[

                    Image.asset('current-location.png', height: 20,),

                    SizedBox(
                      width: 10,
                    ),

                    Text('Add new address', style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: Theme.of(context).primaryColor,
                    ),)

                  ],
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 20, left: 15, bottom: 5),
            child: Text(
              'Saved Addresses', style: TextStyle(
                color: Color(0xff2d2d2d),
                fontSize: 13,
                fontWeight: FontWeight.w500
            ),
            ),
          ),

          Expanded(
            child: buildList(context),
          )

        ],
      ),
    );
  }

  Widget _simplePopup() => PopupMenuButton<int>(
    itemBuilder: (context) => [
      PopupMenuItem(
        value: 1,
        child: Text("First"),
      ),
      PopupMenuItem(
        value: 2,
        child: Text("Second"),
      ),
    ],
  );

  ListView buildList(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return InkWell(
          onTap: (){},
          child: Card(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[

                  Row(
                    children: <Widget>[

                      Text('Home', style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),),

                      SizedBox(width: 4,),

                      Image.asset('tick-orange.png', height: 18,),

                      Expanded(
                        flex: 1,
                        child: Container(),
                      ),

                      PopupMenuButton(
                        itemBuilder: (c)=>["Edit", "Delete"].map((i)=>PopupMenuItem(child: ListTile(onTap: (){
                          if(i=="Edit"){

                          }Navigator.pop(context);
                        },title: Text(i),))).toList(),
                        child: Padding(
                          padding: EdgeInsets.only(left: 20, bottom: 15),
                          child: Image.asset('edit-pencil.png', height: 15,),
                        ),
                      ),


                    ],
                  ),

                  SizedBox(
                    height: 10,
                  ),


                  Text('Partho Parekh', style: address,),

                  Text('Shayona Tilak 3, New SG Road, Gota', style: address,),

                  Text('Ahmedabad, Gujarat 38248', style: address,)

                ],
              ),
            ),
          ),
        );
      },
      itemCount: 4,
      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
    );
  }

}
