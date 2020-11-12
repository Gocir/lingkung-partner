import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
// Utilities
import 'package:lingkung_partner/utilities/colorStyle.dart';
import 'package:lingkung_partner/utilities/textStyle.dart';
// Widgets
import 'package:lingkung_partner/screens/order/ordersComplete.dart';
import 'package:lingkung_partner/screens/order/ordersProgress.dart';

class OrderPage extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    final _kTabs = <Tab>[
      Tab(text: 'Dalam Proses'),
      Tab(text: 'Selesai'),
    ];

    final _kPages = <Widget>[OrdersProgress(), OrdersComplete()];

    return DefaultTabController(
      length: _kTabs.length,
      child: SafeArea(
        top: false,
        child: Scaffold(
          appBar: AppBar(
              backgroundColor: green,
              automaticallyImplyLeading: false,
              title: CustomText(
                text: 'Lingtra',
                size: 18.0,
                color: white,
                weight: FontWeight.w700,
              ),
              bottom: TabBar(
                  indicatorColor: yellow,
                  labelColor: yellow,
                  labelStyle: TextStyle(
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w500,
                  ),
                  unselectedLabelColor: white.withOpacity(0.8),
                  unselectedLabelStyle: TextStyle(
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.normal,
                  ),
                  tabs: _kTabs)),
          body: TabBarView(children: _kPages),
        ),
      ),
    );
  }
}
