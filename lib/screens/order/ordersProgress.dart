import 'package:flutter/material.dart';
import 'package:lingkung_partner/utilities/textStyle.dart';
import 'package:lingkung_partner/widgets/order/ordersProgressCard.dart';
import 'package:provider/provider.dart';
import 'package:lingkung_partner/providers/partnerProvider.dart';
import 'package:lingkung_partner/providers/junkSalesProvider.dart';
import 'package:lingkung_partner/models/junkSalesModel.dart';

class OrdersProgress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final partnerProvider = Provider.of<PartnerProvider>(context);
    final junkSalesProvider = Provider.of<JunkSalesProvider>(context);
    junkSalesProvider.loadJunkSalesOnProgress(partnerProvider.businessPartnerModel.id);

    return (junkSalesProvider.junkSalesOnProgress.isEmpty)
        ? Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                children: <Widget>[
                  Image.asset("assets/images/searching.png"),
                  SizedBox(height: 16.0),
                  CustomText(
                    text:
                        'Belum Ada Pesanan',
                    align: TextAlign.center,
                    weight: FontWeight.w600,
                  ),
                ],
              ),
            ),
          )
        : ListView.builder(
            scrollDirection: Axis.vertical,
            padding: const EdgeInsets.all(8.0),
            itemCount: junkSalesProvider.junkSalesOnProgress.length,
            itemBuilder: (_, index) {
              JunkSalesModel junkSales =
                  junkSalesProvider.junkSalesOnProgress[index];
              return OrdersProgressCard(partnerModel: partnerProvider.businessPartnerModel, junkSales: junkSales);
            },
          );
  }
}
