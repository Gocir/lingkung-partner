import 'package:flutter/material.dart';
import 'package:lingkung_partner/screens/addTrash.dart';
import 'package:lingkung_partner/screens/addTrashReceive.dart';
import 'package:lingkung_partner/screens/trashReceiveView.dart';
import 'package:provider/provider.dart';
import 'package:lingkung_partner/providers/partnerProvider.dart';
import 'package:lingkung_partner/screens/authenticate/authenticate.dart';
import 'package:lingkung_partner/utilities/colorStyle.dart';
import 'package:lingkung_partner/utilities/textStyle.dart';

class ProfilePage extends StatefulWidget {

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    
    final partner = Provider.of<PartnerProvider>(context);

    return Scaffold(
      backgroundColor: white,
      body: Stack(children: <Widget>[
        //BG Grass
        Row(
          children: <Widget>[
            Transform.translate(
              offset: Offset(-14.23, 36.85),
              child:
                // Adobe XD layer: 'grass1' (shape)
                Container(
                width: 118.0,
                height: 115.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/grass1.png"),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            Transform.translate(
              offset: Offset(180, -20.93),
              child:
                  // Adobe XD layer: 'grass2' (shape)
                  Container(
                width: 133.0,
                height: 149.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/grass2.png"),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ],
        ),
        //ListView Vertical
        ListView(
          children: <Widget>[
            //user
            Container(
              margin: EdgeInsets.only(left: 16.0, top: 44.0, right: 16.0),
              child: Row(
                children: <Widget>[
                  Flexible(
                      flex: 1,
                      child: Container(
                        height: 60.0,
                        width: 60.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: white,
                          boxShadow: [
                            BoxShadow(
                                color: grey,
                                offset: Offset(0, 3),
                                blurRadius: 3)
                          ],
                          image: DecorationImage(
                              image: AssetImage("assets/images/user.png"),
                              fit: BoxFit.cover),
                        ),
                      )),
                  SizedBox(width: 10.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: CustomText(
                          text: 'BS. ${partner.businessPartnerModel?.name}' ?? 'Guest2020',
                          size: 22,
                          weight: FontWeight.w700
                        )
                      ),
                      Container(
                        child: CustomText(
                          text: partner.businessPartnerModel?.email ?? 'email@domain.hosting',
                          color: grey,
                          size: 12,
                          weight: FontWeight.w500,
                        )
                      ),
                    ],
                  ),
                ],
              ),
            ),
            //BG Container White
            Container(
              margin: EdgeInsets.only(top: 50.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50.0),
                  topRight: Radius.circular(50.0),
                ),
                color: white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  //Konten
                  Container(
                    margin: EdgeInsets.fromLTRB(16.0, 50.0, 16.0, 5.0),
                    child: CustomText(
                      text: 'Tambah',
                      weight: FontWeight.w700
                    )
                  ),
                  Container(
                      margin: EdgeInsets.only(
                          left: 16.0, right: 16.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: white,
                        boxShadow: [
                          BoxShadow(
                              color: black,
                              offset: Offset(0, 0),
                              blurRadius: 3)
                        ],
                      ),
                      child: Column(
                        children: ListTile.divideTiles(
                            context: context,
                            tiles: [
                              ListTile(
                                leading: Icon(Icons.timer),
                                title: CustomText(
                                  text: 'Tambah Sampah',
                                  weight: FontWeight.w500
                                ),
                                trailing: Icon(
                                  Icons.chevron_right,
                                  color: green,
                                ),
                                dense: true,
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => AddTrashPage(),
                                  ));
                                },
                              ),
                              ListTile(
                                leading: Icon(Icons.add_circle_outline),
                                title: CustomText(
                                  text: 'Jenis Sampah',
                                  weight: FontWeight.w500
                                ),
                                trailing: Icon(
                                  Icons.chevron_right,
                                  color: green,
                                ),
                                dense: true,
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => TrashReceivePage(),
                                  ));
                                },
                              ),
                              ListTile(
                                leading: Icon(Icons.add_shopping_cart),
                                title: CustomText(
                                  text: 'Jam Operasional',
                                  weight: FontWeight.w500
                                ),
                                trailing: Icon(
                                  Icons.chevron_right,
                                  color: green,
                                ),
                                dense: true,
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => AddTrashReceivePage(),
                                  ));
                                },
                              ),
                            ],
                          ).toList(),
                      )),
                  Container(
                    margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 5.0),
                    child: CustomText(
                      text: 'Akun',
                      weight: FontWeight.w700
                    )
                  ),
                  Container(
                      margin: EdgeInsets.only(
                          left: 16.0, right: 16.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: white,
                        boxShadow: [
                          BoxShadow(
                              color: black,
                              offset: Offset(0, 0),
                              blurRadius: 3)
                        ],
                      ),
                      child: Column(
                        children: ListTile.divideTiles(
                            context: context,
                            tiles: [
                              ListTile(
                                leading: Icon(Icons.update),
                                title: CustomText(
                                  text: 'Ubah Profil',
                                  weight: FontWeight.w500
                                ),
                                trailing: Icon(
                                  Icons.chevron_right,
                                  color: green,
                                ),
                                dense: true,
                                onTap: () {
                                  // Navigator.push(context, MaterialPageRoute(
                                  //   builder: (context) => AddProduct(),
                                  // ));
                                },
                              ),
                              ListTile(
                                leading: Icon(Icons.help_outline),
                                title: CustomText(
                                  text: 'Bantuan',
                                  weight: FontWeight.w500
                                ),
                                trailing: Icon(
                                  Icons.chevron_right,
                                  color: green,
                                ),
                                dense: true,
                                onTap: () {
                                  // Navigator.push(context, MaterialPageRoute(
                                  //   builder: (context) => HelpFeatureList(),
                                  // ));
                                },
                              ),
                              ListTile(
                                leading: Icon(Icons.contacts),
                                title: CustomText(
                                  text: 'Hubungi Kami',
                                  weight: FontWeight.w500
                                ),
                                trailing: Icon(
                                  Icons.chevron_right,
                                  color: green,
                                ),
                                dense: true,
                                onTap: () {
                                  // Navigator.push(context, MaterialPageRoute(
                                  //   builder: (context) => ContactUs(),
                                  // ));
                                },
                              ),
                            ],
                          ).toList(),
                      )),
                  Container(
                    margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 5.0),
                    child: CustomText(
                      text: 'Info lainnya',
                      weight: FontWeight.w700
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(
                          left: 16.0, right: 16.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: white,
                        boxShadow: [
                          BoxShadow(
                              color: black,
                              offset: Offset(0, 0),
                              blurRadius: 3)
                        ],
                      ),
                      child: Column(
                        children: ListTile.divideTiles(
                            context: context,
                            tiles: [
                              ListTile(
                                leading: Icon(Icons.info_outline),
                                title: CustomText(
                                  text: 'Ketentuan Layanan',
                                  weight: FontWeight.w500
                                ),
                                trailing: Icon(
                                  Icons.chevron_right,
                                  color: green,
                                ),
                                dense: true,
                                onTap: () {
                                  // Navigator.push(context, MaterialPageRoute(
                                  //   builder: (context) => TermsOfService(),
                                  // ));
                                },
                              ),
                              ListTile(
                                leading: Icon(Icons.lock_outline),
                                title: CustomText(
                                  text: 'Kebijakan Privacy',
                                  weight: FontWeight.w500
                                ),
                                trailing: Icon(
                                  Icons.chevron_right,
                                  color: green,
                                ),
                                dense: true,
                                onTap: () {
                                  // Navigator.push(context, MaterialPageRoute(
                                  //   builder: (context) => PrivacyPolicy(),
                                  // ));
                                },
                              ),
                              ListTile(
                                leading: Icon(Icons.smartphone),
                                title: CustomText(
                                  text: 'Versi',
                                  weight: FontWeight.w500
                                ),
                                trailing: CustomText(
                                  text: "1.1.1",
                                  size: 12,
                                  color: yellow
                                ),
                                dense: true,
                              ),
                            ],
                          ).toList(),
                      )),
                  Container(
                    height: 45.0,
                    margin: EdgeInsets.fromLTRB(16.0, 20.0, 16.0, 20.0),
                    child: RaisedButton(
                      color: green,
                      elevation: 2.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      child: Center(
                        child: CustomText(
                          text: 'KELUAR',
                          color: white,
                          weight: FontWeight.w700
                        ),
                      ),
                      onPressed: () async {
                        await partner.logout();
                        Navigator.pushReplacement(context, MaterialPageRoute(
                                    builder: (context) => Authenticate(),
                                  ));
                      },
                    ),
                  ),
                ],
              ),
            ),
            //BG Container White
          ],
        ),
        //ListView Vertical
      ]),
    );
  }
}
