import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker_gallery_camera/image_picker_gallery_camera.dart';
import 'package:lingkung_partner/services/partnerService.dart';
import 'package:provider/provider.dart';
//  Providers
import 'package:lingkung_partner/providers/partnerProvider.dart';
//  Screens
import 'package:lingkung_partner/screens/addTrash.dart';
import 'package:lingkung_partner/screens/addTrashReceive.dart';
import 'package:lingkung_partner/screens/trashReceiveView.dart';
import 'package:lingkung_partner/screens/authenticate/authenticate.dart';
//  Utilities
import 'package:lingkung_partner/utilities/colorStyle.dart';
import 'package:lingkung_partner/utilities/textStyle.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File _selectedImage;
  String imageUrl;

  final FirebaseStorage storage = FirebaseStorage.instance;
  PartnerServices _partnerService = PartnerServices();

  void _getImage() async {
    File image = await ImagePickerGC.pickImage(
        context: context,
        source: ImgSource.Both,
        cameraIcon: Icon(Icons.camera_alt, color: black),
        cameraText:
            CustomText(text: 'Kamera', size: 18.0, weight: FontWeight.w600),
        galleryIcon: Icon(Icons.photo_library, color: black),
        galleryText:
            CustomText(text: 'Galeri', size: 18.0, weight: FontWeight.w600),
        barrierDismissible: true);
    if (image != null) {
      File cropped = await ImageCropper.cropImage(
          sourcePath: image.path,
          aspectRatio: CropAspectRatio(ratioX: 4, ratioY: 3),
          compressQuality: 200,
          maxWidth: 500,
          maxHeight: 500,
          compressFormat: ImageCompressFormat.jpg,
          androidUiSettings: AndroidUiSettings(
              toolbarColor: blue,
              toolbarWidgetColor: white,
              toolbarTitle: "Atur Foto",
              statusBarColor: blue,
              backgroundColor: white,
              activeControlsWidgetColor: green));

      setState(() {
        _selectedImage = cropped;
      });
    }

    if (_selectedImage != null) {
      final String picture =
          "BS${DateTime.now().millisecondsSinceEpoch.toString()}.jpg";
      StorageUploadTask task =
          storage.ref().child(picture).putFile(_selectedImage);
      StorageTaskSnapshot taskSnapshot =
          await task.onComplete.then((snapshot) => snapshot);
      task.onComplete.then((snapshot) async {
        imageUrl = await taskSnapshot.ref.getDownloadURL();
        FirebaseAuth auth = FirebaseAuth.instance;
        FirebaseUser _partner = await auth.currentUser();
        _partnerService.updatePartnerData({
          "uid": _partner.uid,
          "image": imageUrl,
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final partnerProvider = Provider.of<PartnerProvider>(context);

    return Scaffold(
      backgroundColor: blue,
      body: SingleChildScrollView(
        child: Stack(children: <Widget>[
          //BG1
          Row(
            children: <Widget>[
              Transform.translate(
                offset: Offset(-14.23, 46.85),
                child:
                    // Adobe XD layer: 'grass1' (shape)
                    Container(
                  width: 118.0,
                  height: 115.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/grass11.png"),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Transform.translate(
                offset: Offset(150, -20.93),
                child:
                    // Adobe XD layer: 'grass2' (shape)
                    Container(
                  width: 133.0,
                  height: 149.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/grass22.png"),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ],
          ),
          //BG2
          Column(
            children: <Widget>[
              //User
              Container(
                margin: EdgeInsets.only(left: 16.0, top: 44.0, right: 16.0),
                child: Row(
                  children: <Widget>[
                    Flexible(
                        flex: 1,
                        child:
                            Stack(alignment: Alignment.bottomRight, children: <
                                Widget>[
                          GestureDetector(
                            onTap: () {
                              (partnerProvider.businessPartnerModel?.image
                                          .toString() !=
                                      null)
                                  ? Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                          opaque: false,
                                          pageBuilder: (BuildContext context, _,
                                                  __) =>
                                              GestureDetector(
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Container(
                                                    width: double.infinity,
                                                    height: double.infinity,
                                                    color:
                                                        black.withOpacity(0.9),
                                                    child: Center(
                                                      child: Hero(
                                                          tag: 'ProductImage',
                                                          child: Image.network(
                                                              "${partnerProvider.businessPartnerModel?.image.toString()}",
                                                              fit: BoxFit
                                                                  .cover)),
                                                    ),
                                                  ))))
                                  : _getImage();
                            },
                            child: Hero(
                              tag: 'ProductImage',
                              child: Container(
                                height: 70.0,
                                width: 70.0,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.0),
                                    color: white,
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "assets/images/user.png"),
                                        fit: BoxFit.cover)),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20.0),
                                    child: (partnerProvider
                                                .businessPartnerModel?.image
                                                .toString() !=
                                            null)
                                        ? Image.network(
                                            "${partnerProvider.businessPartnerModel?.image.toString()}",
                                            fit: BoxFit.cover)
                                        : null),
                              ),
                            ),
                          ),
                          Container(
                              padding: EdgeInsets.all(7.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20.0),
                                  bottomRight: Radius.circular(20.0),
                                ),
                                color: black.withOpacity(0.5),
                              ),
                              child: GestureDetector(
                                child: Icon(Icons.add_a_photo,
                                    color: yellow, size: 14.0),
                                onTap: () {
                                  _getImage();
                                },
                              ))
                        ])),
                    SizedBox(width: 10.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        CustomText(
                            text:
                                'BS. ${partnerProvider.businessPartnerModel?.name}' ??
                                    'Guest Lingkung',
                            overflow: TextOverflow.fade,
                            size: 20,
                            weight: FontWeight.w700),
                        CustomText(
                          text: partnerProvider.businessPartnerModel?.email ??
                              'email@domain.hosting',
                          color: white,
                          size: 12,
                        ),
                        (partnerProvider.businessPartnerModel?.phoNumber !=
                                null)
                            ? CustomText(
                                text: '+62 ${partnerProvider.businessPartnerModel?.phoNumber}',
                                color: white,
                                size: 12,
                              )
                            : null
                      ],
                    ),
                  ],
                ),
              ),
              //Container White
              Container(
                margin: EdgeInsets.only(top: 66.0),
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                  color: white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 50.666),
                    CustomText(text: 'Akun', weight: FontWeight.w700),
                    SizedBox(height: 5.0),
                    Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12,
                                offset: Offset(0, 0),
                                blurRadius: 3)
                          ],
                        ),
                        child: Column(
                          children: ListTile.divideTiles(
                            context: context,
                            tiles: [
                              // ListTile(
                              //   leading: Icon(Icons.add_circle_outline),
                              //   title: CustomText(
                              //       text: 'Tambah Sampah',
                              //       weight: FontWeight.w500),
                              //   trailing: Icon(
                              //     Icons.chevron_right,
                              //     color: grey,
                              //   ),
                              //   dense: true,
                              //   onTap: () {
                              //     Navigator.push(
                              //         context,
                              //         MaterialPageRoute(
                              //           builder: (context) => AddTrashPage(),
                              //         ));
                              //   },
                              // ),
                              ListTile(
                                leading: Image.asset("assets/icons/wastetypeColor.png"),
                                title: CustomText(
                                    text: 'Jenis Sampah',
                                    weight: FontWeight.w500),
                                trailing: Icon(
                                  Icons.chevron_right,
                                  color: grey,
                                ),
                                dense: true,
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            TrashReceivePage(partnerModel: partnerProvider.businessPartnerModel),
                                      ));
                                },
                              ),
                              ListTile(
                                leading: Image.asset("assets/icons/operationalColor.png"),
                                title: CustomText(
                                    text: 'Waktu Operasional',
                                    weight: FontWeight.w500),
                                trailing: Icon(
                                  Icons.chevron_right,
                                  color: grey,
                                ),
                                dense: true,
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            AddTrashPage(),
                                      ));
                                },
                              ),
                              ListTile(
                                leading: Image.asset("assets/icons/performanceColor.png"),
                                title: CustomText(
                                    text: 'Performa', weight: FontWeight.w500),
                                trailing: Icon(
                                  Icons.chevron_right,
                                  color: grey,
                                ),
                                dense: true,
                                onTap: () {
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //       builder: (context) =>
                                  //           AddTrashReceivePage(),
                                  //     ));
                                },
                              ),
                            ],
                          ).toList(),
                        )),
                    SizedBox(
                      height: 16.0,
                    ),
                    CustomText(text: 'Info lainnya', weight: FontWeight.w700),
                    SizedBox(height: 5.0),
                    Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12,
                                offset: Offset(0, 0),
                                blurRadius: 3)
                          ],
                        ),
                        child: Column(
                          children: ListTile.divideTiles(
                            context: context,
                            tiles: [
                              ListTile(
                                leading:
                                    Image.asset("assets/icons/helpsColor.png"),
                                title: CustomText(
                                  text: 'Bantuan',
                                  weight: FontWeight.w500,
                                ),
                                trailing: Icon(
                                  Icons.chevron_right,
                                  color: grey,
                                ),
                                dense: true,
                                onTap: () {
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //       builder: (context) => HelpFeatureList(),
                                  //     ));
                                },
                              ),
                              ListTile(
                                leading: Image.asset(
                                    "assets/icons/contactColor.png"),
                                title: CustomText(
                                  text: 'Hubungi Kami',
                                  weight: FontWeight.w500,
                                ),
                                trailing: Icon(
                                  Icons.chevron_right,
                                  color: grey,
                                ),
                                dense: true,
                                onTap: () {
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //       builder: (context) => ContactUs(),
                                  //     ));
                                },
                              ),
                              ListTile(
                                leading:
                                    Image.asset("assets/icons/tosColor.png"),
                                title: CustomText(
                                  text: 'Ketentuan Layanan',
                                  weight: FontWeight.w500,
                                ),
                                trailing: Icon(
                                  Icons.chevron_right,
                                  color: grey,
                                ),
                                dense: true,
                                onTap: () {
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //       builder: (context) => TermsOfService(),
                                  //     ));
                                },
                              ),
                              ListTile(
                                leading: Image.asset(
                                    "assets/icons/privacyColor.png"),
                                title: CustomText(
                                  text: 'Kebijakan Privacy',
                                  weight: FontWeight.w500,
                                ),
                                trailing: Icon(
                                  Icons.chevron_right,
                                  color: grey,
                                ),
                                dense: true,
                                onTap: () {
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //       builder: (context) => PrivacyPolicy(),
                                  //     ));
                                },
                              ),
                              ListTile(
                                leading:
                                    Image.asset("assets/icons/phoneColor.png"),
                                title: CustomText(
                                  text: 'Versi',
                                  weight: FontWeight.w500,
                                ),
                                trailing: CustomText(
                                  text: '1.1.1',
                                  color: grey,
                                  size: 12.0,
                                ),
                                dense: true,
                              ),
                            ],
                          ).toList(),
                        )),
                    SizedBox(height: 16.0),
                    Container(
                      height: 45.0,
                      child: RaisedButton(
                        color: green,
                        elevation: 2.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Center(
                            child: CustomText(
                                text: 'KELUAR',
                                size: 16.0,
                                color: white,
                                weight: FontWeight.w700)),
                        onPressed: () async {
                          await partnerProvider.logout();
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Authenticate(),
                              ));
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          //BG3
          Container(
            height: 100.0,
            margin: EdgeInsets.only(left: 16.0, top: 130.0, right: 16.0),
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: white,
              boxShadow: [
                BoxShadow(
                    color: Colors.black12, offset: Offset(0, 0), blurRadius: 6)
              ],
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Image.asset("assets/icons/balanceColor.png"),
                      CustomText(text: 'Saldo'),
                      CustomText(
                        text: '0',
                        weight: FontWeight.w600,
                      )
                    ],
                  ),
                  VerticalDivider(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Image.asset("assets/icons/peopleColor.png"),
                      CustomText(text: 'Nasabah'),
                      CustomText(
                        text: '0',
                        weight: FontWeight.w600,
                      )
                    ],
                  ),
                  VerticalDivider(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Image.asset("assets/icons/weightColor.png"),
                      CustomText(text: 'Sampah'),
                      CustomText(
                        text: '0',
                        weight: FontWeight.w600,
                      )
                    ],
                  )
                ]),
          )
        ]),
      ),
    );
  }
}
