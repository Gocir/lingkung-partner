// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:lingkung_partner/models/operationalTimeModel.dart';
// import 'package:lingkung_partner/models/partnerModel.dart';
// import 'package:lingkung_partner/providers/operationalTimeProvider.dart';
// import 'package:lingkung_partner/screens/profileDetail/operationalTime/addTime.dart';
// import 'package:lingkung_partner/utilities/colorStyle.dart';
// import 'package:lingkung_partner/utilities/loading.dart';
// import 'package:lingkung_partner/utilities/textStyle.dart';
// import 'package:lingkung_partner/widgets/timeListTile.dart';

// class OperationalTime extends StatefulWidget {
//   final PartnerModel partnerModel;
//   OperationalTime({this.partnerModel});
//   @override
//   _OperationalTimeState createState() => _OperationalTimeState();
// }

// class _OperationalTimeState extends State<OperationalTime> {
//   final _scaffoldStateKey = GlobalKey<ScaffoldState>();

//   List<String> day = [
//     'Senin',
//     'Selasa',
//     'Rabu',
//     'Kamis',
//     'Jumat',
//     'Sabtu',
//     'Minggu'
//   ];
//   List<String> initial = ['S', 'S', 'R', 'K', 'J', 'S', 'M'];
//   // String time = "Tutup";
//   bool loading = false;

//   @override
//   Widget build(BuildContext context) {
//     // final timeProvider = Provider.of<OperationalTimeProvider>(context);

//     return loading
//         ? Loading()
//         : SafeArea(
//             top: false,
//             child: Scaffold(
//                 key: _scaffoldStateKey,
//                 resizeToAvoidBottomPadding: false,
//                 backgroundColor: white,
//                 appBar: AppBar(
//                     backgroundColor: white,
//                     iconTheme: IconThemeData(color: black),
//                     title: CustomText(
//                         text: 'Jam Operasional',
//                         size: 18.0,
//                         weight: FontWeight.w600),
//                     actions: <Widget>[
//                       IconButton(
//                           icon: Icon(Icons.help_outline, color: black),
//                           onPressed: null)
//                     ]),
//                 body:
//                 ListView.separated(
//                     padding: const EdgeInsets.all(8.0),
//                     separatorBuilder: (BuildContext context, int index) =>
//                         Divider(),
//                     itemCount: day.length,
//                     itemBuilder: (BuildContext context, int index) {
//                       // for (int i = 0; i<day.length; i++) {
//                       //   timeProvider.loadTimeByDay(widget.partnerModel.id, day[i]);
//                       // }

//                       // OperationalTimeModel timeModel = timeProvider.operationalTimeModel;
//                       return TimeListTile(day: day[index], initial: initial[index], partnerModel: widget.partnerModel);

//                     //   ListTile(
//                     //       dense: true,
//                     //       leading: Stack(
//                     //           alignment: Alignment.center,
//                     //           children: <Widget>[
//                     //             Icon(Icons.calendar_today,
//                     //                 color: yellow, size: 40.0),
//                     //             Positioned(
//                     //                 top: 10.0,
//                     //                 child: CustomText(
//                     //                     text: '${initial[index]}',
//                     //                     color: blue,
//                     //                     size: 18.0,
//                     //                     weight: FontWeight.w700))
//                     //           ]),
//                     //       title: CustomText(
//                     //           text: '${day[index]}', weight: FontWeight.w700),
//                     //       subtitle: CustomText(
//                     //           text: (timeModel?.fullTime != null) ? '${timeModel?.fullTime}' :
//                     //           (timeModel?.closed != null) ? '${timeModel?.closed}' :
//                     //           (timeModel?.openTime != null && timeModel?.openTime != null) ? '${timeModel?.openTime} - ${timeModel?.closingTime}' :
//                     //           time,
//                     //           color: (timeModel == null ||
//                     //                   timeModel?.closed != null)
//                     //               ? Colors.red
//                     //               : grey,
//                     //           weight: FontWeight.w600),
//                     //       trailing: Container(
//                     //           width: 40.0,
//                     //           child: FlatButton(
//                     //               padding: const EdgeInsets.all(0),
//                     //               shape: RoundedRectangleBorder(
//                     //                   borderRadius: BorderRadius.circular(10)),
//                     //               child: CustomText(
//                     //                   text: 'Ubah',
//                     //                   color: yellow,
//                     //                   weight: FontWeight.w700),
//                     //               onPressed: () {
//                     //                 Navigator.push(
//                     //                     context,
//                     //                     MaterialPageRoute(
//                     //                         builder: (context) => AddTime(day: day[index], partner: widget.partnerModel, timeModel: timeModel)));
//                     //               })));
//                     }),
//                 bottomNavigationBar: Container(
//                     height: 45.0,
//                     margin: EdgeInsets.all(16.0),
//                     child: FlatButton(
//                         color: yellow,
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10)),
//                         child: Center(
//                             child: CustomText(
//                                 text: 'SIMPAN',
//                                 color: white,
//                                 size: 16.0,
//                                 weight: FontWeight.w700)),
//                         onPressed: () {
//                           // save();
//                         }))));
//   }

// void save() async {
//   final partnerProvider =
//       Provider.of<PartnerProvider>(context, listen: false);
//   if (partnerProvider.businessPartnerModel.operationalTimeModel != null) {
//     setState(() => loading = true);
//     bool value = await partnerProvider.addOperationalTime(
//         monday: "Tutup",
//         tuesday: "Tutup",
//         wednesday: "Tutup",
//         thursday: "Tutup",
//         friday: "Tutup",
//         saturday: "Tutup",
//         sunday: "Tutup");
//     if (value) {
//       print("Bank Account Saved!");
//       _scaffoldStateKey.currentState.showSnackBar(SnackBar(
//           content: CustomText(
//               text: "Saved!", color: white, weight: FontWeight.w600)));
//       partnerProvider.reloadPartnerModel();
//       setState(() {
//         loading = false;
//       });
//       Navigator.pop(context);
//     } else {
//       print("Bank Account failed to Save!");
//       setState(() {
//         loading = false;
//       });
//     }
//     setState(() => loading = false);
//   } else {
//     setState(() => loading = false);
//   }
// }
// }
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lingkung_partner/models/partnerModel.dart';
import 'package:lingkung_partner/models/operationalTimeModel.dart';
import 'package:lingkung_partner/providers/operationalTimeProvider.dart';
import 'package:lingkung_partner/screens/profileDetail/operationalTime/addTime.dart';
import 'package:lingkung_partner/utilities/colorStyle.dart';
import 'package:lingkung_partner/utilities/loading.dart';
import 'package:lingkung_partner/utilities/textStyle.dart';

class OperationalTime extends StatefulWidget {
  final PartnerModel partnerModel;
  OperationalTime({this.partnerModel});
  @override
  _OperationalTimeState createState() => _OperationalTimeState();
}

class _OperationalTimeState extends State<OperationalTime> {
  final _scaffoldStateKey = GlobalKey<ScaffoldState>();

  List<String> day = [
    'Senin',
    'Selasa',
    'Rabu',
    'Kamis',
    'Jumat',
    'Sabtu',
    'Minggu'
  ];
  List<String> initial = ['S', 'S', 'R', 'K', 'J', 'S', 'M'];
  String time = "";
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final timeProvider = Provider.of<OperationalTimeProvider>(context);
    timeProvider.loadTimeByMonDay(widget.partnerModel.id, day[0]);
    OperationalTimeModel senin = timeProvider.mondayTime;
    timeProvider.loadTimeByTuesDay(widget.partnerModel.id, day[1]);
    OperationalTimeModel selasa = timeProvider.tuesdayTime;
    timeProvider.loadTimeByWednesDay(widget.partnerModel.id, day[2]);
    OperationalTimeModel rabu = timeProvider.wednesdayTime;
    timeProvider.loadTimeByThursDay(widget.partnerModel.id, day[3]);
    OperationalTimeModel kamis = timeProvider.thursdayTime;
    timeProvider.loadTimeByFriDay(widget.partnerModel.id, day[4]);
    OperationalTimeModel jumat = timeProvider.fridayTime;
    timeProvider.loadTimeBySaturDay(widget.partnerModel.id, day[5]);
    OperationalTimeModel sabtu = timeProvider.saturdayTime;
    timeProvider.loadTimeBySunDay(widget.partnerModel.id, day[6]);
    OperationalTimeModel minggu = timeProvider.sundayTime;
    return loading
        ? Loading()
        : SafeArea(
            top: false,
            child: Scaffold(
              key: _scaffoldStateKey,
              resizeToAvoidBottomPadding: false,
              backgroundColor: white,
              appBar: AppBar(
                backgroundColor: white,
                elevation: 0,
                iconTheme: IconThemeData(color: black),
                leading: IconButton(
                  icon: Icon(Icons.arrow_back, color: black),
                  onPressed: () {
                    ((senin?.fullTime == null || senin?.fullTime == "") &&
                                (senin?.closed == null ||
                                    senin?.closed == "" ||
                                    senin?.closed == "Tutup") &&
                                ((senin?.openTime == null || senin?.openTime == "") &&
                                    (senin?.closingTime == null ||
                                        senin?.closingTime == ""))) &&
                            ((selasa?.fullTime == null || selasa?.fullTime == "") &&
                                (selasa?.closed == null ||
                                    selasa?.closed == "" ||
                                    selasa?.closed == "Tutup") &&
                                ((selasa?.openTime == null || selasa?.openTime == "") &&
                                    (selasa?.closingTime == null ||
                                        selasa?.closingTime == ""))) &&
                            ((rabu?.fullTime == null || rabu?.fullTime == "") &&
                                (rabu?.closed == null ||
                                    rabu?.closed == "" ||
                                    rabu?.closed == "Tutup") &&
                                ((rabu?.openTime == null || rabu?.openTime == "") &&
                                    (rabu?.closingTime == null ||
                                        rabu?.closingTime == ""))) &&
                            ((kamis?.fullTime == null || kamis?.fullTime == "") &&
                                (kamis?.closed == null ||
                                    kamis?.closed == "" ||
                                    kamis?.closed == "Tutup") &&
                                ((kamis?.openTime == null || kamis?.openTime == "") &&
                                    (kamis?.closingTime == null ||
                                        kamis?.closingTime == ""))) &&
                            ((jumat?.fullTime == null || jumat?.fullTime == "") &&
                                (jumat?.closed == null ||
                                    jumat?.closed == "" ||
                                    jumat?.closed == "Tutup") &&
                                ((jumat?.openTime == null || jumat?.openTime == "") &&
                                    (jumat?.closingTime == null ||
                                        jumat?.closingTime == ""))) &&
                            ((sabtu?.fullTime == null || sabtu?.fullTime == "") &&
                                (sabtu?.closed == null ||
                                    sabtu?.closed == "" ||
                                    sabtu?.closed == "Tutup") &&
                                ((sabtu?.openTime == null || sabtu?.openTime == "") &&
                                    (sabtu?.closingTime == null ||
                                        sabtu?.closingTime == ""))) &&
                            ((minggu?.fullTime == null || minggu?.fullTime == "") &&
                                (minggu?.closed == null ||
                                    minggu?.closed == "" ||
                                    minggu.closed == "Tutup") &&
                                ((minggu?.openTime == null || minggu?.openTime == "") && (minggu?.closingTime == null || minggu?.closingTime == "")))
                        ? _arrowBackBottomSheet(context)
                        : Navigator.pop(context);
                  },
                ),
                title: CustomText(
                  text: 'Jam Operasional',
                  size: 18.0,
                  weight: FontWeight.w600,
                ),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.help_outline, color: black),
                    onPressed: () {},
                  ),
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: ListTile.divideTiles(
                    context: context,
                    tiles: [
                      ListTile(
                        leading: Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.calendar_today,
                              color: green,
                              size: 40.0,
                            ),
                            Positioned(
                              top: 10.0,
                              child: CustomText(
                                text: '${initial[0]}',
                                color: blue,
                                size: 18.0,
                                weight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        title: CustomText(
                          text: '${day[0]}',
                          weight: FontWeight.w700,
                        ),
                        subtitle: CustomText(
                          text: (senin?.fullTime == null ||
                                  senin?.fullTime == "")
                              ? (senin?.closed == null || senin?.closed == "")
                                  ? ((senin?.openTime == null ||
                                                  senin?.openTime == "") &&
                                              senin?.closingTime == null ||
                                          senin?.closingTime == "")
                                      ? time = "Tutup"
                                      : '${senin?.openTime} - ${senin?.closingTime}'
                                  : '${senin?.closed}'
                              : '${senin?.fullTime}',
                          color: (senin?.closed == null ||
                                  senin?.closed == "Tutup")
                              ? Colors.red
                              : grey,
                          weight: FontWeight.w600,
                        ),
                        trailing: Container(
                          width: 40.0,
                          child: FlatButton(
                            padding: const EdgeInsets.all(0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: CustomText(
                                text: 'Ubah',
                                color: yellow,
                                weight: FontWeight.w700),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddTime(
                                    day: day[0],
                                    partner: widget.partnerModel,
                                    timeModel: senin,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      ListTile(
                        leading: Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.calendar_today,
                              color: green,
                              size: 40.0,
                            ),
                            Positioned(
                              top: 10.0,
                              child: CustomText(
                                text: '${initial[1]}',
                                color: blue,
                                size: 18.0,
                                weight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        title: CustomText(
                          text: '${day[1]}',
                          weight: FontWeight.w700,
                        ),
                        subtitle: CustomText(
                          text: (selasa?.fullTime == null ||
                                  selasa?.fullTime == "")
                              ? (selasa?.closed == null || selasa?.closed == "")
                                  ? ((selasa?.openTime == null ||
                                                  selasa?.openTime == "") &&
                                              selasa?.closingTime == null ||
                                          selasa?.closingTime == "")
                                      ? time = "Tutup"
                                      : '${selasa?.openTime} - ${selasa?.closingTime}'
                                  : '${selasa?.closed}'
                              : '${selasa?.fullTime}',
                          color: (selasa?.closed == null ||
                                  selasa?.closed == "Tutup")
                              ? Colors.red
                              : grey,
                          weight: FontWeight.w600,
                        ),
                        trailing: Container(
                          width: 40.0,
                          child: FlatButton(
                            padding: const EdgeInsets.all(0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: CustomText(
                              text: 'Ubah',
                              color: yellow,
                              weight: FontWeight.w700,
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddTime(
                                    day: day[1],
                                    partner: widget.partnerModel,
                                    timeModel: selasa,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      ListTile(
                        leading: Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.calendar_today,
                              color: green,
                              size: 40.0,
                            ),
                            Positioned(
                              top: 10.0,
                              child: CustomText(
                                text: '${initial[2]}',
                                color: blue,
                                size: 18.0,
                                weight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        title: CustomText(
                          text: '${day[2]}',
                          weight: FontWeight.w700,
                        ),
                        subtitle: CustomText(
                          text: (rabu?.fullTime == null || rabu?.fullTime == "")
                              ? (rabu?.closed == null || rabu?.closed == "")
                                  ? ((rabu?.openTime == null ||
                                                  rabu?.openTime == "") &&
                                              rabu?.closingTime == null ||
                                          rabu?.closingTime == "")
                                      ? time = "Tutup"
                                      : '${rabu?.openTime} - ${rabu?.closingTime}'
                                  : '${rabu?.closed}'
                              : '${rabu?.fullTime}',
                          color:
                              (rabu?.closed == null || rabu?.closed == "Tutup")
                                  ? Colors.red
                                  : grey,
                          weight: FontWeight.w600,
                        ),
                        trailing: Container(
                          width: 40.0,
                          child: FlatButton(
                            padding: const EdgeInsets.all(0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: CustomText(
                              text: 'Ubah',
                              color: yellow,
                              weight: FontWeight.w700,
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddTime(
                                    day: day[2],
                                    partner: widget.partnerModel,
                                    timeModel: rabu,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      ListTile(
                        leading: Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.calendar_today,
                              color: green,
                              size: 40.0,
                            ),
                            Positioned(
                              top: 10.0,
                              child: CustomText(
                                text: '${initial[3]}',
                                color: blue,
                                size: 18.0,
                                weight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        title: CustomText(
                          text: '${day[3]}',
                          weight: FontWeight.w700,
                        ),
                        subtitle: CustomText(
                          text: (kamis?.fullTime == null ||
                                  kamis?.fullTime == "")
                              ? (kamis?.closed == null || kamis?.closed == "")
                                  ? ((kamis?.openTime == null ||
                                                  kamis?.openTime == "") &&
                                              kamis?.closingTime == null ||
                                          kamis?.closingTime == "")
                                      ? time = "Tutup"
                                      : '${kamis?.openTime} - ${kamis?.closingTime}'
                                  : '${kamis?.closed}'
                              : '${kamis?.fullTime}',
                          color: (kamis?.closed == null ||
                                  kamis?.closed == "Tutup")
                              ? Colors.red
                              : grey,
                          weight: FontWeight.w600,
                        ),
                        trailing: Container(
                          width: 40.0,
                          child: FlatButton(
                            padding: const EdgeInsets.all(0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: CustomText(
                              text: 'Ubah',
                              color: yellow,
                              weight: FontWeight.w700,
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddTime(
                                    day: day[3],
                                    partner: widget.partnerModel,
                                    timeModel: kamis,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      ListTile(
                        leading: Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.calendar_today,
                              color: green,
                              size: 40.0,
                            ),
                            Positioned(
                              top: 10.0,
                              child: CustomText(
                                text: '${initial[4]}',
                                color: blue,
                                size: 18.0,
                                weight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        title: CustomText(
                          text: '${day[4]}',
                          weight: FontWeight.w700,
                        ),
                        subtitle: CustomText(
                          text: (jumat?.fullTime == null ||
                                  jumat?.fullTime == "")
                              ? (jumat?.closed == null || jumat?.closed == "")
                                  ? ((jumat?.openTime == null ||
                                                  jumat?.openTime == "") &&
                                              jumat?.closingTime == null ||
                                          jumat?.closingTime == "")
                                      ? time = "Tutup"
                                      : '${jumat?.openTime} - ${jumat?.closingTime}'
                                  : '${jumat?.closed}'
                              : '${jumat?.fullTime}',
                          color: (jumat?.closed == null ||
                                  jumat?.closed == "Tutup")
                              ? Colors.red
                              : grey,
                          weight: FontWeight.w600,
                        ),
                        trailing: Container(
                          width: 40.0,
                          child: FlatButton(
                            padding: const EdgeInsets.all(0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: CustomText(
                              text: 'Ubah',
                              color: yellow,
                              weight: FontWeight.w700,
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddTime(
                                    day: day[4],
                                    partner: widget.partnerModel,
                                    timeModel: jumat,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      ListTile(
                        leading: Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.calendar_today,
                              color: green,
                              size: 40.0,
                            ),
                            Positioned(
                              top: 10.0,
                              child: CustomText(
                                text: '${initial[5]}',
                                color: blue,
                                size: 18.0,
                                weight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        title: CustomText(
                          text: '${day[5]}',
                          weight: FontWeight.w700,
                        ),
                        subtitle: CustomText(
                          text: (sabtu?.fullTime == null ||
                                  sabtu?.fullTime == "")
                              ? (sabtu?.closed == null || sabtu?.closed == "")
                                  ? ((sabtu?.openTime == null ||
                                                  sabtu?.openTime == "") &&
                                              sabtu?.closingTime == null ||
                                          sabtu?.closingTime == "")
                                      ? time = "Tutup"
                                      : '${sabtu?.openTime} - ${sabtu?.closingTime}'
                                  : '${sabtu?.closed}'
                              : '${sabtu?.fullTime}',
                          color: (sabtu?.closed == null ||
                                  sabtu?.closed == "Tutup")
                              ? Colors.red
                              : grey,
                          weight: FontWeight.w600,
                        ),
                        trailing: Container(
                          width: 40.0,
                          child: FlatButton(
                            padding: const EdgeInsets.all(0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: CustomText(
                              text: 'Ubah',
                              color: yellow,
                              weight: FontWeight.w700,
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddTime(
                                    day: day[5],
                                    partner: widget.partnerModel,
                                    timeModel: sabtu,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      ListTile(
                        leading: Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.calendar_today,
                              color: green,
                              size: 40.0,
                            ),
                            Positioned(
                              top: 10.0,
                              child: CustomText(
                                text: '${initial[6]}',
                                color: blue,
                                size: 18.0,
                                weight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        title: CustomText(
                            text: '${day[6]}', weight: FontWeight.w700),
                        subtitle: CustomText(
                          text: (minggu?.fullTime == null ||
                                  minggu?.fullTime == "")
                              ? (minggu?.closed == null || minggu?.closed == "")
                                  ? ((minggu?.openTime == null ||
                                                  minggu?.openTime == "") &&
                                              minggu?.closingTime == null ||
                                          minggu?.closingTime == "")
                                      ? time = "Tutup"
                                      : '${minggu?.openTime} - ${minggu?.closingTime}'
                                  : '${minggu?.closed}'
                              : '${minggu?.fullTime}',
                          color: (minggu?.closed == null ||
                                  minggu?.closed == "Tutup")
                              ? Colors.red
                              : grey,
                          weight: FontWeight.w600,
                        ),
                        trailing: Container(
                          width: 40.0,
                          child: FlatButton(
                            padding: const EdgeInsets.all(0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: CustomText(
                              text: 'Ubah',
                              color: yellow,
                              weight: FontWeight.w700,
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddTime(
                                      day: day[6],
                                      partner: widget.partnerModel,
                                      timeModel: minggu),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      Container()
                    ],
                  ).toList(),
                ),
              ),
              bottomNavigationBar: Container(
                height: 48.0,
                margin: EdgeInsets.all(16.0),
                child: FlatButton(
                  color: yellow,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Center(
                    child: CustomText(
                      text: 'SIMPAN',
                      color: white,
                      size: 16.0,
                      weight: FontWeight.w700,
                    ),
                  ),
                  onPressed: () {
                    ((senin?.fullTime == null || senin?.fullTime == "") &&
                                (senin?.closed == null ||
                                    senin?.closed == "" ||
                                    senin?.closed == "Tutup") &&
                                ((senin?.openTime == null || senin?.openTime == "") &&
                                    (senin?.closingTime == null ||
                                        senin?.closingTime == ""))) &&
                            ((selasa?.fullTime == null || selasa?.fullTime == "") &&
                                (selasa?.closed == null ||
                                    selasa?.closed == "" ||
                                    selasa?.closed == "Tutup") &&
                                ((selasa?.openTime == null || selasa?.openTime == "") &&
                                    (selasa?.closingTime == null ||
                                        selasa?.closingTime == ""))) &&
                            ((rabu?.fullTime == null || rabu?.fullTime == "") &&
                                (rabu?.closed == null ||
                                    rabu?.closed == "" ||
                                    rabu?.closed == "Tutup") &&
                                ((rabu?.openTime == null || rabu?.openTime == "") &&
                                    (rabu?.closingTime == null ||
                                        rabu?.closingTime == ""))) &&
                            ((kamis?.fullTime == null || kamis?.fullTime == "") &&
                                (kamis?.closed == null ||
                                    kamis?.closed == "" ||
                                    kamis?.closed == "Tutup") &&
                                ((kamis?.openTime == null || kamis?.openTime == "") &&
                                    (kamis?.closingTime == null ||
                                        kamis?.closingTime == ""))) &&
                            ((jumat?.fullTime == null || jumat?.fullTime == "") &&
                                (jumat?.closed == null ||
                                    jumat?.closed == "" ||
                                    jumat?.closed == "Tutup") &&
                                ((jumat?.openTime == null || jumat?.openTime == "") &&
                                    (jumat?.closingTime == null ||
                                        jumat?.closingTime == ""))) &&
                            ((sabtu?.fullTime == null || sabtu?.fullTime == "") &&
                                (sabtu?.closed == null ||
                                    sabtu?.closed == "" ||
                                    sabtu?.closed == "Tutup") &&
                                ((sabtu?.openTime == null || sabtu?.openTime == "") &&
                                    (sabtu?.closingTime == null ||
                                        sabtu?.closingTime == ""))) &&
                            ((minggu?.fullTime == null || minggu?.fullTime == "") &&
                                (minggu?.closed == null ||
                                    minggu?.closed == "" ||
                                    minggu.closed == "Tutup") &&
                                ((minggu?.openTime == null || minggu?.openTime == "") && (minggu?.closingTime == null || minggu?.closingTime == "")))
                        ? _arrowBackBottomSheet(context)
                        : Navigator.pop(context);
                  },
                ),
              ),
            ),
          );
  }

  void _arrowBackBottomSheet(context) {
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
          height: 186.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                    CustomText(
                      text:
                          'Isi minimal 1 hari kerja untuk tempat pengelolaan-mu.',
                      size: 18.0,
                      weight: FontWeight.w700,
                    ),
                    SizedBox(height: 20.0),
                    Container(
                      height: 48,
                      child: FlatButton(
                        color: yellow,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Center(
                          child: CustomText(
                            text: 'OKE',
                            color: white,
                            size: 16.0,
                            weight: FontWeight.w700,
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
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
