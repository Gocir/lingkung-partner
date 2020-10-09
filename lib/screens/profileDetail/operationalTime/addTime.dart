import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:lingkung_partner/models/partnerModel.dart';
import 'package:lingkung_partner/models/operationalTimeModel.dart';
import 'package:lingkung_partner/providers/partnerProvider.dart';
import 'package:lingkung_partner/providers/operationalTimeProvider.dart';
import 'package:lingkung_partner/utilities/colorStyle.dart';
import 'package:lingkung_partner/utilities/textStyle.dart';
import 'package:lingkung_partner/utilities/loading.dart';

class AddTime extends StatefulWidget {
  final String day;
  final PartnerModel partner;
  final OperationalTimeModel timeModel;
  AddTime({this.day, this.partner, this.timeModel});
  @override
  _AddTimeState createState() => _AddTimeState();
}

class _AddTimeState extends State<AddTime> {
  final _scaffoldStateKey = GlobalKey<ScaffoldState>();

  TimeOfDay _selectedTimeOpen = TimeOfDay.now();
  TimeOfDay _selectedTimeClose = TimeOfDay.now();
  String openTime = '';
  String closingTime = '';
  String fulltime = '';
  String closedtime = '';
  bool _fulltimeValue = false;
  bool _closedValue = false;
  bool _addtimeValue = false;
  bool loading = false;
  bool isSave = false;

  @override
  void initState() {
    super.initState();

    if (widget.timeModel?.fullTime == null ||
        widget.timeModel?.fullTime == "") {
      if (widget.timeModel?.closed == null || widget.timeModel?.closed == "") {
        if ((widget.timeModel?.openTime == null ||
                widget.timeModel?.openTime == "") &&
            (widget.timeModel?.closingTime == null ||
                widget.timeModel?.closingTime == "")) {
          return;
        } else {
          setState(() {
            _addtimeValue = true;
            openTime = widget.timeModel?.openTime;
            closingTime = widget.timeModel?.closingTime;
          });
        }
      } else {
        setState(() {
          _closedValue = true;
          closedtime = widget.timeModel?.closed;
        });
      }
    } else {
      setState(() {
        _fulltimeValue = true;
        fulltime = widget.timeModel?.fullTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : SafeArea(
            top: false,
            child: Scaffold(
                key: _scaffoldStateKey,
                resizeToAvoidBottomPadding: false,
                appBar: AppBar(
                    backgroundColor: white,
                    iconTheme: IconThemeData(color: black),
                    leading: IconButton(
                        icon: Icon(Icons.arrow_back, color: black),
                        onPressed: () {
                          (_fulltimeValue == false &&
                                      _closedValue == false &&
                                      _addtimeValue == false)
                              ? _arrowBackBottomSheet(context)
                              : (isSave == false) ? _notSavedBottomSheet(context) : Navigator.pop(context);
                        }),
                    title: CustomText(
                        text: 'Ubah Jadwal ${widget.day}',
                        size: 18.0,
                        weight: FontWeight.w600),
                    titleSpacing: 0,
                    actions: <Widget>[
                      IconButton(
                          icon: Icon(Icons.help_outline, color: black),
                          onPressed: null)
                    ]),
                body: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                        children:
                            ListTile.divideTiles(context: context, tiles: [
                      ListTile(
                          title: CustomText(
                              text: 'Buka 24 jam',
                              size: 16.0,
                              weight: FontWeight.w700),
                          trailing: CupertinoSwitch(
                              activeColor: blue,
                              value: _fulltimeValue,
                              onChanged: (value) {
                                if (_closedValue == false &&
                                    _addtimeValue == false) {
                                  setState(() {
                                    _fulltimeValue = value;
                                    if (_fulltimeValue == true) {
                                      fulltime = "24 Jam";
                                    } else {
                                      fulltime = "";
                                    }
                                    closedtime = "";
                                    openTime = "";
                                    closingTime = "";
                                  });
                                } else {
                                  setState(() {
                                    _fulltimeValue = value;
                                    _closedValue = false;
                                    _addtimeValue = false;
                                    if (_fulltimeValue == true) {
                                      fulltime = "24 Jam";
                                    } else {
                                      fulltime = "";
                                    }
                                    closedtime = "";
                                    openTime = "";
                                    closingTime = "";
                                  });
                                }
                              })),
                      ListTile(
                          title: CustomText(
                              text: 'Tutup',
                              size: 16.0,
                              weight: FontWeight.w700),
                          trailing: CupertinoSwitch(
                              activeColor: blue,
                              value: _closedValue,
                              onChanged: (value) {
                                if (_fulltimeValue == false &&
                                    _addtimeValue == false) {
                                  setState(() {
                                    _closedValue = value;
                                    fulltime = '';
                                    if (_closedValue == true) {
                                      closedtime = "Tutup";
                                    } else {
                                      closedtime = "";
                                    }
                                    openTime = '';
                                    closingTime = '';
                                  });
                                } else {
                                  setState(() {
                                    _closedValue = value;
                                    _fulltimeValue = false;
                                    _addtimeValue = false;
                                    fulltime = '';
                                    if (_closedValue == true) {
                                      closedtime = "Tutup";
                                    } else {
                                      closedtime = "";
                                    }
                                    openTime = '';
                                    closingTime = '';
                                  });
                                }
                              })),
                      Column(children: <Widget>[
                        ListTile(
                            title: CustomText(
                                text: 'Atur jam',
                                size: 16.0,
                                weight: FontWeight.w700),
                            trailing: CupertinoSwitch(
                                activeColor: blue,
                                value: _addtimeValue,
                                onChanged: (value) {
                                  if (_closedValue == false &&
                                      _fulltimeValue == false) {
                                    setState(() {
                                      _addtimeValue = value;
                                      fulltime = '';
                                      closedtime = '';
                                      openTime = '--:--';
                                      closingTime = '--:--';
                                    });
                                  } else {
                                    setState(() {
                                      _addtimeValue = value;
                                      _closedValue = false;
                                      _fulltimeValue = false;
                                      fulltime = '';
                                      closedtime = '';
                                      openTime = '--:--';
                                      closingTime = '--:--';
                                    });
                                  }
                                  if (_addtimeValue == false) {
                                    setState(() {
                                      openTime = "";
                                      closingTime = "";
                                    });
                                  }
                                })),
                        (_addtimeValue == false)
                            ? Container()
                            : Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      InkWell(
                                          onTap: () {
                                            _pickTimeOpen(context);
                                          },
                                          child: Column(children: <Widget>[
                                            CustomText(
                                                text: 'Buka',
                                                weight: FontWeight.w700),
                                            CustomText(
                                                text: '${openTime.toString()}',
                                                size: 18.0)
                                          ])),
                                      SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              3.5),
                                      InkWell(
                                          onTap: () {
                                            _pickTimeClose(context);
                                          },
                                          child: Column(children: <Widget>[
                                            CustomText(
                                                text: 'Tutup',
                                                weight: FontWeight.w700),
                                            CustomText(
                                                text:
                                                    '${closingTime.toString()}',
                                                size: 18.0)
                                          ]))
                                    ]))
                      ]),
                      ListTile()
                    ]).toList())),
                bottomNavigationBar: Container(
                    height: 45.0,
                    margin: EdgeInsets.all(16.0),
                    child: FlatButton(
                        color: (_fulltimeValue == false &&
                                _closedValue == false &&
                                ((openTime == '' || closingTime == '') ||
                                    (openTime == '--:--' ||
                                        closingTime == '--:--')))
                            ? grey
                            : green,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                            child: CustomText(
                                text: 'SIMPAN',
                                color: white,
                                size: 16.0,
                                weight: FontWeight.w700)),
                        onPressed: () {
                          save();
                        }))));
  }

  Future<Null> _pickTimeOpen(BuildContext context) async {
    final TimeOfDay pickTimeOpen = await showTimePicker(
        context: context,
        initialTime: _selectedTimeOpen,
        builder: (BuildContext context, Widget child) {
          return MediaQuery(
              data:
                  MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
              child: child);
        });

    MaterialLocalizations localizations = MaterialLocalizations.of(context);
    if (pickTimeOpen != null) {
      String formattedTime = localizations.formatTimeOfDay(pickTimeOpen,
          alwaysUse24HourFormat: false);
      if (formattedTime != null) {
        setState(() {
          openTime = formattedTime;
        });
      }
    }
  }

  Future<Null> _pickTimeClose(BuildContext context) async {
    final TimeOfDay pickTimeClose = await showTimePicker(
        context: context,
        initialTime: _selectedTimeClose,
        builder: (BuildContext context, Widget child) {
          return MediaQuery(
              data:
                  MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
              child: child);
        });

    MaterialLocalizations localizations = MaterialLocalizations.of(context);
    if (pickTimeClose != null) {
      String formattedTime = localizations.formatTimeOfDay(pickTimeClose,
          alwaysUse24HourFormat: false);
      if (formattedTime != null) {
        setState(() {
          closingTime = formattedTime;
        });
      }
    }
  }

  void save({String close}) async {
    final partnerProvider =
        Provider.of<PartnerProvider>(context, listen: false);
    final timeProvider =
        Provider.of<OperationalTimeProvider>(context, listen: false);
    // timeProvider.loadTimeByDay(widget.partner.id, widget.day);

    if (_fulltimeValue == false &&
        _closedValue == false &&
        close == null &&
        ((openTime == '' || closingTime == '') ||
            (openTime == '--:--' || closingTime == '--:--'))) {
      _arrowBackBottomSheet(context);
    } else {
      setState(() {
        loading = true;
        isSave = true;
      });

      bool value = await timeProvider.updateTime(
          userId: widget.partner.id,
          day: widget.day,
          fullTime: fulltime,
          closed: (close == null) ? closedtime : close,
          openTime: openTime,
          closingTime: closingTime);

      if (value) {
        print("Time is Saved!");
        partnerProvider.reloadPartnerModel();
        timeProvider.loadOperationalTime();
        _scaffoldStateKey.currentState.showSnackBar(SnackBar(
            content: CustomText(
                text: "Waktu Tersimpan",
                color: white,
                weight: FontWeight.w600)));
        Navigator.pop(context);
        setState(() => loading = false);
        return;
      } else {
        print("Failed to Save!");
        setState(() => loading = false);
      }
    }
  }

  void _arrowBackBottomSheet(context) {
    showModalBottomSheet<void>(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0))),
        context: context,
        builder: (BuildContext context) {
          return Container(
              height: 185.0,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                  text:
                                      'Hari ${widget.day} Tempat Pengelolaan Anda Tutup?',
                                  size: 18.0,
                                  weight: FontWeight.w700),
                              SizedBox(height: 20.0),
                              Container(
                                  height: 45,
                                  child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        Expanded(
                                            child: FlatButton(
                                                color: white,
                                                shape: RoundedRectangleBorder(
                                                    side: BorderSide(
                                                        color: green,
                                                        width: 2.0),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: Center(
                                                    child: CustomText(
                                                        text: 'TIDAK',
                                                        color: green,
                                                        size: 16.0,
                                                        weight:
                                                            FontWeight.w700)),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                })),
                                        SizedBox(width: 10.0),
                                        Expanded(
                                            child: FlatButton(
                                                color: green,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: Center(
                                                    child: CustomText(
                                                        text: 'YA',
                                                        color: white,
                                                        size: 16.0,
                                                        weight:
                                                            FontWeight.w700)),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                  String _close = 'Tutup';
                                                  save(close: _close);
                                                }))
                                      ]))
                            ]))
                  ]));
        });
  }

  void _notSavedBottomSheet(context) {
    showModalBottomSheet<void>(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0))),
        context: context,
        builder: (BuildContext context) {
          return Container(
              height: 185.0,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                  text:
                                      'Jadwal ${widget.day} belum tersimpan. Ingin simpan?',
                                  size: 18.0,
                                  weight: FontWeight.w700),
                              SizedBox(height: 20.0),
                              Container(
                                  height: 45,
                                  child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        Expanded(
                                            child: FlatButton(
                                                color: white,
                                                shape: RoundedRectangleBorder(
                                                    side: BorderSide(
                                                        color: green,
                                                        width: 2.0),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: Center(
                                                    child: CustomText(
                                                        text: 'TIDAK',
                                                        color: green,
                                                        size: 16.0,
                                                        weight:
                                                            FontWeight.w700)),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                  Navigator.pop(context);
                                                })),
                                        SizedBox(width: 10.0),
                                        Expanded(
                                            child: FlatButton(
                                                color: green,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: Center(
                                                    child: CustomText(
                                                        text: 'YA',
                                                        color: white,
                                                        size: 16.0,
                                                        weight:
                                                            FontWeight.w700)),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                  save();
                                                }))
                                      ]))
                            ]))
                  ]));
        });
  }
}
