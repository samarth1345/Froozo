import 'package:froozo/data/repository/location_repo.dart';
import 'package:froozo/models/address_mode.dart';
import 'package:froozo/models/response_model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationController extends GetxController implements GetxService {
  final LocationRepo locationRepo;
  LocationController({required this.locationRepo});
  bool _loading = false;
  late Position _position;
  Position get position => _position;
  late Position _pickPosition;
  Placemark _placemark = Placemark();
  Placemark get placemark => _placemark;
  Placemark _pickPlacemark = Placemark();
  Placemark get pickPlacemark => _pickPlacemark;
  List<AddressModel> _addressList = [];
  List<AddressModel> get addressList => _addressList;
  late List<AddressModel> _allAddressList = [];
  List<String> _addressTypeList = ["home", "office", "others"];
  List<String> get addressTypeList => _addressTypeList;
  int _addressTypeIndex = 0;
  int get addressTypeIndex => _addressTypeIndex;
  late Map<String, dynamic> _getAddress;
  Map get getAddress => _getAddress;
  late GoogleMapController _mapController;
  GoogleMapController get mapController => _mapController;
  bool _updateAddressData = true;
  bool _changeAddress = true;

  void setMapController(GoogleMapController mapController) {
    _mapController = mapController;
  }

  void updatePosition(CameraPosition position, bool flag) async {
    if (_updateAddressData) {
      _loading = true;
      update();
      try {
        if (flag) {
          _position = Position(
              latitude: position.target.latitude,
              longitude: position.target.longitude,
              timestamp: DateTime.now(),
              heading: 1,
              accuracy: 1,
              altitude: 1,
              speedAccuracy: 1,
              speed: 1);
        } else {
          _pickPosition = Position(
              latitude: position.target.latitude,
              longitude: position.target.longitude,
              timestamp: DateTime.now(),
              heading: 1,
              accuracy: 1,
              altitude: 1,
              speedAccuracy: 1,
              speed: 1);
        }
        if (_changeAddress) {
          String _address = await getAddressfromGeocode(
              LatLng(position.target.latitude, position.target.longitude));
          flag
              ? _placemark = Placemark(name: _address)
              : _pickPlacemark = Placemark(name: _address);
        }
      } catch (e) {
        print(e);
      }
    } else {}
  }

  Future<String> getAddressfromGeocode(LatLng latLng) async {
    String _address = "";
    Response response = await locationRepo.getAddressfromGeocode(latLng);
    if (response.body['status'] == 'OK') {
      _address = response.body['results'][0]['formatted_address'].toString();
      // print("debug" + _address);
    } else {
      print("error getting google api");
    }
    return _address;
  }

  void setPermissions() async {
    await Permission.locationWhenInUse.request();
  }

  void setAddressTypeIndex(int index) {
    _addressTypeIndex = index;
    update();
  }

  void addAddress(AddressModel addressModel) {
    locationRepo.addAddress(addressModel);
    update();
  }

  bool hasAddress() {
    return locationRepo.hasAddress();
  }

  AddressModel getCurrModel() {
    return locationRepo.getAddress();
  }

  String getCurrAddress() {
    AddressModel addressModel = locationRepo.getAddress();
    String address = "";
    address = addressModel.address;
    return address;
  }

  String getCurrName() {
    AddressModel addressModel = locationRepo.getAddress();
    String address = "";
    address = addressModel.contactPersonName;
    return address;
  }

  String getCurrNumber() {
    AddressModel addressModel = locationRepo.getAddress();
    String address = "";
    address = addressModel.contactPersonNumber;
    return address;
  }
}
