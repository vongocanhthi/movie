import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:android_intent/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:movie/features/api/service.dart';
import 'package:movie/features/model/place.dart';
import 'package:movie/util/constant.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:app_settings/app_settings.dart';

class MapPage extends StatefulWidget {
  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  GoogleMapController _googleMapController;
  String _dropdownValue = "Normal";
  SearchBar _searchBar;
  String _input = "";
  bool _isShowResultAddress = false;
  List<Marker> _allMarker = [];

  List<String> _mapTypeTextList = [
    "None",
    "Normal",
    "Satellite",
    "Terrain",
    "Hybrid"
  ];

  MapType _mapType = MapType.normal;
  List<MapType> _mapTypeList = [
    MapType.none,
    MapType.normal,
    MapType.satellite,
    MapType.terrain,
    MapType.hybrid
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkPermission();

    _allMarker.add(
      Marker(
        markerId: MarkerId("BSP"),
        position: LatLng(10.844198891289125, 106.63532358687642),
        onTap: () {
          print("BSP");
        },
      ),
    );

    _searchBar = SearchBar(
      inBar: false,
      setState: setState,
      onSubmitted: (value) {
        //todo
        _input = value;
        _isShowResultAddress = true;
      },
      onCleared: () {
        print("cleared");
      },
      onClosed: () {
        print("closed");
      },
      hintText: "Search address",
      buildDefaultAppBar: (BuildContext context) {
        return AppBar(
          centerTitle: true,
          backgroundColor: orange_color,
          title: Text("Google Map"),
          actions: [
            // _searchBar.getSearchAction(context),
            // GestureDetector(
            //   onTap: () {
            //     setState(() {
            //       _isShowResultAddress = false;
            //     });
            //   },
            // )
          ],
        );
      },
    );
  }

  void openLocationSetting() async {
    final AndroidIntent intent = new AndroidIntent(
      action: 'android.settings.LOCATION_SOURCE_SETTINGS',
    );
    await intent.launch();
  }

  Future<void> _checkPermission() async {
    final serviceStatus = await Permission.locationWhenInUse.serviceStatus;
    final isGpsOn = serviceStatus == ServiceStatus.enabled;
    if (!isGpsOn) {
      if (Platform.isAndroid) {
        openLocationSetting();
      }
      print('Turn on location services before requesting permission.');
      return;
    }

    final status = await Permission.locationWhenInUse.request();
    if (status == PermissionStatus.granted) {
      Position _position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      _googleMapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(_position.latitude, _position.longitude),
            zoom: 20.0,
          ),
        ),
      );
      print('Permission granted');
    } else if (status == PermissionStatus.denied) {
      print(
          'Permission denied. Show a dialog and again ask for the permission');
    } else if (status == PermissionStatus.permanentlyDenied) {
      print('Take the user to the settings page.');
      // await openAppSettings();
      AppSettings.openAppSettings();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _searchBar.build(context),
      body: Stack(
        children: [
          Column(
            children: [
              Row(children: [
                Text("Select map type: "),
                DropdownButton(
                  value: _dropdownValue,
                  onChanged: (String value) {
                    setState(() {
                      _dropdownValue = value;
                      for (int i = 0; i < _mapTypeTextList.length; i++) {
                        if (_dropdownValue == _mapTypeTextList[i]) {
                          _mapType = _mapTypeList[i];
                        }
                      }
                    });
                  },
                  items: _mapTypeTextList.map<DropdownMenuItem<String>>((text) {
                    return DropdownMenuItem<String>(
                      value: text,
                      child: Text("$text"),
                    );
                  }).toList(),
                )
              ]),
              Expanded(
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(10.844198891289125, 106.63532358687642),
                  ),
                  onMapCreated: (controller) {
                    _googleMapController = controller;
                  },
                  mapType: _mapType,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  rotateGesturesEnabled: false,
                  // scrollGesturesEnabled: false,
                  tiltGesturesEnabled: false,
                  zoomControlsEnabled: false,
                  zoomGesturesEnabled: true,
                  markers: Set.from(_allMarker),
                ),
              ),
              Visibility(
                visible: _isShowResultAddress ? true : false,
                child: FutureBuilder<List<Place>>(
                  future: Service().getPlaceList(_input),
                  builder: (context, snapshot) {
                    List<Place> _placeList = snapshot.data;
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount:
                            _placeList.length > 5 ? 5 : _placeList.length,
                        itemBuilder: (context, index) {
                          return Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                print("${_placeList[index].description}");
                              },
                              child: Container(
                                color: Colors.white,
                                child: ListTile(
                                  title:
                                      Text("${_placeList[index].description}"),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return Center(
                        child: CupertinoActivityIndicator(),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.location_searching),
      //   onPressed: () {
      //     //todo
      //     _checkPermission();
      //   },
      // ),
    );
  }
}
