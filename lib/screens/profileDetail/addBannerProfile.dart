import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker_gallery_camera/image_picker_gallery_camera.dart';
import 'package:lingkung_partner/providers/partnerProvider.dart';
import 'package:lingkung_partner/services/partnerService.dart';
import 'package:lingkung_partner/utilities/colorStyle.dart';
import 'package:lingkung_partner/utilities/loading.dart';
import 'package:lingkung_partner/utilities/textStyle.dart';
import 'package:provider/provider.dart';

class AddBannerProfile extends StatefulWidget {
  @override
  _AddBannerProfileState createState() => _AddBannerProfileState();
}

class _AddBannerProfileState extends State<AddBannerProfile> {
  final _scaffoldStateKey = GlobalKey<ScaffoldState>();
  final FirebaseStorage storage = FirebaseStorage.instance;
  PartnerServices _partnerService = PartnerServices();

  String imageUrl;
  File _bannerImage;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final partnerProvider = Provider.of<PartnerProvider>(context);
    return loading
        ? Loading()
        : SafeArea(
            child: Scaffold(
                key: _scaffoldStateKey,
                resizeToAvoidBottomPadding: false,
                backgroundColor: white,
                appBar: AppBar(
                    backgroundColor: white,
                    iconTheme: IconThemeData(color: black),
                    leading: IconButton(
                        icon: Icon(Icons.arrow_back, color: black),
                        onPressed: () {
                          Navigator.pop(context);
                          partnerProvider.reloadPartnerModel();
                        }),
                    titleSpacing: 0,
                    title: CustomText(
                        text: 'Profil Bank Sampah',
                        size: 18.0,
                        weight: FontWeight.w600),
                    actions: <Widget>[
                      IconButton(
                          icon: Icon(Icons.help_outline, color: black),
                          onPressed: null)
                    ]),
                body: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(children: <Widget>[
                    Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          CustomText(
                              text: 'Banner Usaha', weight: FontWeight.w700),
                          Container(
                              height: 30.0,
                              child: OutlineButton(
                                  color: white,
                                  highlightColor: white,
                                  highlightedBorderColor: green,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  borderSide:
                                      BorderSide(color: green, width: 1.5),
                                  child: CustomText(
                                      text: 'UNGGAH',
                                      color: green,
                                      size: 12.0,
                                      weight: FontWeight.w700),
                                  onPressed: () {
                                    _getImage();
                                  }))
                        ]),
                    SizedBox(height: 10.0),
                    widgetBanner(),
                    SizedBox(height: 10.0),
                    CustomText(
                        text:
                            'Ketentuan unggah: Harus foto papan nama atau spanduk nama identitas tempat pengelolaan tanpa watermark. Jika foto yang di unggah tidak sesuai, tim Lingkung berhak menggantinya.',
                        size: 12.0,
                        weight: FontWeight.w600),
                    // SizedBox(height: 16.0),
                    // Row(
                    //     mainAxisSize: MainAxisSize.max,
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: <Widget>[
                    //       CustomText(
                    //           text: 'Kategori sampah', weight: FontWeight.w700),
                    //       Container(
                    //           height: 30.0,
                    //           child: OutlineButton(
                    //               color: white,
                    //               highlightColor: white,
                    //               highlightedBorderColor: green,
                    //               shape: RoundedRectangleBorder(
                    //                   borderRadius: BorderRadius.circular(10)),
                    //               borderSide:
                    //                   BorderSide(color: green, width: 1.5),
                    //               child: CustomText(
                    //                   text: 'PILIH',
                    //                   color: green,
                    //                   size: 12.0,
                    //                   weight: FontWeight.w700),
                    //               onPressed: () {
                    //                 _getImage();
                    //               }))
                    //     ]),
                    // SizedBox(height: 10.0),
                  ]),
                )));
  }

  Widget widgetBanner() {
    final partnerProvider =
        Provider.of<PartnerProvider>(context, listen: false);
    if (_bannerImage != null) {
      return Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width / 2,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0)),
          child: Image.file(
            _bannerImage,
            fit: BoxFit.cover,
          ));
    } else {
      return CachedNetworkImage(
          imageUrl: partnerProvider.businessPartnerModel?.image.toString(),
          imageBuilder: (context, imageProvider) => Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width / 2,
              decoration: BoxDecoration(
                  image:
                      DecorationImage(image: imageProvider, fit: BoxFit.cover),
                  color: white,
                  borderRadius: BorderRadius.circular(5.0))),
          placeholder: (context, url) => Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width / 2,
              decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(5.0),
                  border: Border.all(color: Colors.grey[200], width: 1.0)),
              child: SpinKitThreeBounce(color: black, size: 20.0)),
          errorWidget: (context, url, error) => Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width / 2,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/noimage.png"),
                      fit: BoxFit.contain),
                  color: white,
                  border: Border.all(color: Colors.grey[200], width: 1.0),
                  borderRadius: BorderRadius.circular(5.0))));
    }
  }

  void _getImage() async {
    final partnerProvider =
        Provider.of<PartnerProvider>(context, listen: false);
    setState(() => loading = true);
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
          compressQuality: 100,
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

      setState(() => _bannerImage = cropped);
    } else {
      setState(() => loading = false);
    }

    if (_bannerImage != null) {
      final String picture =
          "BS${DateTime.now().millisecondsSinceEpoch.toString()}.jpg";
      StorageUploadTask task =
          storage.ref().child(picture).putFile(_bannerImage);
      StorageTaskSnapshot taskSnapshot =
          await task.onComplete.then((snapshot) => snapshot);
      task.onComplete.then((snapshot) async {
        imageUrl = await taskSnapshot.ref.getDownloadURL();
        _partnerService.updatePartnerData({
          "uid": partnerProvider.businessPartner.uid,
          "image": imageUrl,
        });
      });
      setState(() => loading = false);
    } else {
      setState(() => loading = false);
    }
  }
}
