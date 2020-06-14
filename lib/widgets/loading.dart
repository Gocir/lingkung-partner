import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lingkung_partner/utilities/colorStyle.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: white,
      child: Center(
        child: SpinKitDualRing(
          color: green,
          size: 50.0,
        ),
      ),
    );
  }
}
