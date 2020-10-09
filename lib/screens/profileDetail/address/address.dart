import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lingkung_partner/providers/addressProvider.dart';
import 'package:lingkung_partner/screens/profileDetail/address/setLocation.dart';
import 'package:provider/provider.dart';
//  Providers
import 'package:lingkung_partner/providers/partnerProvider.dart';
//  Utilities
import 'package:lingkung_partner/utilities/colorStyle.dart';
import 'package:lingkung_partner/utilities/textStyle.dart';
//  Widgets
import 'package:lingkung_partner/utilities/loading.dart';

const kGoogleApiKey = "AIzaSyBxcEIaTorP_Qj34K0EH32zZ5Bmd-i7SRc";

class Address extends StatefulWidget {
  final String placeId;
  Address({this.placeId});
  @override
  _AddressState createState() => _AddressState();
}

class _AddressState extends State<Address> {
  final _scaffoldStateKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  String locationBenchmarks = '';
  String addressDetail = '';
  LatLng location;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final addressProvider = Provider.of<AddressProvider>(context);
    return loading
        ? Loading()
        : Scaffold(
            key: _scaffoldStateKey,
            backgroundColor: white,
            resizeToAvoidBottomPadding: false,
            appBar: AppBar(
                backgroundColor: white,
                iconTheme: IconThemeData(color: black),
                title: CustomText(
                    text: 'Informasi Mitra Pengelola',
                    size: 18.0,
                    weight: FontWeight.w600),
                    titleSpacing: 0,
                actions: <Widget>[
                      IconButton(
                          icon: Icon(Icons.help_outline, color: black),
                          onPressed: null)
                    ]),
            body: Form(
                key: _formKey,
                child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                                  CustomText(
                                      text: 'Patokan lokasi',
                                      weight: FontWeight.w700),
                          TextFormField(
                              textCapitalization: TextCapitalization.words,
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  color: black,
                                  fontWeight: FontWeight.normal),
                              decoration: InputDecoration(
                                  isDense: true,
                                  counterStyle: TextStyle(
                                      fontFamily: "Poppins",
                                      color: black,
                                      fontWeight: FontWeight.normal),
                                  hintText:
                                      'Cth: Belakang Warung/Dalam Gang Kecil',
                                  hintStyle: TextStyle(
                                      fontFamily: "Poppins"),
                                  errorStyle: TextStyle(fontFamily: "Poppins"),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: blue))),
                              onChanged: (String str) {
                                setState(() {
                                  (str == null)
                                      ? locationBenchmarks = "Tidak Ada Patokan"
                                      : locationBenchmarks = str;
                                });
                              }),
                          SizedBox(height: 16.0),
                                  CustomText(
                                      text: 'Alamat Detail',
                                      weight: FontWeight.w700),
                          TextFormField(
                              textCapitalization: TextCapitalization.words,
                              maxLines: 3,
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  color: black),
                              decoration: InputDecoration(
                                  isDense: true,
                                  counterStyle: TextStyle(
                                      fontFamily: "Poppins",
                                      color: black),
                                  hintText:
                                      'Cth: Perumahan KoMa Blok L13 No.31 RT.31/RW.13, Pendidikan Barat, Kabupaten Banyumas, Jawa Tengah 53113',
                                  hintStyle: TextStyle(
                                    fontFamily: "Poppins",
                                  ),
                                  hintMaxLines: 3,
                                  errorStyle: TextStyle(fontFamily: "Poppins"),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: blue))),
                              onChanged: (String str) {
                                setState(() {
                                  addressDetail = str;
                                });
                              },
                              validator: (value) => (value.isEmpty)
                                  ? 'Masukkan alamat dengan lengkap'
                                  : null),
                          SizedBox(height: 16.0),
                          Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                CustomText(
                                    text: 'Lokasi di peta',
                                    weight: FontWeight.w500),
                                Container(
                                    height: 30.0,
                                    child: OutlineButton(
                                        // padding: const EdgeInsets.only(
                                        //     left: 10.0, right: 10.0),
                                        color: white,
                                        highlightColor: white,
                                        highlightedBorderColor: green,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        borderSide: BorderSide(
                                            color: green, width: 1.5),
                                        child: CustomText(
                                            text: 'SET LOKASI',
                                            color: green,
                                            size: 12.0,
                                            weight: FontWeight.w700),
                                        onPressed: () {
                                          _setLocation(context);
                                        }))
                              ]),
                          SizedBox(height: 10.0),
                          Container(
                              width: MediaQuery.of(context).size.width,
                              height: 180.0,
                              color: white,
                              child: GoogleMap(
                                  initialCameraPosition: CameraPosition(
                                      target: addressProvider.initialPosition,
                                      zoom: 10.0),
                                  mapType: MapType.normal,
                                  zoomControlsEnabled: false,
                                  onMapCreated: addressProvider.onMapCreated,
                                  onCameraMove: addressProvider.onCameraMove,
                                  markers: addressProvider.markers))
                        ]))),
            bottomNavigationBar: Container(
                height: 77.0,
                color: white,
                padding: const EdgeInsets.all(16.0),
                child: FlatButton(
                    color: green,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                        child: CustomText(
                            text: 'SIMPAN',
                            color: white,
                            size: 16.0,
                            weight: FontWeight.w700)),
                    onPressed: () {
                      save();
                    })));
  }

  _setLocation(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SetLocation()),
    );

    // After the Selection Screen returns a result, hide any previous snackbars
    // and show the new result.
    _scaffoldStateKey.currentState
        .showSnackBar(SnackBar(content: Text("$result")));
    setState(() {
      location = result;
      print("location is: LatLng(${location.latitude}, ${location.longitude})");
    });
  }

  void save() async {
    final partnerProvider =
        Provider.of<PartnerProvider>(context, listen: false);
    if (_formKey.currentState.validate()) {
      setState(() => loading = true);
      bool value = await partnerProvider.addAddress(
          locationBenchmarks: locationBenchmarks, addressDetail: addressDetail, latMaps: location.latitude.toString(), longMaps: location.longitude.toString());
      if (value) {
        print("Address Saved!");
        _scaffoldStateKey.currentState.showSnackBar(SnackBar(
            content: CustomText(
          text: "Saved!",
          color: white,
          weight: FontWeight.w600,
        )));
        partnerProvider.reloadPartnerModel();
        setState(() {
          loading = false;
        });
        Navigator.pop(context);
      } else {
        print("Address failed to Save!");
        setState(() {
          loading = false;
        });
      }
      setState(() => loading = false);
    } else {
      setState(() => loading = false);
    }
  }
}
