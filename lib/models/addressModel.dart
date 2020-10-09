class AddressModel {
  static const LOCATION_BENCHMARKS = "locationBenchmarks";
  static const ADDRESS_DETAIL = "addressDetail";
  static const LATITUDE = "latitude";
  static const LONGITUDE = "longitude";

  String _locationBenchmarks;
  String _latitude;
  String _longitude;
  String _addressDetail;

  //  getters
  String get locationBenchmarks => _locationBenchmarks;
  String get latitude => _latitude;
  String get longitude => _longitude;
  String get addressDetail => _addressDetail;

  AddressModel.fromMap(Map data) {
    _locationBenchmarks = data[LOCATION_BENCHMARKS];
    _latitude = data[LATITUDE];
    _longitude = data[LONGITUDE];
    _addressDetail = data[ADDRESS_DETAIL];
  }

  Map toMap() => {
    LOCATION_BENCHMARKS : _locationBenchmarks,
    LATITUDE : _latitude,
    LONGITUDE : _longitude,
    ADDRESS_DETAIL : _addressDetail
  };
}
