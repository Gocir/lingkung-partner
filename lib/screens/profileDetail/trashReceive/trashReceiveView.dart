import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lingkung_partner/models/partnerModel.dart';
import 'package:lingkung_partner/screens/profileDetail/trashReceive/addTrashReceive.dart';
import 'package:lingkung_partner/utilities/colorStyle.dart';
import 'package:lingkung_partner/utilities/loading.dart';
import 'package:lingkung_partner/utilities/textStyle.dart';
import 'package:lingkung_partner/widgets/trashReceiveLisTile.dart';

class TrashReceivePage extends StatefulWidget {
  final PartnerModel partnerModel;
  TrashReceivePage({this.partnerModel});
  @override
  _TrashReceivePageState createState() => _TrashReceivePageState();
}

class _TrashReceivePageState extends State<TrashReceivePage> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : SafeArea(
            top: false,
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: green,
                elevation: 0.0,
                iconTheme: IconThemeData(color: white),
                title: CustomText(
                  text: 'Jenis Sampah',
                  size: 18.0,
                  color: white,
                  weight: FontWeight.w600,
                ),
                actions: <Widget>[
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.help_outline),
                  ),
                ],
              ),
              floatingActionButton: FloatingActionButton.extended(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddTrashReceivePage(
                            partnerModel: widget.partnerModel),
                      ),
                    );
                  },
                  icon: Icon(CupertinoIcons.add, size: 20.0),
                  label: CustomText(
                    text: 'Tambah',
                    color: white,
                    size: 14.0,
                    weight: FontWeight.w600,
                  ),
                  backgroundColor: yellow),
              body: TrashReceiveLisTile(partnerModel: widget.partnerModel),
            ),
          );
  }
}
