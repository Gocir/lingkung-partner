import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lingkung_partner/models/operationalTimeModel.dart';
import 'package:lingkung_partner/models/partnerModel.dart';
import 'package:lingkung_partner/providers/operationalTimeProvider.dart';
import 'package:lingkung_partner/screens/profileDetail/operationalTime/addTime.dart';
import 'package:lingkung_partner/utilities/colorStyle.dart';
import 'package:lingkung_partner/utilities/textStyle.dart';

class TimeListTile extends StatefulWidget {
  final String day, initial;
  final PartnerModel partnerModel;
  TimeListTile({this.day, this.initial, this.partnerModel});
  @override
  _TimeListTileState createState() => _TimeListTileState();
}

class _TimeListTileState extends State<TimeListTile> {
  String _time = "Tutup";

  @override
  Widget build(BuildContext context) {
    final timeProvider = Provider.of<OperationalTimeProvider>(context);
    timeProvider.loadTimeByDay(widget.partnerModel.id, widget.day);
    OperationalTimeModel timeModel = timeProvider.operationalTimeModel;
    return ListTile(
        dense: true,
        leading: Stack(alignment: Alignment.center, children: <Widget>[
          Icon(Icons.calendar_today, color: yellow, size: 40.0),
          Positioned(
              top: 10.0,
              child: CustomText(
                  text: '${widget.initial}',
                  color: blue,
                  size: 18.0,
                  weight: FontWeight.w700))
        ]),
        title: CustomText(text: '${widget.day}', weight: FontWeight.w700),
        subtitle: CustomText(
            text: (timeModel?.openTime == null && timeModel?.openTime == null)
                ? _time
                : '${timeModel?.openTime} - ${timeModel?.closingTime}',
            color: (timeModel?.closed == null || _time == 'Tutup')
                ? Colors.red
                : grey,
            weight: FontWeight.w600),
        trailing: Container(
            width: 40.0,
            child: FlatButton(
                padding: const EdgeInsets.all(0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: CustomText(
                    text: 'Ubah', color: green, weight: FontWeight.w700),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddTime(
                              day: widget.day,
                              partner: widget.partnerModel,
                              timeModel: timeModel)));
                })));
  }
}
