import 'package:flutter/material.dart';
import 'package:lingkung_partner/models/junkSalesModel.dart';
import 'package:lingkung_partner/utilities/textStyle.dart';
import 'package:lingkung_partner/widgets/order/ordersCompleteCard.dart';
import 'package:provider/provider.dart';
import 'package:lingkung_partner/providers/partnerProvider.dart';
import 'package:lingkung_partner/providers/junkSalesProvider.dart';

class OrdersComplete extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final junkSalesProvider = Provider.of<JunkSalesProvider>(context);
    final partnerProvider = Provider.of<PartnerProvider>(context);
    junkSalesProvider.loadJunkSalesComplete(partnerProvider.businessPartnerModel.id);

    return (junkSalesProvider.junkSalesComplete.isEmpty) ? Padding(
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
          ) :
    ListView.builder(
      scrollDirection: Axis.vertical,
      padding: const EdgeInsets.all(8.0),
      itemCount: junkSalesProvider.junkSalesComplete.length,
      itemBuilder: (_, index) {
        JunkSalesModel junkSales = junkSalesProvider.junkSalesComplete[index];
        return OrdersCompleteCard(partnerModel: partnerProvider.businessPartnerModel, junkSales: junkSales);
      },
    );
  }
}
