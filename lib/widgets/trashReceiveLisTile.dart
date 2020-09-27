import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:lingkung_partner/models/partnerModel.dart';
import 'package:lingkung_partner/models/trashReceiveModel.dart';
import 'package:lingkung_partner/providers/trashReceiveProvider.dart';
import 'package:lingkung_partner/screens/profileDetail/trashReceive/updateTrashReceive.dart';
import 'package:lingkung_partner/services/trashReceiveService.dart';
import 'package:lingkung_partner/utilities/colorStyle.dart';
import 'package:lingkung_partner/utilities/textStyle.dart';
import 'package:provider/provider.dart';

class TrashReceiveLisTile extends StatefulWidget {
  final PartnerModel partnerModel;
  TrashReceiveLisTile({this.partnerModel});
  @override
  _TrashReceiveLisTileState createState() => _TrashReceiveLisTileState();
}

class _TrashReceiveLisTileState extends State<TrashReceiveLisTile> {
  TrashReceiveServices _trashReceiveService = TrashReceiveServices();
  @override
  Widget build(BuildContext context) {
    final trashReceiveProvider = Provider.of<TrashReceiveProvider>(context);
    trashReceiveProvider.loadTrashReceiveByPartner(widget.partnerModel.id);

    return (trashReceiveProvider.trashReceiveByPartner.isNotEmpty) ? ListView.builder(
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.all(10.0),
        physics: BouncingScrollPhysics(),
        itemCount: trashReceiveProvider.trashReceiveByPartner.length,
        itemBuilder: (_, index) {
          TrashReceiveModel trashReceiveModel =
              trashReceiveProvider.trashReceiveByPartner[index];
          return Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      CachedNetworkImage(
                        imageUrl: trashReceiveModel.image.toString(),
                        imageBuilder: (context, imageProvider) => Container(
                            width: 70.0,
                            height: 70.0,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: imageProvider, fit: BoxFit.cover),
                                borderRadius: BorderRadius.circular(10.0),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black12,
                                      offset: Offset(0.0, 0.0),
                                      blurRadius: 3.0)
                                ])),
                        placeholder: (context, url) => Container(
                            width: 70.0,
                            height: 70.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black12,
                                      offset: Offset(0.0, 0.0),
                                      blurRadius: 3.0)
                                ]),
                            child:
                                SpinKitThreeBounce(color: black, size: 10.0)),
                        errorWidget: (context, url, error) => Container(
                            width: 70.0,
                            height: 70.0,
                            decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/images/noimage.png"), fit: BoxFit.cover),
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black12,
                                  offset: Offset(0.0, 0.0),
                                  blurRadius: 3.0)
                            ])),
                      ),
                      SizedBox(width: 10.0),
                      Expanded(
                        child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              CustomText(
                                text: trashReceiveModel.trashName,
                                size: 16,
                                color: grey,
                                line: 2,
                                over: TextOverflow.fade,
                                weight: FontWeight.w500,
                              ),
                              CustomText(
                                text: NumberFormat.currency(
                                            locale: 'id',
                                            symbol: 'Rp',
                                            decimalDigits: 0)
                                        .format(trashReceiveModel.price) +
                                    ' /Kg',
                                size: 16,
                                color: Colors.red,
                                weight: FontWeight.w600,
                              ),
                            ]),
                      ),
                      Container(
                        height: 70.0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100.0),
                                  color: green,
                                ),
                                child: GestureDetector(
                                  child: Icon(Icons.edit, size: 16.0, color: white),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              UpdateTrashReceivePage(
                          trashReceiveModel:
                              trashReceiveModel),
                                        ));
                                  },
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100.0),
                                  color: yellow,
                                ),
                                child: GestureDetector(
                                  child: Icon(Icons.delete_outline,
                                      size: 16.0, color: white),
                                  onTap: () async {
                                    await _trashReceiveService
                                        .deleteTrashReceive(trashReceiveModel.id);
                                  },
                                ),
                              ),
                            ],
                          ),
                      ),
                    ]),
              ));
        }) :
        Center(
          child: CustomText(
              text: 'Belum Ada Jenis Sampah',
              size: 16.0,
              weight: FontWeight.w600));
  }
}
