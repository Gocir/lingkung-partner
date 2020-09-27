import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddressProvider with ChangeNotifier {
  static LatLng _initialPosition;
  LatLng _lastPosition = _initialPosition;
  bool locationServiceActive = true;
  final Set<Marker> _markers = {};
  final Set<Polyline> _polyLines = {};
  GoogleMapController _mapController;
  // CameraPosition _camPosition;
  // AddresServices _googleMapsServices = AddresServices();
  TextEditingController locationController = TextEditingController();
  TextEditingController destinationController = TextEditingController();
  String titleCurrentAddress;
  String currentAddress;
  LatLng get initialPosition => _initialPosition;
  LatLng get lastPosition => _lastPosition;
  // AddresServices get googleMapsServices => _googleMapsServices;
  GoogleMapController get mapController => _mapController;
  Set<Marker> get markers => _markers;
  Set<Polyline> get polyLines => _polyLines;

  AddressProvider() {
    getUserLocation();
    _loadingInitialPosition();
  }
// ! TO GET THE USERS LOCATION
  Future<void> getUserLocation() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    List<Placemark> p = await Geolocator()
            .placemarkFromCoordinates(position.latitude, position.longitude);
    _initialPosition = LatLng(position.latitude, position.longitude);
    print("the latitude is: ${position.longitude} and th longitude is: ${position.longitude} ");
    print("initial position is : ${_initialPosition.toString()}");
    Placemark placemark = p[0];
    titleCurrentAddress = "${placemark.thoroughfare}";
    currentAddress = "${placemark.thoroughfare}, ${placemark.subThoroughfare}, ${placemark.subLocality}, ${placemark.locality}, ${placemark.subAdministrativeArea}, ${placemark.administrativeArea}, ${placemark.country}, ${placemark.postalCode}";
    _addMarker(_initialPosition, titleCurrentAddress);
    notifyListeners();
  }

  // ! TO CREATE ROUTE
  void createRoute(String encondedPoly) {
    _polyLines.add(Polyline(
        polylineId: PolylineId(_lastPosition.toString()),
        width: 10,
        points: _convertToLatLng(_decodePoly(encondedPoly)),
        color: Colors.black));
    notifyListeners();
  }

  // ! ADD A MARKER ON THE MAP
  void _addMarker(LatLng location, String address) {
    _markers.add(Marker(
        draggable: true,
        onDragEnd: (value) {
          print(value.latitude);
          print(value.longitude);
        },
        markerId: MarkerId(location.toString()),
        position: location,
        infoWindow: InfoWindow(title: address, snippet: location.toString()),
        icon: BitmapDescriptor.defaultMarker));
    notifyListeners();
  }

  // ! CREATE LATLNG LIST
  List<LatLng> _convertToLatLng(List points) {
    List<LatLng> result = <LatLng>[];
    for (int i = 0; i < points.length; i++) {
      if (i % 2 != 0) {
        result.add(LatLng(points[i - 1], points[i]));
      }
    }
    return result;
  }

  // !DECODE POLY
  List _decodePoly(String poly) {
    var list = poly.codeUnits;
    var lList = new List();
    int index = 0;
    int len = poly.length;
    int c = 0;
// repeating until all attributes are decoded
    do {
      var shift = 0;
      int result = 0;

      // for decoding value of one attribute
      do {
        c = list[index] - 63;
        result |= (c & 0x1F) << (shift * 5);
        index++;
        shift++;
      } while (c >= 32);
      /* if value is negetive then bitwise not the value */
      if (result & 1 == 1) {
        result = ~result;
      }
      var result1 = (result >> 1) * 0.00001;
      lList.add(result1);
    } while (index < len);

/*adding to previous value as done in encoding */
    for (var i = 2; i < lList.length; i++) lList[i] += lList[i - 2];

    print(lList.toString());

    return lList;
  }

  // ! SEND REQUEST
  // void sendRequest(String intendedLocation) async {
  //   List<Placemark> placemark =
  //       await Geolocator().placemarkFromAddress(intendedLocation);
  //   double latitude = placemark[0].position.latitude;
  //   double longitude = placemark[0].position.longitude;
  //   LatLng destination = LatLng(latitude, longitude);
  //   _addMarker(destination, intendedLocation);
  //   // String route = await _googleMapsServices.getRouteCoordinates(
  //   //     _initialPosition, destination);
  //   // createRoute(route);
  //   notifyListeners();
  // }

  // ! ON CAMERA MOVE
  void onCameraMove(CameraPosition cameraPosition) {
    _initialPosition = cameraPosition.target;
    notifyListeners();
  }

  // ! ON CREATE
  void onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    // _mapController.animateCamera(CameraUpdate.newCameraPosition(_camPosition));
    notifyListeners();
  }

//  LOADING INITIAL POSITION
  void _loadingInitialPosition()async{
    await Future.delayed(Duration(seconds: 5)).then((v) {
      if(_initialPosition == null){
        locationServiceActive = false;
        notifyListeners();
      }
    });
  }
}