import 'package:flutter/material.dart';
import 'package:lingkung_partner/models/partnerModel.dart';
import 'package:lingkung_partner/utilities/textStyle.dart';
import 'package:lingkung_partner/widgets/orderHistory/historyProgressCard.dart';
import 'package:provider/provider.dart';
import 'package:lingkung_partner/providers/junkSalesProvider.dart';
import 'package:lingkung_partner/models/junkSalesModel.dart';

class HistoryProgress extends StatefulWidget {
  final PartnerModel partnerModel;
  HistoryProgress({this.partnerModel});
  @override
  _HistoryProgressState createState() => _HistoryProgressState();
}

class _HistoryProgressState extends State<HistoryProgress> {
  @override
  Widget build(BuildContext context) {
    final junkSalesProvider = Provider.of<JunkSalesProvider>(context);
    junkSalesProvider.loadJunkSalesOnProgress(widget.partnerModel.id);

    return (junkSalesProvider.junkSalesOnProgress.isEmpty)
        ? Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                Image.asset("assets/images/searching.png"),
                SizedBox(height: 16.0),
                CustomText(
                  text:
                      'Belum ada pesanan yang di proses nih. Ambil pesanan sekarang, yuk!',
                  align: TextAlign.center,
                  weight: FontWeight.w600,
                ),
              ],
            ),
          )
        : ListView.builder(
            scrollDirection: Axis.vertical,
            padding: const EdgeInsets.all(8.0),
            itemCount: junkSalesProvider.junkSalesOnProgress.length,
            itemBuilder: (_, index) {
              JunkSalesModel junkSales =
                  junkSalesProvider.junkSalesOnProgress[index];
              return HistoryProgressCard(partnerModel: widget.partnerModel, junkSales: junkSales);
            },
          );
  }
}
