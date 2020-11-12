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

    return (trashReceiveProvider.trashReceiveByPartner.isEmpty)
        ? Center(
            child: CustomText(
                text: 'Belum Ada Jenis Sampah yang diterima',
                size: 16.0,
                weight: FontWeight.w600))
        : ListView.builder(
            scrollDirection: Axis.vertical,
            padding: const EdgeInsets.all(10.0),
            physics: BouncingScrollPhysics(),
            itemCount: trashReceiveProvider.trashReceiveByPartner.length,
            itemBuilder: (_, index) {
              TrashReceiveModel trashReceiveModel =
                  trashReceiveProvider.trashReceiveByPartner[index];
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
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
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                offset: Offset(0.0, 0.0),
                                blurRadius: 3.0,
                              ),
                            ],
                          ),
                        ),
                        placeholder: (context, url) => Container(
                          width: 70.0,
                          height: 70.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                offset: Offset(0.0, 0.0),
                                blurRadius: 3.0,
                              ),
                            ],
                          ),
                          child: SpinKitThreeBounce(color: black, size: 10.0),
                        ),
                        errorWidget: (context, url, error) => Container(
                          width: 70.0,
                          height: 70.0,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/images/noimage.png"),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                offset: Offset(0.0, 0.0),
                                blurRadius: 3.0,
                              ),
                            ],
                          ),
                        ),
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
                                    decimalDigits: 0,
                                  ).format(trashReceiveModel.price) +
                                  ' /Kg',
                              size: 16,
                              color: Colors.red,
                              weight: FontWeight.w600,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 70.0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            CircleAvatar(
                              radius: 16.0,
                              backgroundColor: green,
                              child: GestureDetector(
                                child:
                                    Icon(Icons.edit, size: 16.0, color: white),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          UpdateTrashReceivePage(
                                              trashReceiveModel:
                                                  trashReceiveModel),
                                    ),
                                  );
                                },
                              ),
                            ),
                            CircleAvatar(
                              radius: 16.0,
                              backgroundColor: blue,
                              child: GestureDetector(
                                child: Icon(Icons.delete_outline,
                                    size: 16.0, color: white),
                                onTap: () {
                                  _deleteModalBottomSheet(
                                      context, trashReceiveModel);
                                },
                              ),
                            ),
                            // Container(
                            //   padding: EdgeInsets.all(8.0),
                            //   decoration: BoxDecoration(
                            //     borderRadius: BorderRadius.circular(100.0),
                            //     color: blue,
                            //   ),
                            //   child: GestureDetector(
                            //     child: Icon(Icons.delete_outline,
                            //         size: 16.0, color: white),
                            //     onTap: () {
                            //       _deleteModalBottomSheet(context, trashReceiveModel);
                            //     },
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
  }

  void _deleteModalBottomSheet(context, TrashReceiveModel trashReceiveModel) {
    showModalBottomSheet<void>(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 296,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
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
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                      width: 70.0,
                                      height: 70.0,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
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
                                  child: SpinKitThreeBounce(
                                      color: black, size: 10.0)),
                              errorWidget: (context, url, error) => Container(
                                  width: 70.0,
                                  height: 70.0,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              "assets/images/noimage.png"),
                                          fit: BoxFit.cover),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
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
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    CustomText(
                      text: 'Yakin ingin menghapus jenis sampah ini?',
                      size: 18.0,
                      weight: FontWeight.w700,
                    ),
                    SizedBox(height: 16.0),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 48,
                            child: OutlineButton(
                              color: yellow,
                              highlightedBorderColor: yellow,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              borderSide: BorderSide(color: yellow, width: 2.5),
                              child: CustomText(
                                text: 'TIDAK',
                                color: yellow,
                                size: 16.0,
                                weight: FontWeight.w700,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        ),
                        SizedBox(width: 15.0),
                        Expanded(
                          child: Container(
                            height: 48,
                            child: FlatButton(
                              color: yellow,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: CustomText(
                                text: 'YA',
                                color: white,
                                size: 16.0,
                                weight: FontWeight.w700,
                              ),
                              onPressed: () async {
                                await _trashReceiveService
                                    .deleteTrashReceive(trashReceiveModel);
                                print('Trash Type Deleted!');
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
