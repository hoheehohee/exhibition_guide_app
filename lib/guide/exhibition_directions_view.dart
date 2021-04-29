import 'package:exhibition_guide_app/commons/custom_default_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';

class ExhivitDirectionsView extends StatelessWidget {
  var mqd;
  var mqw;
  var mqh;
  AppLocalizations _locals;
  BitmapDescriptor _markerIcon;
  Completer<GoogleMapController> _controller = Completer();

  static final point = CameraPosition(
    target: LatLng(35.125163649815526, 129.09232157495816),
    zoom: 15.4746,
  );
  final _kMapCenter = LatLng(35.125163649815526, 129.09232157495816);


  @override
  Widget build(BuildContext context) {

    mqd = MediaQuery.of(context);
    mqw = mqd.size.width;
    mqh = mqd.size.height;

    _locals = AppLocalizations.of(context);

    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(mqd.size.height * 0.07),
            child: CustomDefaultAppbar(title: _locals.main9)
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(bottom: mqh * 0.07),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: mqd.size.width * 0.07, vertical: mqd.size.width * 0.07),
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        addressForm(_locals.map1, _locals.address, 'assets/images/icon/icon-location-map.png'),
                        SizedBox(height: mqw * 0.05,),
                        addressForm(_locals.bk9, _locals.addressPhone, 'assets/images/icon/icon-tel.png'),
                      ],
                    )
                ),
                Center(
                  child: Container(
                    height: mqh * 0.35,
                    width: double.infinity,
                    child:
                    GoogleMap(
                      mapType: MapType.normal,
                      markers: _createMarker(),
                      initialCameraPosition: point,
                      onMapCreated: (GoogleMapController controller) {
                        _controller.complete(controller);
                      },
                      zoomControlsEnabled: true,
                      myLocationButtonEnabled: false,
                      gestureRecognizers: < Factory < OneSequenceGestureRecognizer >> [
                        new Factory < OneSequenceGestureRecognizer > (
                              () => new EagerGestureRecognizer(),
                        ),
                      ].toSet()
                    ),
                  ),
                ),
                Container(
                    margin: EdgeInsets.all(mqw * 0.03),
                    color: Colors.white,
                    width: double.infinity,
                    child: Padding(
                      padding: EdgeInsets.all(mqw * 0.05),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(_locals.map2, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),),
                          SizedBox(height: 15,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                'assets/images/icon/icon-metro.png',
                                width: mqw * 0.06,
                              ),
                              SizedBox(width: mqw * 0.02,),
                              Expanded(child:
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(_locals.map3, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                                  SizedBox(height: mqh * 0.02,),
                                  Text(_locals.map4, style: TextStyle(fontSize: 18),),
                                  SizedBox(height: mqh * 0.02,),
                                  Text(_locals.map5, style: TextStyle(fontSize: 18),),
                                  SizedBox(height: mqh * 0.02,),
                                  Text(_locals.map6, style: TextStyle(fontSize: 18),)
                                ],
                              )
                              )
                            ],
                          ),
                          SizedBox(height: 15,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                'assets/images/icon/icon-bus.png',
                                width: mqw * 0.06,
                              ),
                              SizedBox(width: mqw * 0.02,),
                              Expanded(child:
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(_locals.map7, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                                  SizedBox(height: mqh * 0.02,),
                                  Text(_locals.map8, style: TextStyle(fontSize: 18),),
                                ],
                              )
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                )
              ],
            ),
          ),
        )
    );
  }

  Set<Marker> _createMarker() {
    return <Marker>[
      Marker(
          markerId: MarkerId("marker_1"),
          position: _kMapCenter,
          // icon: _markerIcon,
          // infoWindow: InfoWindow(title: 'I am a marker!')
      ),
    ].toSet();
  }


  Widget addressForm(String title, String subTitle, String iconPath) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          iconPath,
          width: mqw * 0.06,
        ),
        SizedBox(width: mqw * 0.02,),
        Expanded(child:
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
            SizedBox(height: mqh * 0.01,),
            Text(subTitle, style: TextStyle(fontSize: 18),)
          ],
        )
        )
      ],
    );
  }
}