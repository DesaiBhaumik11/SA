import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:vegetos_flutter/Utils/Const.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class LocateMap extends StatefulWidget {
  @override
  _LocateMapState createState() => _LocateMapState();
}

class _LocateMapState extends State<LocateMap> {

  var text = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

  Set<Marker> markers = Set();

  bool singleCard = false;

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  GoogleMapController _controller;

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
            'Locate on map'
        ),
      ),
      body: Stack(
        children: <Widget>[

          GoogleMap(
            mapType: MapType.normal,
            markers: markers,
            onTap: onMapTap,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              _controller = (controller);
            },
          ),


          Column(
            children: <Widget>[

              Padding(
                padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
                child: TextFormField(
                  style: text,
                  initialValue: 'Sheetalnath Apartment,Pladi',
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(top: 13),
                    prefixIcon: Icon(Icons.search),
                    filled: true,
                    fillColor: Colors.white,
                    border: InputBorder.none
                  ),
                ),
              ),

              Expanded(
                flex: 1,
                child: Container(),
              ),


              Container(
                width: double.infinity,
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(15, 25, 15, 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[

                      Row(
                        children: <Widget>[

                          Image.asset('locate-on-map.png', height: 20,),

                          SizedBox(width: 7,),

                          Text('Place pin on your location', style: text,)

                        ],
                      ),

                      SizedBox(height: 5,),

                      Row(
                        children: <Widget>[
                          Expanded(
                            child: RaisedButton(
                              onPressed: (){
//                                Navigator.push(context, SlideLeftRoute(page: LocateMap()));
                              },
                              color: Theme.of(context).primaryColor,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  'Save Address', style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),


                    ],
                  ),
                ),
              )

            ],
          )

        ],
      ),
    );
  }

  void onMapTap(LatLng argument) {
    _createMarkerImageFromAsset("locate-on-map.png").then((b) {
      setState(() {
        markers.add(Marker(
            markerId: MarkerId('value'),
            icon: b,
            position: argument,
            onTap: () {
              setState(() {
                singleCard = !singleCard;
              });
            }));
        //
      });
    });
  }

  Future<BitmapDescriptor> _createMarkerImageFromAsset(String iconPath) async {
    ImageConfiguration configuration = ImageConfiguration();
    var bitmapImage =
    await BitmapDescriptor.fromAssetImage(configuration, iconPath);
    return bitmapImage;
  }

}
