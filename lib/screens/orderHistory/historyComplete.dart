import 'package:flutter/material.dart';
import 'package:lingkung_partner/models/junkSalesModel.dart';
import 'package:lingkung_partner/models/partnerModel.dart';
import 'package:lingkung_partner/utilities/textStyle.dart';
import 'package:lingkung_partner/widgets/orderHistory/historyCompleteCard.dart';
import 'package:provider/provider.dart';
import 'package:lingkung_partner/providers/junkSalesProvider.dart';

class HistoryComplete extends StatefulWidget {
  final PartnerModel partnerModel;
  HistoryComplete({this.partnerModel});
  @override
  _HistoryCompleteState createState() => _HistoryCompleteState();
}

class _HistoryCompleteState extends State<HistoryComplete> {
  @override
  Widget build(BuildContext context) {
    final junkSalesProvider = Provider.of<JunkSalesProvider>(context);
    junkSalesProvider.loadJunkSalesComplete(widget.partnerModel.id);

    return (junkSalesProvider.junkSalesComplete.isEmpty) ? Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                Image.asset("assets/images/searching.png"),
                SizedBox(height: 16.0),
                CustomText(
                  text:
                      'Belum ada pesanan yang di selesaikan. Ambil dan selesaikan pesanan yuk!',
                  align: TextAlign.center,
                  weight: FontWeight.w600,
                ),
              ],
            ),
          ) :
    ListView.builder(
      scrollDirection: Axis.vertical,
      padding: const EdgeInsets.all(8.0),
      itemCount: junkSalesProvider.junkSalesComplete.length,
      itemBuilder: (_, index) {
        JunkSalesModel junkSales = junkSalesProvider.junkSalesComplete[index];
        return HistoryCompleteCard(partnerModel: widget.partnerModel, junkSales: junkSales);
      },
    );
  }
}
