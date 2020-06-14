import 'package:flutter/material.dart';
import 'package:lingkung_partner/utilities/textStyle.dart';

class MessagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomText(
        text: 'This is Message',
        size: 50.0,
      ),
    );
  }
}
