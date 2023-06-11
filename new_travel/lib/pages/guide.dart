import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geo/geo.dart' as geo;
//import 'package:google_map_polyline/google_map_polyline.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:new_travel/blocs/place_bloc.dart';
import 'package:new_travel/models/colors.dart';
import 'package:new_travel/models/config.dart';

class GuidePage extends StatefulWidget {
  GuidePage({Key? key, this.lat, this.lng, this.placeName, this.zoom})
      : super(key: key);
  final double? lat;
  final double? lng;
  final String? placeName;
  final double? zoom;
  _GuidePageState createState() => _GuidePageState();
}

class _GuidePageState extends State<GuidePage> {
  Completer<GoogleMapController> _controller = Completer();

  List<Marker> _markers = [];

//  int _polylineCount = 1;
  Map<PolylineId, Polyline> polylines = <PolylineId, Polyline>{};

  String? placeName;

  _addMarker() {
    final _pbBloc = Provider.of<PlaceBloc>(context, listen: false);

    setState(() {
      _pbBloc.data.forEach((element) {
        _markers.add(Marker(
            markerId: MarkerId(element['timestamp']),
            position: LatLng(element['latitude'], element['longitude']),
            infoWindow: InfoWindow(title: element['place name']),
            onTap: () {
              setState(() {
                placeName = element['place name'];
              });
            }));
      });
    });
  }

//  void computeDistance() {
//  var p1 = geo.LatLng(data['startpoint lat'], data['startpoint lng']);
//  var p2 = geo.LatLng(data['endpoint lat'], data['endpoint lng']);
//  double _distance = geo.computeDistanceBetween(p1, p2)/1000;
//  setState(() {
//    distance = '${_distance.toStringAsFixed(2)} km';
//  });
//
//}

  //Polyline patterns
  List<List<PatternItem>> patterns = <List<PatternItem>>[
    <PatternItem>[], //line
    <PatternItem>[PatternItem.dash(30.0), PatternItem.gap(20.0)], //dash
    <PatternItem>[PatternItem.dot, PatternItem.gap(10.0)], //dot
    <PatternItem>[
      //dash-dot
      PatternItem.dash(30.0),
      PatternItem.gap(20.0),
      PatternItem.dot,
      PatternItem.gap(20.0)
    ],
  ];

  @override
  void initState() {
    super.initState();
    placeName = widget.placeName;
    _addMarker();
  }

  Widget panelBodyUI(h, w) {
    return Container(
      width: w,
      child: GoogleMap(
        initialCameraPosition: CameraPosition(
            target: LatLng(widget.lat!, widget.lng!),
            zoom: widget.zoom ?? 15,
            tilt: 45,
            bearing: 45),
        mapType: MapType.normal,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: Set.from(_markers),
        polylines: Set<Polyline>.of(polylines.values),
        compassEnabled: false,
        myLocationEnabled: false,
        zoomGesturesEnabled: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return new Scaffold(
        body: Stack(children: <Widget>[
      panelBodyUI(h, w),
      Positioned(
        top: 45,
        left: 10,
        child: Container(
          child: Row(
            children: <Widget>[
              InkWell(
                child: Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: Colors.grey, //Colors.grey[300],
                            blurRadius: 10,
                            offset: Offset(3, 3))
                      ]),
                  child: Icon(Icons.keyboard_backspace),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              SizedBox(
                width: 5,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.80,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.grey, width: 0.5)),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 15, top: 10, bottom: 10, right: 15),
                  child: Text(
                    placeName!,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ]));
  }
}
