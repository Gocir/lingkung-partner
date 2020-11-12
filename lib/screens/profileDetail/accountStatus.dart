import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lingkung_partner/models/partnerModel.dart';
import 'package:lingkung_partner/providers/partnerProvider.dart';
import 'package:lingkung_partner/screens/authenticate/login.dart';
import 'package:lingkung_partner/screens/profileDetail/dataActivation.dart';
import 'package:lingkung_partner/services/partnerService.dart';
import 'package:lingkung_partner/utilities/colorStyle.dart';
import 'package:lingkung_partner/utilities/loading.dart';
import 'package:lingkung_partner/utilities/textStyle.dart';
import 'package:provider/provider.dart';

class AccountStatus extends StatefulWidget {
  @override
  _AccountStatusState createState() => _AccountStatusState();
}

class _AccountStatusState extends State<AccountStatus> {
  final _scaffoldStateKey = GlobalKey<ScaffoldState>();
  PartnerServices _partnerService = PartnerServices();

  PartnerModel partner;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final partnerProvider = Provider.of<PartnerProvider>(context);
    partner = partnerProvider.businessPartnerModel;
    return loading
        ? Loading()
        : SafeArea(
            top: false,
            child: Scaffold(
              key: _scaffoldStateKey,
              backgroundColor: white,
              appBar: AppBar(
                backgroundColor: white,
                iconTheme: IconThemeData(color: black),
                automaticallyImplyLeading: false,
                title: (partner?.businessName == null &&
                        partner?.addressModel?.addressDetail == null)
                    ? CustomText(text: 'Tunggu, sedang memuat ...')
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          CustomText(
                            text: 'BS. ${partner?.businessName}',
                            size: 18.0,
                            weight: FontWeight.w600,
                          ),
                          CustomText(
                            text: '${partner?.addressModel?.addressDetail}',
                            size: 12.0,
                            color: grey,
                          ),
                        ],
                      ),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.help_outline, color: black),
                    onPressed: () {},
                  ),
                  PopupMenuButton(
                    offset: Offset(0, 44),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        bottomLeft: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0),
                      ),
                    ),
                    itemBuilder: (BuildContext context) {
                      return [
                        PopupMenuItem(
                          child: InkWell(
                            onTap: () async {
                              await partnerProvider.logout();
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginPage(),
                                ),
                              );
                            },
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.home, color: yellow),
                                SizedBox(width: 5.0),
                                CustomText(text: 'Keluar')
                              ],
                            ),
                          ),
                        ),
                      ];
                    },
                  ),
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: (partner?.accountStatus == null ||
                          partner?.accountStatus == "Verify")
                      ? MainAxisAlignment.spaceBetween
                      : MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(
                      child: Image.asset(
                        (partner?.accountStatus == "Verify")
                            ? "assets/images/verifyAccount.png"
                            : (partner?.accountStatus == "Verification Failed")
                                ? "assets/images/verifailed.png"
                                : "assets/images/activateAccount.png",
                        height: 250.0,
                      ),
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        Positioned(
                          right: 55.0,
                          top: 11.0,
                          child: Container(
                            width: MediaQuery.of(context).size.width / 1.8,
                            child: LinearProgressIndicator(
                              minHeight: 5.0,
                              backgroundColor: grey,
                              value: (partner?.accountStatus == "Verified")
                                  ? 1.0
                                  : 0.55,
                              valueColor: AlwaysStoppedAnimation<Color>(blue),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Column(
                              children: [
                                FaIcon(
                                  FontAwesomeIcons.solidCheckCircle,
                                  color: blue,
                                ),
                                SizedBox(height: 10.0),
                                CustomText(
                                  text: 'Pendaftaran',
                                  size: 12.0,
                                  weight: FontWeight.w600,
                                ),
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                (partner?.accountStatus == "Verified")
                                    ? Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: white,
                                        ),
                                        child: FaIcon(
                                          FontAwesomeIcons.solidCheckCircle,
                                          color: blue,
                                        ),
                                      )
                                    : Container(
                                        width: 24.0,
                                        height: 24.0,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: white,
                                            width: 8.0,
                                          ),
                                          color: blue,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black12,
                                              offset: Offset(0, 2),
                                              blurRadius: 3,
                                            ),
                                          ],
                                        ),
                                      ),
                                SizedBox(height: 10.0),
                                CustomText(
                                  text: 'Verifikasi',
                                  size: 12.0,
                                  weight: FontWeight.w600,
                                ),
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                (partner?.accountStatus == "Verified")
                                    ? Container(
                                        width: 24.0,
                                        height: 24.0,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: white,
                                            width: 8.0,
                                          ),
                                          color: blue,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black12,
                                              offset: Offset(0, 2),
                                              blurRadius: 3,
                                            ),
                                          ],
                                        ),
                                      )
                                    : Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black12,
                                              offset: Offset(0, 2),
                                              blurRadius: 3,
                                            ),
                                          ],
                                        ),
                                        child: Icon(
                                          CupertinoIcons.circle_filled,
                                          color: white,
                                        ),
                                      ),
                                SizedBox(height: 10.0),
                                CustomText(
                                  text: 'Aktivasi',
                                  size: 12.0,
                                  weight: FontWeight.w600,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: (partner?.accountStatus == "Verify")
                                ? 'Data sedang di verifikasi\n'
                                : (partner?.accountStatus ==
                                        "Verification Failed")
                                    ? 'Perbaiki dulu data usahamu, ya\n'
                                    : 'Hore! Data usahamu disetujui\n',
                            style: TextStyle(
                              color: black,
                              fontSize: 18.0,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          TextSpan(
                            text: (partner?.accountStatus == "Verify")
                                ? 'Untuk tahu statusnya, cek lagi nanti di halaman ini atau tunggu notifikasi dan email dari kami.'
                                : (partner?.accountStatus ==
                                        "Verification Failed")
                                    ? 'Kami menemukan ketidakcocokan dalam data yang kamu kirim. Mohon perbaiki dulu, lalu kirim ulang.'
                                    : 'Yuk lanjut aktifkan akun-mu untuk mulai menerima pesanan penjemputan sampah.',
                            style: TextStyle(
                              color: black,
                              fontFamily: "Poppins",
                            ),
                          ),
                        ],
                      ),
                    ),
                    (partner?.accountStatus == "Verify")
                        ? Container(
                            padding: const EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                              color: green,
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Icon(Icons.timer, color: white),
                                SizedBox(width: 5.0),
                                CustomText(
                                  text: 'Proses sekitar 2 hari kerja',
                                  color: white,
                                  size: 12.0,
                                  weight: FontWeight.w600,
                                ),
                              ],
                            ),
                          )
                        : Container(),
                    (partner?.accountStatus == "Verify")
                        ? Container(
                            padding:
                                const EdgeInsets.only(top: 5.0, bottom: 5.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              border: Border.all(
                                color: Colors.grey[200],
                                width: 1.5,
                              ),
                            ),
                            child: ListTile(
                              leading: Icon(Icons.store, color: blue),
                              title: CustomText(
                                  text:
                                      'Sambil nunggu, cek data yang harus disiapin untuk aktivasi akun-mu, yuk!',
                                  size: 12.0,
                                  weight: FontWeight.w600),
                              trailing: Icon(Icons.chevron_right),
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
              bottomNavigationBar: (partner?.accountStatus == "Verify")
                  ? null
                  : Container(
                      height: 80.0,
                      color: white,
                      padding: const EdgeInsets.all(16.0),
                      child: FlatButton(
                        color: green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: CustomText(
                            text: (partner?.accountStatus ==
                                    "Verification Failed")
                                ? 'Perbaiki data usaha'
                                : 'LANJUT',
                            color: white,
                            size: 16.0,
                            weight: FontWeight.w700,
                          ),
                        ),
                        onPressed: () {
                          if (partner?.accountStatus == "Verification Failed") {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AccountStatus(),
                              ),
                            );
                          } else {
                            setState(() => loading = true);
                            _partnerService.updatePartnerData({
                              "uid": partnerProvider.businessPartner?.uid,
                              "accountStatus": 'Activate',
                            });
                            setState(() => loading = false);
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DataActivation(),
                              ),
                            );
                            partnerProvider.reloadPartnerModel();
                          }
                        },
                      ),
                    ),
            ),
          );
  }
}
