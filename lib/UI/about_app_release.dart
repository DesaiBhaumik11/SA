import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:vegetos_flutter/Utils/const.dart';

class AboutAppRelease extends StatefulWidget {
  @override
  _AboutAppReleaseState createState() => _AboutAppReleaseState();
}

class _AboutAppReleaseState extends State<AboutAppRelease> {

  String version="";
  @override
  void initState() {
    // TODO: implement initState
    getVeriosnCode();
    super.initState();
  }

  var text = TextStyle(
      fontWeight: FontWeight.w500, color: Colors.black54, fontSize: 13);

  var title = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEDEDEE),
      appBar: AppBar(
        backgroundColor: Const.appBar,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Image.asset(
              'back.png',
              height: 25,
            ),
          ),
        ),
        title: Text('About App Release'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(3))),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Date: 5 Jun 2019',
                          style: text,
                        ),
                        Text(
                          'Version History: '+version,
                          style: text,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Divider(
                      color: Colors.grey,
                    ),
                    SizedBox(
                      height: 7,
                    ),
//                    Text(
//                      'Promo Codes',
//                      style: title,
//                    ),
                    Text(
                      Const.aboutAppRelease1,
                      style: text,
                    ),
                    SizedBox(
                      height: 20,
                    ),
//                    Text(
//                      'Payment Options',
//                      style: title,
//                    ),
//                    SizedBox(
//                      height: 10,
//                    ),
//                    Text(
//                      Const.aboutAppRelease2,
//                      style: text,
//                    ),
//                    SizedBox(
//                      height: 20,
//                    ),
//                    Text(
//                      'Payment Options',
//                      style: title,
//                    ),
//                    SizedBox(
//                      height: 10,
//                    ),
//                    Text(
//                      Const.aboutAppRelease3,
//                      style: text,
//                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  Future<String> getVeriosnCode() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      version = packageInfo.version;
    });
  }
}
