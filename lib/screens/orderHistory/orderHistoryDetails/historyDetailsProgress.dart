import 'package:flutter/material.dart';
import 'package:lingkung_partner/models/partnerModel.dart';
import 'package:lingkung_partner/models/junkSalesModel.dart';
import 'package:lingkung_partner/utilities/colorStyle.dart';
import 'package:lingkung_partner/utilities/textStyle.dart';
import 'package:lingkung_partner/providers/junkSalesProvider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:lingkung_partner/utilities/loading.dart';
import 'package:lingkung_partner/models/trashCartModel.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HistoryDetailsProgress extends StatefulWidget {
  final PartnerModel partnerModel;
  final JunkSalesModel junkSales;
  HistoryDetailsProgress({this.partnerModel, this.junkSales});
  @override
  _HistoryDetailsProgressState createState() => _HistoryDetailsProgressState();
}

class _HistoryDetailsProgressState extends State<HistoryDetailsProgress> {
  List<TrashCartModel> listTrash;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final junkSalesProvider = Provider.of<JunkSalesProvider>(context);
    junkSalesProvider.loadSingleJunkSales(widget.junkSales.id);
    junkSalesProvider.loadListTrash(widget.junkSales.id);
    listTrash = junkSalesProvider.listTrash;
    return loading
        ? Loading()
        : SafeArea(
            top: false,
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: white,
                elevation: 0,
                iconTheme: IconThemeData(color: black),
                automaticallyImplyLeading: false,
                leading: IconButton(
                  icon: Icon(CupertinoIcons.chevron_down),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                title: CustomText(
                  text: 'Riwayat Pesanan',
                  size: 18.0,
                  weight: FontWeight.w600,
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 5.0,
                                right: 10.0,
                              ),
                              child: FaIcon(
                                FontAwesomeIcons.solidCircle,
                                size: 10.0,
                                color: green,
                              ),
                            ),
                            Expanded(
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: (widget.junkSales.status == "Take Orders") ? 'Menuju ke Tujuan Utama\n' : (widget.junkSales.status == "Receive Orders") ? 'Sedang di Tujuan Utama\n' : 'Menuju ke Tempat Anda\n',
                                      style: TextStyle(
                                        color: black,
                                        fontFamily: 'Poppins',
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    TextSpan(
                                      text: (widget.junkSales.status == "Take Orders") ?
                                          'Scavanger sedang menuju ke tempat pemesan. Tunggu ya...' :
                                          (widget.junkSales.status == "Receive Orders") ?
                                          'Scavanger sedang mengambil sampah, sedikit lagi akan ke tempat Anda. Tunggu ya...' :
                                          'Scavanger sedang membawa sampah ke tempat Anda. Tunggu ya...',
                                      style: TextStyle(
                                        color: black,
                                        fontFamily: 'Poppins',
                                        fontSize: 12.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    CustomText(
                      text: 'Rincian Sampah',
                      weight: FontWeight.w700,
                    ),
                    SizedBox(height: 5.0),
                    Card(
                      child: ListView.separated(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: listTrash.length,
                        separatorBuilder: (_, index) => Divider(height: 0),
                        itemBuilder: (_, index) {
                          return ListTile(
                            dense: true,
                            leading: CustomText(
                              text: '${listTrash[index].weight} Kg',
                            ),
                            title: CustomText(
                              text: '${listTrash[index].name}',
                              size: 16.0,
                              weight: FontWeight.w600,
                            ),
                            trailing: CustomText(
                              text: NumberFormat.currency(
                                locale: 'id',
                                symbol: 'Rp',
                                decimalDigits: 0,
                              ).format(listTrash[index].price),
                              weight: FontWeight.w700,
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                CustomText(
                                  text: 'Untuk Bumi',
                                ),
                                CustomText(
                                  text: NumberFormat.currency(
                                    locale: 'id',
                                    symbol: 'Rp',
                                    decimalDigits: 0,
                                  ).format(100),
                                  weight: FontWeight.w600,
                                ),
                              ],
                            ),
                            SizedBox(height: 10.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                CustomText(
                                  text: 'Bayar tunai',
                                ),
                                CustomText(
                                  text: NumberFormat.currency(
                                    locale: 'id',
                                    symbol: 'Rp',
                                    decimalDigits: 0,
                                  ).format(widget.junkSales.profitTotal),
                                  weight: FontWeight.w600,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      margin: const EdgeInsets.all(0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: <Widget>[
                            Image.asset("assets/icons/balanceColor.png"),
                            SizedBox(width: 10.0),
                            CustomText(
                              text: 'Metode Pembayaran',
                              weight: FontWeight.w600,
                            ),
                            Spacer(),
                            CustomText(
                              text: 'Tunai',
                              weight: FontWeight.w600,
                            ),
                            Image.asset("assets/icons/balanceColor.png"),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
