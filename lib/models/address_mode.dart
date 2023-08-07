class AddressModel {
  late int? _id;
  late String _addressType;
  late String? _contactPersonName;
  late String? _contactPersonNumber;
  late String _address;
  late String _latitude;
  late String _longitue;

  AddressModel(
      {id,
      required addressType,
      contactPersonName,
      contactPersonNumber,
      address,
      latitude,
      longitude}) {
    this._id = id;
    this._addressType = addressType;
    this._contactPersonName = contactPersonName;
    this._contactPersonNumber = contactPersonNumber;
    this._address = address;
    this._latitude = latitude;
    this._longitue = longitude;
  }

  String get address => _address;
  String get addressType => _addressType;
  String get contactPersonName => _contactPersonName!;
  String get contactPersonNumber => _contactPersonNumber!;
  String get latitude => _latitude;
  String get longitude => _longitue;

  AddressModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _address = json['address'];
    _addressType = json['address_type'];
    _contactPersonName = json['contact_person_name'];
    _contactPersonNumber = json['contact_person_number'];
    _latitude = json['latitude'];
    _longitue = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id':_id,
      'address':_address,
      'address_type':_addressType,
      'contact_person_name':_contactPersonName,
      'contact_person_number':_contactPersonNumber,
      'latitude':_latitude,
      'longitude':_longitue,
    };
  }
}
