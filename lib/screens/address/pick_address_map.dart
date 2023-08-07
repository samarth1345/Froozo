import 'package:flutter/material.dart';
import 'package:froozo/controllers/location_controller.dart';
import 'package:froozo/models/address_mode.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PickAddressMap extends StatefulWidget {
  final bool fromSignup;
  final bool fromAddress;
  final GoogleMapController? googleMapController;
  const PickAddressMap(
      {super.key,
      required this.fromAddress,
      required this.fromSignup,
      this.googleMapController});

  @override
  State<PickAddressMap> createState() => _PickAddressMapState();
}

class _PickAddressMapState extends State<PickAddressMap> {
  late LatLng _initialPosition;
  late GoogleMapController _mapController;
  late CameraPosition _cameraPosition;
  @override
  void initState() {
    super.initState();
    if (Get.find<LocationController>().hasAddress()) {
      AddressModel addressModel = Get.find<LocationController>().getCurrModel();
      _cameraPosition = CameraPosition(
          target: LatLng(double.parse(addressModel.latitude),
              double.parse(addressModel.longitude)),
          zoom: 17);
      _initialPosition = LatLng(double.parse(addressModel.latitude),
          double.parse(addressModel.longitude));
    } else {
      _cameraPosition =
          CameraPosition(target: LatLng(32.264339, 75.642113), zoom: 17);
      _initialPosition = LatLng(32.264339, 75.642113);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: SizedBox(
          width: double.maxFinite,
          child: Stack(children: [
            GoogleMap(
              initialCameraPosition:
                  CameraPosition(target: _initialPosition, zoom: 17),
              onCameraMove: (CameraPosition cameraPosition) {
                _cameraPosition = cameraPosition;
              },
              onCameraIdle: () {
                Get.find<LocationController>().updatePosition(_cameraPosition, false);
              },
            )
          ]),
        ),
      )),
    );
  }
}
