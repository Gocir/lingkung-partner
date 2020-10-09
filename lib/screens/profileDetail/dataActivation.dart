import 'package:flutter/material.dart';
import 'package:lingkung_partner/models/operationalTimeModel.dart';
import 'package:lingkung_partner/providers/partnerProvider.dart';
import 'package:lingkung_partner/providers/operationalTimeProvider.dart';
import 'package:lingkung_partner/providers/trashReceiveProvider.dart';
import 'package:lingkung_partner/screens/profileDetail/addBannerProfile.dart';
import 'package:lingkung_partner/services/partnerService.dart';
import 'package:lingkung_partner/screens/profileDetail/trashReceive/trashReceiveView.dart';
import 'package:lingkung_partner/screens/profileDetail/operationalTime/operationalTime.dart';
import 'package:lingkung_partner/main.dart';
import 'package:lingkung_partner/utilities/colorStyle.dart';
import 'package:lingkung_partner/utilities/loading.dart';
import 'package:lingkung_partner/utilities/textStyle.dart';
import 'package:provider/provider.dart';

class DataActivation extends StatefulWidget {
  @override
  _DataActivationState createState() => _DataActivationState();
}

class _DataActivationState extends State<DataActivation> {
  final _scaffoldStateKey = GlobalKey<ScaffoldState>();
  PartnerServices _partnerService = PartnerServices();

  List<String> day = ['Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu', 'Minggu'];

  bool loading = false;
  @override
  Widget build(BuildContext context) {
    final partnerProvider = Provider.of<PartnerProvider>(context);
    final timeProvider = Provider.of<OperationalTimeProvider>(context);
    final trashReceiveProvider = Provider.of<TrashReceiveProvider>(context);

    timeProvider.getDocument(partnerProvider.businessPartnerModel.id);
    // print('${timeProvider.documents.length}');
    trashReceiveProvider
        .loadTrashReceiveByPartner(partnerProvider.businessPartner.uid);
    return loading
        ? Loading()
        : SafeArea(
            child: Scaffold(
                key: _scaffoldStateKey,
                resizeToAvoidBottomPadding: false,
                appBar: AppBar(
                    backgroundColor: white,
                    iconTheme: IconThemeData(color: black),
                    automaticallyImplyLeading: false,
                    title: CustomText(
                        text: 'Aktifkan Bank Sampah Anda',
                        size: 18.0,
                        weight: FontWeight.w600),
                    actions: <Widget>[
                      IconButton(
                          icon: Icon(Icons.help_outline, color: black),
                          onPressed: null)
                    ]),
                body: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Column(
                      children: ListTile.divideTiles(context: context, tiles: [
                    ListTile(
                        isThreeLine: true,
                        leading: Icon(Icons.check_circle, color: blue),
                        title: CustomText(
                            text: 'Data Usaha', weight: FontWeight.w700),
                        subtitle: CustomText(
                            text: 'Data sudah lengkap',
                            line: 2,
                            over: TextOverflow.ellipsis,
                            size: 12.0,
                            color: grey)),
                    ListTile(
                        isThreeLine: true,
                        leading: Icon(Icons.check_circle,
                            color: (timeProvider.documents.length == 0)
                                ? grey
                                : blue),
                        title: CustomText(
                            text: 'Jam Operasional', weight: FontWeight.w700),
                        subtitle: CustomText(
                            text: (timeProvider.documents.length ==
                                    0)
                                ? 'Isi min. 1 hari buka'
                                : 'Data sudah lengkap',
                            size: 12.0,
                            color: grey),
                        trailing:
                            (timeProvider.documents.length == 0)
                                ? Container(
                                    width: 75,
                                    child: FlatButton(
                                        padding: const EdgeInsets.all(0),
                                        color: green,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: CustomText(
                                            text: 'TAMBAH',
                                            color: white,
                                            size: 12.0,
                                            weight: FontWeight.w700),
                                        onPressed: () {
                                          for (int i = 0; i < day.length; i++) {
                                              timeProvider.addTime(userId: partnerProvider.businessPartner.uid, day: day[i]);
                                          }
                                          // print(day.toString());
                                          print("THE USER ID IS: ${partnerProvider.businessPartner.uid}");
                                          partnerProvider.reloadPartnerModel();
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    OperationalTime(partnerModel: partnerProvider.businessPartnerModel),
                                              ));
                                        }))
                                : null),
                    ListTile(
                        isThreeLine: true,
                        leading: Icon(Icons.check_circle,
                            color: (trashReceiveProvider
                                    .trashReceiveByPartner.isEmpty)
                                ? grey
                                : blue),
                        title: CustomText(
                            text: 'Jenis Sampah', weight: FontWeight.w700),
                        subtitle: CustomText(
                            text: (trashReceiveProvider
                                    .trashReceiveByPartner.isEmpty)
                                ? 'Isi min. 1 jenis sampah yang diterima'
                                : 'Data sudah lengkap',
                            size: 12.0,
                            color: grey),
                        trailing: (trashReceiveProvider
                                .trashReceiveByPartner.isEmpty)
                            ? Container(
                                width: 75,
                                child: FlatButton(
                                    padding: const EdgeInsets.all(0),
                                    color: green,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: CustomText(
                                        text: 'TAMBAH',
                                        color: white,
                                        size: 12.0,
                                        weight: FontWeight.w700),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                TrashReceivePage(
                                                    partnerModel: partnerProvider
                                                        .businessPartnerModel),
                                          ));
                                    }))
                            : null),
                    ListTile(
                        isThreeLine: true,
                        leading: Icon(Icons.check_circle,
                            color:
                                (partnerProvider.businessPartnerModel?.image ==
                                        null)
                                    ? grey
                                    : blue),
                        title: CustomText(
                            text: 'Profil Bank Sampah',
                            weight: FontWeight.w700),
                        subtitle: CustomText(
                            text:
                                (partnerProvider.businessPartnerModel?.image ==
                                        null)
                                    ? 'Belum diisi'
                                    : 'Data sudah lengkap',
                            size: 12.0,
                            color: grey),
                        trailing: (partnerProvider
                                    .businessPartnerModel?.image ==
                                null)
                            ? Container(
                                width: 75,
                                child: FlatButton(
                                    padding: const EdgeInsets.all(0),
                                    color: green,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: CustomText(
                                        text: 'TAMBAH',
                                        color: white,
                                        size: 12.0,
                                        weight: FontWeight.w700),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                AddBannerProfile(),
                                          ));
                                    }))
                            : null),
                    ListTile(),
                  ]).toList()),
                ),
                bottomNavigationBar: Container(
                    height: 77.0,
                    color: white,
                    padding: const EdgeInsets.all(16.0),
                    child: FlatButton(
                        color: (timeProvider.documents.length == 0 ||
                                partnerProvider.businessPartnerModel.image == null ||
                                trashReceiveProvider.trashReceiveByPartner.isEmpty)
                            ? grey
                            : green,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: CustomText(
                            text: 'Aktifkan Sekarang',
                            color: white,
                            size: 16.0,
                            weight: FontWeight.w700),
                        onPressed: () {
                          if (timeProvider.documents.length == 0 ||
                              partnerProvider.businessPartnerModel.image == null ||
                              trashReceiveProvider.trashReceiveByPartner.isEmpty) {
                            _notCompleteBottomSheet(context);
                          } else {
                            setState(() => loading = true);
                            _partnerService.updatePartnerData({
                              "uid": partnerProvider.businessPartner.uid,
                              "accountStatus": 'Activated',
                            });
                            partnerProvider.reloadPartnerModel();
                            timeProvider.loadOperationalTime();
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MainPage()));
                            setState(() => loading = false);
                          }
                        }))));
  }
  
  void _notCompleteBottomSheet(context) {
    showModalBottomSheet<void>(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0))),
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
                        }),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                  text:
                                      'Data Anda belum lengkap. Lengkapi dulu, yuk.',
                                  size: 18.0,
                                  weight: FontWeight.w700),
                              SizedBox(height: 20.0),
                              Container(
                                height: 45,
                                child: FlatButton(
                                    color: green,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(
                                                10)),
                                    child: Center(
                                        child: CustomText(
                                            text: 'OKE',
                                            color: white,
                                            size: 16.0,
                                            weight:
                                                FontWeight.w700)),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    }),
                              )
                            ]))
                  ]));
        });
  }
}
