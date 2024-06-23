
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class SimpleMap extends StatefulWidget {
  @override
  _SimpleMapState createState() => _SimpleMapState();
}

class _SimpleMapState extends State<SimpleMap> {
  static final LatLng center = LatLng(31.947351, 35.227163);
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  MarkerId? selectedMarker;
  int _markerIdCounter = 1;
  LatLng? markerPosition;

  double lang = center.latitude;
  double long = center.longitude;

  static final CameraPosition _kInitialPosition =
      CameraPosition(target: center, zoom: 11.0, tilt: 0, bearing: 0);
  GoogleMapController? _controller;

  Future<void> onMapCreated(GoogleMapController controller) async {
    _controller = controller;
  }

  @override
  Widget build(BuildContext context) {
    final MarkerId? selectedId = selectedMarker;
    return Scaffold(
        floatingActionButton: FloatingActionButton(onPressed: () {
          _currentLocation();
        }),
        appBar: AppBar(
          title: Text('Google Map'),
        ),
        body: Stack(children: <Widget>[
          Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  child: GoogleMap(
                    initialCameraPosition: _kInitialPosition,
                    onMapCreated: onMapCreated,
                    myLocationEnabled: true,
                    markers: Set<Marker>.of(markers.values),
                    trafficEnabled: true,
                    onTap: _handleTap,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    TextButton(
                      onPressed: _add,
                      child: const Text('Add'),
                    ),
                    TextButton(
                      onPressed:
                          selectedId == null ? null : () => _remove(selectedId),
                      child: const Text('Remove'),
                    ),
                  ],
                ),
              ])
        ])
        /* ,*/
        );
  }

  void _currentLocation() async {
    // Create a map controller
    final GoogleMapController controller = await _controller!;
    LocationData? currentLocation;
    var location = new Location();
    try {
      // Find and store your location in a variable
      currentLocation = await location.getLocation();
    } on Exception {
      currentLocation = null;
    }

    // Move the map camera to the found location using the controller
    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        bearing: 0,
        target: LatLng(currentLocation!.latitude!, currentLocation.longitude!),
        zoom: 17.0,
      ),
    ));
  }

  Set<Marker> _createMarker() {
    return {
      Marker(
          markerId: MarkerId("marker_1"),
          position: center,
          infoWindow: InfoWindow(title: 'Marker 1'),
          rotation: 90),
      Marker(
        markerId: MarkerId("marker_2"),
        position: LatLng(18.997962200185533, 72.8379758747611),
      ),
    };
  }

  _handleTap(LatLng point) {
    setState(() {
      lang = point.latitude;
      long = point.longitude;
    });
  }

  void _onMarkerTapped(MarkerId markerId) {
    final Marker? tappedMarker = markers[markerId];
    if (tappedMarker != null) {
      setState(() {
        final MarkerId? previousMarkerId = selectedMarker;
        if (previousMarkerId != null && markers.containsKey(previousMarkerId)) {
          final Marker resetOld = markers[previousMarkerId]!
              .copyWith(iconParam: BitmapDescriptor.defaultMarker);
          markers[previousMarkerId] = resetOld;
        }
        selectedMarker = markerId;
        final Marker newMarker = tappedMarker.copyWith(
          iconParam: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueGreen,
          ),
        );
        markers[markerId] = newMarker;

        markerPosition = null;
      });
    }
  }

  Future<void> _onMarkerDrag(MarkerId markerId, LatLng newPosition) async {
    setState(() {
      markerPosition = newPosition;
    });
  }

  Future<void> _onMarkerDragEnd(MarkerId markerId, LatLng newPosition) async {
    final Marker? tappedMarker = markers[markerId];
    if (tappedMarker != null) {
      setState(() {
        markerPosition = null;
      });
      await showDialog<void>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
                actions: <Widget>[
                  TextButton(
                    child: const Text('OK'),
                    onPressed: () => Navigator.of(context).pop(),
                  )
                ],
                content: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 66),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text('Old position: ${tappedMarker.position}'),
                        Text('New position: $newPosition'),
                      ],
                    )));
          });
    }
  }

  void _add() {
    final int markerCount = markers.length;
    print('markerCount' + markerCount.toString());

    if (markerCount == 12) {
      return;
    }

    final String markerIdVal = 'marker_id_$_markerIdCounter';
    _markerIdCounter++;
    final MarkerId markerId = MarkerId(markerIdVal);

    final Marker marker = Marker(
      markerId: markerId,
      position: LatLng(
        lang,
        long,
      ),
      infoWindow: InfoWindow(title: markerIdVal, snippet: '*'),
      onTap: () => _onMarkerTapped(markerId),
      onDragEnd: (LatLng position) => _onMarkerDragEnd(markerId, position),
      onDrag: (LatLng position) => _onMarkerDrag(markerId, position),
    );

    setState(() {
      markers[markerId] = marker;
    });
  }

  void _remove(MarkerId markerId) {
    setState(() {
      if (markers.containsKey(markerId)) {
        markers.remove(markerId);
      }
    });
  }
}
