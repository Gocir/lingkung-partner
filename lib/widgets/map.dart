import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lingkung_partner/providers/addressProvider.dart';
import 'package:provider/provider.dart';

class Maps extends StatefulWidget {
  @override
  _MapsState createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  @override
  Widget build(BuildContext context) {
    final addressProvider = Provider.of<AddressProvider>(context);
    return GoogleMap(
            initialCameraPosition:
                CameraPosition(target: addressProvider.initialPosition, zoom: 10.0),
            mapType: MapType.normal,
            myLocationEnabled: true,
            zoomControlsEnabled: false,
            onMapCreated: addressProvider.onMapCreated,
            onCameraMove: addressProvider.onCameraMove,
            markers: addressProvider.markers
            );
  }
}
