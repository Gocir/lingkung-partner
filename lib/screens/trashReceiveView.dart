import 'package:flutter/material.dart';
import 'package:lingkung_partner/models/partnerModel.dart';
import 'package:lingkung_partner/models/trashReceiveModel.dart';
import 'package:lingkung_partner/providers/partnerProvider.dart';
import 'package:lingkung_partner/providers/trashReceiveProvider.dart';
import 'package:lingkung_partner/screens/addTrashReceive.dart';
import 'package:lingkung_partner/utilities/colorStyle.dart';
import 'package:lingkung_partner/utilities/textStyle.dart';
import 'package:lingkung_partner/widgets/trashReceiveLisTile.dart';
import 'package:provider/provider.dart';

class TrashReceivePage extends StatefulWidget {
  final PartnerModel partnerModel;
  TrashReceivePage({this.partnerModel});
  @override
  _TrashReceivePageState createState() => _TrashReceivePageState();
}

class _TrashReceivePageState extends State<TrashReceivePage> {
  @override
  Widget build(BuildContext context) {
    // final partner = Provider.of<PartnerProvider>(context);
    // final trashReceiveProvider = Provider.of<TrashReceiveProvider>(context);
    
    // trashReceiveProvider.loadTrashReceiveByPartner(partner.businessPartner.uid);
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: blue,
        elevation: 0.0,
        iconTheme: IconThemeData(color: white),
        title: CustomText(
          text: 'Jenis Sampah',
          size: 20.0,
          color: white,
          weight: FontWeight.w600,
        ),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 16.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddTrashReceivePage(),
                      ));
                },
                child: Icon(
                  Icons.add_circle_outline,
                  size: 26.0,
                  color: white,
                ),
              )),
        ],
      ),
      body: TrashReceiveLisTile(partnerModel: widget.partnerModel)
    );
  }
}
