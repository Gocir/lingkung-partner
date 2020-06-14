import 'package:flutter/material.dart';
import 'package:lingkung_partner/screens/addTrashReceive.dart';
import 'package:lingkung_partner/utilities/colorStyle.dart';
import 'package:lingkung_partner/utilities/textStyle.dart';
import 'package:lingkung_partner/widgets/trashReceiveLisTile.dart';

class TrashReceivePage extends StatefulWidget {
  @override
  _TrashReceivePageState createState() => _TrashReceivePageState();
}

class _TrashReceivePageState extends State<TrashReceivePage> {
  @override
  Widget build(BuildContext context) {
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
      // extendBodyBehindAppBar: true,
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: TrashReceiveLisTile()
      ),
    );
  }
}
