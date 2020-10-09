import 'package:flutter/material.dart';
import 'package:lingkung_partner/utilities/textStyle.dart';

class OrderComplete extends StatefulWidget {
  @override
  _OrderCompleteState createState() => _OrderCompleteState();
}

class _OrderCompleteState extends State<OrderComplete> {
  @override
  Widget build(BuildContext context) {
    return Center(child: CustomText(text: 'OrderComlete'));
  }
}
