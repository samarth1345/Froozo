import 'dart:convert';

import 'package:froozo/data/api/api_client.dart';
import 'package:froozo/models/address_mode.dart';
import 'package:froozo/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class LocationRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  LocationRepo({required this.apiClient, required this.sharedPreferences});
  Future<Response> getAddressfromGeocode(LatLng latLng) async {
    return await apiClient.getData('${AppConstants.GEOCODE_URI}'
        '?lat=${latLng.latitude}&lng=${latLng.longitude}');
  }

  void addAddress(AddressModel addressModel) async {
    sharedPreferences.setString(
        AppConstants.ADDRESS, jsonEncode(addressModel.toJson()));
    // update();
    print("debug: " + jsonEncode(addressModel.toJson()));
  }

  bool hasAddress() {
    return sharedPreferences.containsKey(AppConstants.ADDRESS);
  }

  AddressModel getAddress() {
    if (sharedPreferences.containsKey(AppConstants.ADDRESS)) {
      return AddressModel.fromJson(
          jsonDecode(sharedPreferences.getString(AppConstants.ADDRESS)!));
    } else {
      return AddressModel(addressType: '');
    }
  }
}
