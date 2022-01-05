
import 'dart:async';


import 'generated/l10n.dart';
import 'util/ConstantData.dart';
import 'util/ConstantWidget.dart';
import 'model/Message.dart';
import 'util/SizeConfig.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import 'ChatScreen.dart';
import 'OrderTrackingPage.dart';


class OrderTrackMap extends StatefulWidget {
  @override
  _OrderTrackMap createState() => _OrderTrackMap();
}

class _OrderTrackMap extends State<OrderTrackMap> {
  GoogleMapController controller;
  // static LatLng _initialPosition;


  Completer _controller = Completer();
  Map<MarkerId, Marker> markers = {};
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(40.65626416491372, -73.77300777115664),
    zoom: 13.0,
  );
  List listMarkerIds = [];

  BitmapDescriptor customIcon1;

  createMarker(context) {

    if (customIcon1 == null) {

      ImageConfiguration configuration = createLocalImageConfiguration(context);


      BitmapDescriptor.fromAssetImage(configuration, ConstantData.assetsPath+'food-delivery.png')

          .then((icon) {

        setState(() {

          customIcon1 = icon;

        });

      });

    }
  }





  // void _getUserLocation() async {
  //
  //
  //   await Geolocator.getCurrentPosition().then((value)  {
  //   print("getlatlong==${value.latitude}--${value.longitude}");
  //   _initialPosition =       LatLng(40.91163687464769+30, -74.52864461445306+30);
  //
  //
  //   });
  //
  //   // Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  //   // print("getlatlong11==${geolocator.forceAndroidLocationManager}");
  //   //
  //   // geolocator
  //   //     .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
  //   //     .then((position) {
  //   //   setState(() {
  //
  //
  //       // print("getlatlong==${position.latitude}--${position.longitude}");
  //     // });
  //   // });
  // }

  @override
  void initState() {
    // _add();

    // _determinePosition();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    createMarker(context);
    PolylineId polylineId = PolylineId("area");
    double bottomHeight = SizeConfig.safeBlockVertical * 20;
    double bottomImageHeight = ConstantWidget.getPercentSize(bottomHeight, 50);
    return WillPopScope(
        child: Scaffold(
          backgroundColor: ConstantData.viewColor,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                finish();
              },
              icon: Icon(
                Icons.keyboard_backspace_outlined,
                color: ConstantData.mainTextColor,
              ),
            ),
            backgroundColor: ConstantData.bgColor,
            title: ConstantWidget.getAppBarText(S.of(context).trackOrder),
          ),
          body: Container(

            width: double.infinity,
            height: double.infinity,
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  // child: GoogleMap(
                  //   onMapCreated: _onMapCreated,
                  //   myLocationEnabled: true,
                  //   // consumeTapEvents: true,
                  //   myLocationButtonEnabled: false,
                  //
                  //   zoomGesturesEnabled: true,
                  //   // mapType: MapType.none,
                  //   rotateGesturesEnabled: false,
                  //   scrollGesturesEnabled: true,
                  //   tiltGesturesEnabled: false,
                  //   // myLocationEnabled: true,
                  //   initialCameraPosition: CameraPosition(
                  //     // target: LatLng(21.2089, 72.8907),
                  //     target:       LatLng(40.91163687464769+30, -74.52864461445306+30),
                  //
                  //     // target: LatLng(21.2117, 72.8858),
                  //
                  //     zoom: 7,
                  //   ),
                  //
                  //   markers: Set<Marker>.of(<Marker>[
                  //     Marker(
                  //         markerId: MarkerId("Ey"),
                  //         position: (_initialPosition != null)
                  //             ? _initialPosition
                  //             : LatLng(0, 0),
                  //         visible: true,
                  //         flat: false,
                  //         infoWindow: InfoWindow(
                  //           title: "Estimated Time",
                  //           snippet: "5-10 min",
                  //         )),
                  //   ]),
                  //   polylines: Set<Polyline>.of(<Polyline>[
                  //     Polyline(
                  //         polylineId: polylineId,
                  //         points: getPoints(),
                  //         width: 5,
                  //         color: Colors.green,
                  //
                  //         visible: true),
                  //     Polyline(
                  //         polylineId: polylineId2,
                  //         points: getPoint2(),
                  //         width: 5,
                  //         color: Colors.grey,
                  //
                  //         visible: true)
                  //   ]),
                  //   polygons: Set<Polygon>.of(<Polygon>[
                  //     Polygon(
                  //         polygonId: PolygonId('area'),
                  //         points: getPoints(),
                  //         strokeColor: Colors.pink,
                  //         strokeWidth: 5,
                  //         fillColor: Colors.transparent,
                  //
                  //         visible: true),
                  //   ]),
                  // ),
                    child: GoogleMap(
                      initialCameraPosition: _kGooglePlex,
                      onTap: (_) {},
                      markers: Set.of(markers.values),
                      polylines: Set<Polyline>.of(<Polyline>[
                        Polyline(
                            polylineId: polylineId,
                            points: getPoints(),
                            width: 5,
                            color: Colors.green,
                            visible: true),
                      ]),


                      onMapCreated: (GoogleMapController controler) {
                        print("complete-----true");
                        _controller.complete(controler);

                        MarkerId markerId1 = MarkerId("1");
                        MarkerId markerId2 = MarkerId("2");

                        listMarkerIds.add(markerId1);
                        listMarkerIds.add(markerId2);

                        Marker marker1 = Marker(
                            markerId: markerId1,
                            position:
                            LatLng(40.65626416491372, -73.77300777115664),
                            icon:customIcon1
                          // LatLng(21.214571209464843, 72.88491829958917),
                        );

                        Marker marker2 = Marker(
                          markerId: markerId2,
                          position:
                          LatLng(40.65214565261112, -73.8060743777546),

                          // LatLng(21.21103054325307, 72.89371594512971),
                        );

                        setState(() {
                          markers[markerId1] = marker1;
                          markers[markerId2] = marker2;


                        });
                      },
                    )
                ),
                Container(
                  width: double.infinity,
                  height: SizeConfig.safeBlockVertical * 20,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40)),
                      color: ConstantData.bgColor),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ConstantWidget.getHorizonSpace(SizeConfig.safeBlockHorizontal * 4),
                      ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(
                            ConstantWidget.getPercentSize(bottomImageHeight, 12))),
                        child: Image.asset(
                          ConstantData.assetsPath + "hugh.png",
                          fit: BoxFit.cover,
                          width: bottomImageHeight,
                          height: bottomImageHeight,
                        ),
                      ),
                      ConstantWidget.getHorizonSpace(SizeConfig.safeBlockHorizontal * 1.5),
                      Expanded(
                          child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => OrderTrackingPage(),
                          ));
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ConstantWidget.getCustomText(
                                "James King",
                                ConstantData.mainTextColor,
                                1,
                                TextAlign.start,
                                FontWeight.w500,
                                ConstantWidget.getPercentSize(bottomHeight, 15)),
                            Row(
                              children: [
                                Icon(
                                  Icons.check_circle,
                                  color: ConstantData.accentColor,
                                  size: ConstantWidget.getPercentSize(
                                      bottomHeight, 15),
                                ),
                                ConstantWidget.getHorizonSpace(
                                    SizeConfig.safeBlockHorizontal * 1.2),
                                ConstantWidget.getCustomText(
                                    "ID 2445556",
                                    Colors.grey,
                                    1,
                                    TextAlign.start,
                                    FontWeight.normal,
                                    ConstantWidget.getPercentSize(bottomHeight, 12))
                              ],
                            )
                          ],
                        ),
                      )),
                      IconButton(
                          icon: Icon(
                            Icons.call,
                            color: ConstantData.accentColor,
                            size: ConstantWidget.getPercentSize(bottomHeight, 20),
                          ),
                          onPressed: () {
                            _callNumber();
                          }),
                      IconButton(
                          icon: Icon(
                            CupertinoIcons.chat_bubble_text_fill,
                            color: ConstantData.accentColor,
                            size: ConstantWidget.getPercentSize(bottomHeight, 20),
                          ),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(builder:(context) => ChatScreen(user:chats[0].sender),));

                          }),
                      ConstantWidget.getHorizonSpace(SizeConfig.safeBlockHorizontal * 4),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        onWillPop: () async {
          finish();
          return false;
        });
  }
  void _callNumber() async {
    String s="89898989";
    // launch("tel:"+s);
    // launch("tel://"+s);
    String url = "tel:"+s;
      await launch(url);

  }

  getPoints() {   return [
    LatLng(40.65626416491372, -73.77300777115664),
    // LatLng(21.214571209464843, 72.88491829958917),
    LatLng(40.65214565261112, -73.8060743777546),
    // LatLng(21.21103054325307, 72.89371594512971),
  ];   return [
    LatLng(40.65626416491372, -73.77300777115664),
    // LatLng(21.214571209464843, 72.88491829958917),
    LatLng(40.65214565261112, -73.8060743777546),
    // LatLng(21.21103054325307, 72.89371594512971),
  ];
    // return [
    //   LatLng(40.91163687464769, -74.52864461445306),
    //   // LatLng(21.2117 - 15, 72.8858 - 15),
    //   LatLng(40.91163687464769+30, -74.52864461445306+30),
    // ];
  }

  getPoint2() {
    return [
      // LatLng(21.2089, 72.8907),
      // LatLng(21.2089 + 20, 72.8907 + 20),


      LatLng(40.91163687464769+30, -74.52864461445306+30),
      LatLng(40.91163687464769 + 50, -74.52864461445306 + 50),

      // LatLng(21.2084, 72.8990),
    ];
  }

  void finish() {
    Navigator.of(context).pop();
  }
}
