import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lingkung_partner/models/partnerModel.dart';
import 'package:lingkung_partner/models/junkSalesModel.dart';
import 'package:lingkung_partner/screens/order/orderDetails/orderDetailsComplete.dart';
import 'package:lingkung_partner/utilities/colorStyle.dart';
import 'package:lingkung_partner/utilities/textStyle.dart';
import 'package:intl/intl.dart';

class OrdersCompleteCard extends StatefulWidget {
  final PartnerModel partnerModel;
  final JunkSalesModel junkSales;
  OrdersCompleteCard({this.junkSales, this.partnerModel});
  @override
  _OrdersCompleteCardState createState() => _OrdersCompleteCardState();
}

class _OrdersCompleteCardState extends State<OrdersCompleteCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OrderDetailsComplete(
                  partnerModel: widget.partnerModel,
                  junkSales: widget.junkSales),
            ),
          );
        },
        contentPadding: const EdgeInsets.all(16.0),
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
        title: CustomText(
          text: '${widget.junkSales.userName}',
          weight: FontWeight.w700,
        ),
        subtitle: RichText(
          text: TextSpan(
            style: TextStyle(
                fontFamily: "Poppins",
                color: grey,
                fontSize: 14.0,
                fontWeight: FontWeight.w600),
            children: [
              TextSpan(
                text: NumberFormat.currency(
                        locale: 'id', symbol: 'Rp', decimalDigits: 0)
                    .format(widget.junkSales.profitTotal),
              ),
              TextSpan(
                text: ', ${widget.junkSales.amountTrash} Jenis Sampah',
              ),
            ],
          ),
        ),
        trailing: CustomText(
          text: '07.00',
          size: 12.0,
        ),
      ),
    );
  }
}
