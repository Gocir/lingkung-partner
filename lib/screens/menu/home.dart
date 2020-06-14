import 'package:flutter/material.dart';
import 'package:lingkung_partner/utilities/textStyle.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomText(
        text: 'This is Home',
        size: 50.0,
      ),
    );
  }
}
