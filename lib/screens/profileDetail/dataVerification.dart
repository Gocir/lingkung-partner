import 'package:flutter/material.dart';
import 'package:lingkung_partner/providers/partnerProvider.dart';
import 'package:lingkung_partner/services/partnerService.dart';
import 'package:lingkung_partner/screens/profileDetail/address/address.dart';
import 'package:lingkung_partner/screens/profileDetail/bankAccount.dart';
import 'package:lingkung_partner/screens/profileDetail/ownerData.dart';
import 'package:lingkung_partner/screens/profileDetail/accountStatus.dart';
import 'package:lingkung_partner/utilities/colorStyle.dart';
import 'package:lingkung_partner/utilities/textStyle.dart';
import 'package:lingkung_partner/utilities/loading.dart';
import 'package:provider/provider.dart';

class DataVerification extends StatefulWidget {
  @override
  _DataVerificationState createState() => _DataVerificationState();
}

class _DataVerificationState extends State<DataVerification> {
  final _scaffoldStateKey = GlobalKey<ScaffoldState>();
  PartnerServices _partnerService = PartnerServices();

  bool loading = false;
  @override
  Widget build(BuildContext context) {
    final partnerProvider = Provider.of<PartnerProvider>(context);
    return loading ? Loading() : SafeArea(
        child: Scaffold(
          key: _scaffoldStateKey,
            appBar: AppBar(
                backgroundColor: white,
                iconTheme: IconThemeData(color: black),
                automaticallyImplyLeading: false,
                title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                          text: 'Data Mitra Pengelola',
                          size: 18.0,
                          weight: FontWeight.w600),
                      CustomText(
                          text: (partnerProvider.businessPartnerModel?.businessName ==
                                  null)
                              ? 'BS. Mitra Lingkung'
                              : 'BS. ${partnerProvider.businessPartnerModel?.businessName}',
                          size: 12.0,
                          color: grey)
                    ]),
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
                  leading: Icon(Icons.check_circle,
                      color:
                          (partnerProvider.businessPartnerModel?.addressModel ==
                                  null)
                              ? grey
                              : blue),
                  title: CustomText(
                      text: 'Informasi Mitra Pengelola',
                      weight: FontWeight.w700),
                  subtitle: CustomText(
                      text: (partnerProvider.businessPartnerModel?.addressModel
                                  ?.addressDetail ==
                              null)
                          ? 'Masukkan patokan lokasi dan alamat mitra pengelola.'
                          : '${partnerProvider.businessPartnerModel?.addressModel?.addressDetail}',
                      line: 2,
                      over: TextOverflow.ellipsis,
                      size: 12.0,
                      color: grey),
                  trailing: Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Address(),
                        ));
                  },
                ),
                ListTile(
                  isThreeLine: true,
                  leading: Icon(Icons.check_circle,
                      color: (partnerProvider
                                  .businessPartnerModel?.ownerDataModel ==
                              null)
                          ? grey
                          : blue),
                  title: CustomText(
                      text: 'Informasi Pemilik', weight: FontWeight.w700),
                  subtitle: CustomText(
                      text: (partnerProvider
                                  .businessPartnerModel?.ownerDataModel ==
                              null)
                          ? 'Masukkan nomor KTP, nama, alamat sesuai KTP, dan NPWP (jika ada).'
                          : '${partnerProvider.businessPartnerModel?.ownerDataModel?.nik}, ${partnerProvider.businessPartnerModel?.ownerDataModel?.ktpName}, ${partnerProvider.businessPartnerModel?.ownerDataModel?.phoNumberOwner}',
                      size: 12.0,
                      color: grey),
                  trailing: Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OwnerData(),
                        ));
                  },
                ),
                ListTile(
                  isThreeLine: true,
                  leading: Icon(Icons.check_circle,
                      color: (partnerProvider
                                  .businessPartnerModel?.bankAccountModel ==
                              null)
                          ? grey
                          : blue),
                  title: CustomText(
                      text: 'Informasi Rekening Bank', weight: FontWeight.w700),
                  subtitle: CustomText(
                      text: (partnerProvider
                                  .businessPartnerModel?.bankAccountModel ==
                              null)
                          ? 'Masukkan nama bank dan nomor rekening usaha Anda.'
                          : '${partnerProvider.businessPartnerModel?.bankAccountModel?.bankName}, ${partnerProvider.businessPartnerModel?.bankAccountModel?.accountName}, ${partnerProvider.businessPartnerModel?.bankAccountModel?.accountNumber}',
                      size: 12.0,
                      color: grey),
                  trailing: Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BankAccount(),
                        ));
                  },
                ),
                ListTile(),
              ]).toList()),
            ),
            bottomNavigationBar: Container(
                height: 77.0,
                color: white,
                padding: const EdgeInsets.all(16.0),
                child: FlatButton(
                    color: (partnerProvider.businessPartnerModel?.addressModel == null || partnerProvider.businessPartnerModel?.ownerDataModel == null || partnerProvider.businessPartnerModel?.bankAccountModel == null) ? grey : green,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                        child: CustomText(
                            text: 'LANJUT',
                            color: white,
                            size: 16.0,
                            weight: FontWeight.w700)),
                    onPressed: () {
                      if (partnerProvider.businessPartnerModel?.addressModel != null && partnerProvider.businessPartnerModel?.ownerDataModel != null || partnerProvider.businessPartnerModel?.bankAccountModel != null) {
                        setState(() => loading = true);
                        _partnerService.updatePartnerData({
                            "uid": partnerProvider.businessPartner.uid,
                            "accountStatus": 'Verify',
                        });
                        setState(() => loading = false);
                        Navigator.pushReplacement(
                            context, MaterialPageRoute(builder: (context) => AccountStatus()));
                        partnerProvider.reloadPartnerModel();
                      }
                    }))));
  }
}
