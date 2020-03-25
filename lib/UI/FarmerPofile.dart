import 'package:flutter/material.dart';
import 'package:vegetos_flutter/Utils/const.dart';
import 'package:vegetos_flutter/models/Manufacturer_model.dart';

class FarmerProfile extends StatefulWidget {
  @override
  _FarmerProfileState createState() => _FarmerProfileState();
}

class _FarmerProfileState extends State<FarmerProfile> {

  ManufacturerFarmer manufacturerFarmer =  ManufacturerFarmer();

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Image.asset(
              'assets/OkAssets/LeftSideArrow.png',
              height: 25,
            ),
          ),
        ),
        title: Text(
          "Manufacturer",
          style: TextStyle(color: Const.textBlack),
        ),
      ),
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: 20, right:30),
            height: 150,
            width: 150,
            child: Stack(
              children: <Widget>[
                Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blueGrey[900],
                      image: DecorationImage(
                          image: NetworkImage(
                              "https://us.123rf.com/450wm/adsniks/adsniks1807/adsniks180700027/105287783-indian-farmer-holding-crop-plant-in-his-wheat-field.jpg?ver=6"
                          )
                      )
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    height: 45,
                    width: 45,
                    child: InkWell(
                      onTap: () {

                      },
                      child: Card(
                        elevation: 2,
                        color: Const.iconOrange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: Icon(
                          Icons.camera_enhance,
                          color: Colors.white,
                        )
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
            SizedBox(height: 20,),
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: 10, right: 10, top: 15,bottom: 5),
                child: Text("Name",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 17
                  ),
                )
            ),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10, top: 0 ,bottom: 0),
              padding: EdgeInsets.only(left: 10, right: 0, top: 3 ,bottom: 3),
              alignment: Alignment.centerLeft,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(3)),
                border: Border.all(color: Const.menuIconGrey,width: 0.5, style: BorderStyle.solid),
                color: Colors.white,
              ),
              child: Text("Ramjibhai Desai",
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14
                ),
              ),
            ),
            Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(left: 10, right: 10, top: 15,bottom: 5),
                child: Text("Address",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 17
                  ),
                )
            ),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10, top: 0 ,bottom: 0),
              padding: EdgeInsets.only(left: 10, right: 0, top: 3 ,bottom: 3),
              alignment: Alignment.centerLeft,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(3)),
                border: Border.all(color: Const.menuIconGrey,width: 0.5, style: BorderStyle.solid),
                color: Colors.white,
              ),
              child: Text("Moti Marad, Tq-Dhoraji, Dt-Rajkot",
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14
                ),
              ),
            ),
            Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(left: 10, right: 10, top: 15,bottom: 5),
                child: Text("Contect",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 17
                  ),
                )
            ),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10, top: 0 ,bottom: 0),
              padding: EdgeInsets.only(left: 10, right: 0, top: 3 ,bottom: 3),
              alignment: Alignment.centerLeft,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(3)),
                border: Border.all(color: Const.menuIconGrey,width: 0.5, style: BorderStyle.solid),
                color: Colors.white,
              ),
              child: Text("8758567982",
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14
                ),
              ),
            ),
            Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(left: 10, right: 10, top: 15,bottom: 5),
                child: Text("Email",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 17
                  ),
                )
            ),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10, top: 0 ,bottom: 0),
              padding: EdgeInsets.only(left: 10, right: 0, top: 3 ,bottom: 3),
              alignment: Alignment.centerLeft,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(3)),
                border: Border.all(color: Const.menuIconGrey,width: 0.5, style: BorderStyle.solid),
                color: Colors.white,
              ),
              child: Text("natu@yahoo.in",
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
