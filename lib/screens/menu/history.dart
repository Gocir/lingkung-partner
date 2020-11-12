import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:lingkung_partner/providers/partnerProvider.dart';
// Utilities
import 'package:lingkung_partner/utilities/colorStyle.dart';
import 'package:lingkung_partner/utilities/textStyle.dart';
// Widgets
import 'package:lingkung_partner/screens/orderHistory/historyComplete.dart';
import 'package:lingkung_partner/screens/orderHistory/historyProgress.dart';
import 'package:provider/provider.dart';

class OrderHistoryPage extends StatefulWidget {
  @override
  _OrderHistoryPageState createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  @override
  Widget build(BuildContext context) {
    final partnerProvider = Provider.of<PartnerProvider>(context);

    final _kTabs = <Tab>[
      Tab(text: 'Dalam Proses'),
      Tab(text: 'Selesai'),
    ];

    final _kPages = <Widget>[
      HistoryProgress(partnerModel: partnerProvider.businessPartnerModel,),
      HistoryComplete(partnerModel: partnerProvider.businessPartnerModel,),
    ];

    return DefaultTabController(
      length: _kTabs.length,
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: white,
          appBar: AppBar(
            backgroundColor: green,
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: CustomText(
              text: 'Riwayat Pesanan',
              size: 18.0,
              color: white,
              weight: FontWeight.w600,
            ),
            bottom: TabBar(
              indicatorColor: yellow,
              labelColor: yellow,
              labelStyle: TextStyle(
                fontFamily: "Poppins",
                fontWeight: FontWeight.w500,
              ),
              unselectedLabelColor: white.withOpacity(0.6),
              unselectedLabelStyle: TextStyle(
                fontFamily: "Poppins",
                fontWeight: FontWeight.normal,
              ),
              tabs: _kTabs,
            ),
          ),
          body: TabBarView(children: _kPages),
        ),
      ),
    );
  }
}
