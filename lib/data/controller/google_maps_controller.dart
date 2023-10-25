import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
//import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
//import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
//import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddressController extends GetxController implements GetxService {
  double? latitude;
  double? longitude;
  late TextEditingController controller;
  //final Completer<GoogleMapController> mapController = Completer();
  List<dynamic> currentPlaceList = [];
  //List<Location>? currentLocation = [];

  String? _address;
  String? get address => _address;
  String sessionTOKEN = '1223344';

  updateAddress(String value) {
    _address = value;
    update();
  }

  // Future<Position> getcurrentLocation() async {
  //   await Geolocator.requestPermission().then((value) {});
  //   return Geolocator.getCurrentPosition();
  // }

  getSuggestion(String query) async {
    String kplacesApiKey = 'AIzaSyDSsTtjvdKipkgZ4s0zYp2tMRVQlAfHsKA';
    String baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request =
        '$baseURL?input=$query&key=$kplacesApiKey&sessiontoken=$sessionTOKEN';
    var response = await http.get(Uri.parse(request));
    log(response.body);
    try {
      if (response.statusCode == 200) {
        log('here i am');
        currentPlaceList = jsonDecode(response.body.toString())['predictions'];
        log(currentPlaceList.toString());
        update();
      } else {
        log('some error');
      }
    } catch (e) {
      log(e.toString());
    }
  }

  void onQueryChanged(String query) {
    getSuggestion(query);
    update();
  }

  //List<Marker> markers = [];

  @override
  void onInit() {
    controller = TextEditingController();
    // getcurrentLocation().then((value) {
    //   latitude = value.latitude;
    //   longitude = value.longitude;
    //   log('latitude: $latitude , longitude $longitude');
    // });
    super.onInit();
  }

  static AddressController get i => Get.put(AddressController());
}
