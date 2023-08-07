import 'package:flutter/material.dart';
import 'package:froozo/controllers/location_controller.dart';
import 'package:froozo/models/address_mode.dart';
import 'package:froozo/screens/address/pick_address_map.dart';
import 'package:froozo/screens/home/home_page.dart';
import 'package:froozo/utils/colors.dart';
import 'package:froozo/utils/dimensions.dart';
import 'package:froozo/widgets/app_text_field.dart';
import 'package:froozo/widgets/big_text.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({super.key});

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  TextEditingController _addressController = TextEditingController();
  final TextEditingController _contactPersonName = TextEditingController();
  final TextEditingController _contactPersonNumber = TextEditingController();
  late bool _isLogged;
  CameraPosition _cameraPosition =
      CameraPosition(target: LatLng(32.264339, 75.642113), zoom: 17);
  late LatLng _initialPosition = LatLng(32.264339, 75.642113);

  @override
  void initState() {
    super.initState();
    if (Get.find<LocationController>().addressList.isNotEmpty) {
      _cameraPosition = CameraPosition(
          target: LatLng(
        double.parse(Get.find<LocationController>().getAddress["latitude"]),
        double.parse(Get.find<LocationController>().getAddress["longitude"]),
      ));
      _initialPosition = LatLng(
        double.parse(Get.find<LocationController>().getAddress["latitude"]),
        double.parse(Get.find<LocationController>().getAddress["longitude"]),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
              child: Text(
            "Address Page",
            style: TextStyle(color: Colors.white),
          )),
          backgroundColor: AppColors.mainColor,
        ),
        body: GetBuilder<LocationController>(builder: (locationController) {
          _addressController.text = '${locationController.placemark.name ?? ''}'
              '${locationController.placemark.locality ?? ''}'
              '${locationController.placemark.postalCode ?? ''}'
              '${locationController.placemark.country ?? ''}';
          _contactPersonName.text = "Samarth";
          _contactPersonNumber.text = "+91 7508524105";
          return Padding(
            padding: EdgeInsets.only(
                left: Dimensions.width10, right: Dimensions.heigt10),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: Dimensions.heigt70 * 2,
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(
                        left: Dimensions.width5,
                        right: Dimensions.width5,
                        top: Dimensions.height5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.radius5),
                        border: Border.all(
                            width: Dimensions.width3,
                            color: Theme.of(context).primaryColor)),
                    child: Stack(children: [
                      GoogleMap(
                        onTap: (latLng) {
                          Get.to(PickAddressMap(
                            fromAddress: true,
                            fromSignup: false,
                            googleMapController:
                                locationController.mapController,
                          ));
                        },
                        initialCameraPosition:
                            CameraPosition(target: _initialPosition, zoom: 17),
                        zoomControlsEnabled: false,
                        compassEnabled: false,
                        indoorViewEnabled: true,
                        mapToolbarEnabled: false,
                        onCameraIdle: () {
                          locationController.updatePosition(
                              _cameraPosition, true);
                        },
                        onCameraMove: (position) {
                          _cameraPosition = position;
                        },
                        onMapCreated: (GoogleMapController controller) {
                          locationController.setMapController(controller);
                        },
                      )
                    ]),
                  ),
                  SizedBox(
                    height: Dimensions.heigt20,
                  ),
                  SizedBox(
                    height: Dimensions.heigt40,
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: locationController.addressTypeList.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                              onTap: () {
                                locationController.setAddressTypeIndex(index);
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: Dimensions.heigt10,
                                    vertical: Dimensions.heigt10),
                                margin:
                                    EdgeInsets.only(right: Dimensions.width10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.radius5),
                                    color: Theme.of(context).cardColor,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey,
                                          spreadRadius: 1,
                                          blurRadius: 5)
                                    ]),
                                child: Icon(
                                  index == 0
                                      ? Icons.home_filled
                                      : index == 1
                                          ? Icons.work
                                          : Icons.location_on,
                                  color: locationController.addressTypeIndex ==
                                          index
                                      ? AppColors.mainColor
                                      : Theme.of(context).disabledColor,
                                  // size: Dimensions.icon24 * 2,
                                ),
                              ));
                        }),
                  ),
                  SizedBox(
                    height: Dimensions.heigt20,
                  ),
                  BigText(text: "Delivery Address"),
                  SizedBox(
                    height: Dimensions.heigt20,
                  ),
                  AppTextField(
                      controller: _addressController,
                      hintText: "Your delivery address",
                      icon: Icons.map,
                      iconColor: Colors.amberAccent),
                  SizedBox(
                    height: Dimensions.heigt20,
                  ),
                  BigText(text: "Person Name"),
                  SizedBox(
                    height: Dimensions.heigt20,
                  ),
                  AppTextField(
                      controller: _contactPersonName,
                      hintText: "Your name",
                      icon: Icons.map,
                      iconColor: Colors.amberAccent),
                  SizedBox(
                    height: Dimensions.heigt20,
                  ),
                  BigText(text: "Phone number"),
                  SizedBox(
                    height: Dimensions.heigt20,
                  ),
                  AppTextField(
                      controller: _contactPersonNumber,
                      hintText: "Your phone number",
                      icon: Icons.map,
                      iconColor: Colors.amberAccent),
                ],
              ),
            ),
          );
        }),
        bottomNavigationBar:
            GetBuilder<LocationController>(builder: (locationController) {
          return Container(
            height: Dimensions.bottomHeightBar,
            padding: EdgeInsets.only(
                top: Dimensions.heigt20,
                bottom: Dimensions.heigt20,
                left: Dimensions.width20,
                right: Dimensions.width20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.radius20 * 2),
                  topRight: Radius.circular(Dimensions.radius20 * 2),
                ),
                color: AppColors.buttonBackgroundColor),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              GestureDetector(
                onTap: () {
                  AddressModel _addressModel = AddressModel(
                      addressType: locationController
                          .addressTypeList[locationController.addressTypeIndex],
                      contactPersonName: _contactPersonName.text,
                      contactPersonNumber: _contactPersonNumber.text,
                      address: _addressController.text,
                      latitude: locationController.position.latitude.toString(),
                      longitude:
                          locationController.position.longitude.toString());
                  locationController.addAddress(_addressModel);
                  Get.to(HomePage());
                },
                child: Container(
                  padding: EdgeInsets.only(
                      top: Dimensions.heigt20,
                      bottom: Dimensions.heigt20,
                      left: Dimensions.width20,
                      right: Dimensions.width20),
                  child: BigText(
                    text: " Save Address ",
                    color: Colors.white,
                    size: Dimensions.font20,
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      color: AppColors.mainColor),
                ),
              )
            ]),
          );
        }));
  }
}
