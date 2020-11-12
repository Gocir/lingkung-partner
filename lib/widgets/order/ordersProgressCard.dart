import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lingkung_partner/models/partnerModel.dart';
import 'package:lingkung_partner/models/junkSalesModel.dart';
import 'package:lingkung_partner/utilities/colorStyle.dart';
import 'package:lingkung_partner/utilities/textStyle.dart';
import 'package:lingkung_partner/providers/junkSalesProvider.dart';
import 'package:provider/provider.dart';
import 'package:lingkung_partner/screens/order/orderDetails/orderDetailsProgress.dart';

class OrdersProgressCard extends StatefulWidget {
  final PartnerModel partnerModel;
  final JunkSalesModel junkSales;
  OrdersProgressCard({this.partnerModel, this.junkSales});
  @override
  _OrdersProgressCardState createState() => _OrdersProgressCardState();
}

class _OrdersProgressCardState extends State<OrdersProgressCard> {
  @override
  Widget build(BuildContext context) {
    final junkSalesProvider = Provider.of<JunkSalesProvider>(context);
    junkSalesProvider.loadListTrash(widget.junkSales.id);
    return Card(
      child: ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  OrderDetailsProgress(junkSalesModel: widget.junkSales),
            ),
          );
        },
        leading: CachedNetworkImage(
          imageUrl: widget.junkSales.trashImage.toString(),
          imageBuilder: (_, imageProvider) =>
              CircleAvatar(backgroundImage: imageProvider),
          placeholder: (_, url) => CircleAvatar(
            backgroundColor: Colors.grey[200],
            child: SpinKitThreeBounce(
              color: black,
              size: 10.0,
            ),
          ),
          errorWidget: (_, url, error) => CircleAvatar(
            backgroundColor: Colors.grey[200],
            backgroundImage: AssetImage("assets/images/noimage.png"),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CustomText(
              text: (widget.junkSales.status == "Receive Orders")
                      ? 'Lagi ke tempat pemesan'
                      : (widget.junkSales.status == "Take Orders")
                          ? 'Lagi ambil sampah'
                          : (widget.junkSales.status == "Deliver Orders")
                              ? 'Lagi ke tempat Anda'
                              : 'Lagi di tujuan akhir',
              color: green,
              weight: FontWeight.w700,
            ),
            CustomText(
              text: (widget.junkSales.userName == null)
                  ? 'Loading...'
                  : '${widget.junkSales.userName}',
              size: 16.0,
              weight: FontWeight.w600,
            ),
          ],
        ),
        subtitle: RichText(
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          text: TextSpan(
            style: TextStyle(
              fontFamily: "Poppins",
              fontSize: 12.0,
              color: grey,
            ),
            children: [
              TextSpan(
                text: '${junkSalesProvider.listTrash.length} Jenis',
              ),
              TextSpan(text: ' º '),
              TextSpan(
                text: '${widget.junkSales.directionModel.startPoint}',
              ),
            ],
          ),
        ),
        trailing: Column(
          children: <Widget>[
            CustomText(
              text: '15-25 menit',
              size: 12.0,
              color: grey,
            ),
            CustomText(
              text: 'Estimasi waktu',
              size: 12.0,
              color: grey,
            ),
          ],
        ),
      ),
    );
  }
}
