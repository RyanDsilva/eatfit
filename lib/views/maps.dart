import 'dart:async';

import 'package:eatfit/components/customLoader.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class Maps extends StatefulWidget {
  const Maps({Key key}) : super(key: key);

  @override
  _MapsState createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  Completer<GoogleMapController> _controller = Completer();
  List<LatLng> _latlng = List();
  Set<Marker> _markers = Set();
  Set<Polyline> _polylines = Set();
  LocationData _startLocation;
  LocationData finishLocation;
  Location location = new Location();
  Timer timer;
  bool isLoading = true;
  bool isRunning = true;

  @override
  void initState() {
    super.initState();
    this.getStartPos();
    timer = Timer.periodic(
      Duration(seconds: 3),
      (Timer t) => this.getCurrentPos(),
    );
  }

  void getStartPos() async {
    LocationData start = await location.getLocation();
    setState(() {
      this._startLocation = start;
      this._markers.add(
            Marker(
              markerId: MarkerId(start.toString()),
              position: LatLng(start.latitude, start.longitude),
            ),
          );
      this.isLoading = false;
    });
  }

  void getCurrentPos() async {
    LocationData curr = await location.getLocation();
    setState(() {
      this._latlng.add(LatLng(curr.latitude, curr.longitude));
      if (this._polylines.isEmpty) {
        this._polylines.add(
              Polyline(
                  color: Theme.of(context).primaryColor,
                  polylineId: PolylineId('runroute'),
                  points: this._latlng),
            );
      } else {
        this._polylines.clear();
        this._polylines.add(
              Polyline(
                color: Theme.of(context).primaryColor,
                polylineId: PolylineId('runroute'),
                points: this._latlng,
              ),
            );
      }
    });
  }

  void completeRun() async {
    LocationData end = await location.getLocation();
    setState(() {
      this.finishLocation = end;
      this._markers.add(
            Marker(
              markerId: MarkerId(end.toString()),
              position: LatLng(end.latitude, end.longitude),
            ),
          );
      this.isRunning = false;
    });
    timer?.cancel();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: !isLoading
            ? Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  GoogleMap(
                    mapToolbarEnabled: true,
                    zoomGesturesEnabled: true,
                    polylines: _polylines,
                    markers: _markers,
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                    myLocationEnabled: true,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(this._startLocation.latitude,
                          this._startLocation.longitude),
                      zoom: 16.0,
                    ),
                    mapType: MapType.normal,
                  ),
                  isRunning
                      ? Padding(
                          padding: const EdgeInsets.all(20),
                          child: FloatingActionButton(
                            onPressed: () => this.completeRun(),
                            child: Icon(
                              Icons.cancel,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(20),
                          child: FloatingActionButton(
                            onPressed: () => print('Start New!'),
                            child: Icon(
                              Icons.directions_run,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                ],
              )
            : CustomLoader(),
      ),
    );
  }
}
