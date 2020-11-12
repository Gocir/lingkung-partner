import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lingkung_partner/providers/partnerProvider.dart';
import 'package:lingkung_partner/utilities/colorStyle.dart';
import 'package:lingkung_partner/utilities/textStyle.dart';
import 'package:lingkung_partner/utilities/loading.dart';
import 'package:provider/provider.dart';

class OwnerData extends StatefulWidget {
  @override
  _OwnerDataState createState() => _OwnerDataState();
}

class _OwnerDataState extends State<OwnerData> {
  final _scaffoldStateKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final picker = ImagePicker();

  String phoneNumberOwner = '';
  String nik = '';
  String ktpName = '';
  String npwpNumber = '';
  String npwpName = '';
  String dialCode;
  File _ktpImage;
  File _npwpImage;

  bool loading = false;
  bool isExpanded = false;

  void _onCountryChange(CountryCode countryCode) {
    //T0D0 : manipulate the selected country code here
    print("New Country selected: " + countryCode.toString());
    setState(() {
      dialCode = countryCode.toString();
    });
  }

  void _onInitCountry(CountryCode countryCode) {
    //T0D0 : manipulate the selected country code here
    print("on init ${countryCode.dialCode} ${countryCode.name}");
    dialCode = countryCode.toString();
    print(dialCode);
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : SafeArea(
            child: Scaffold(
                key: _scaffoldStateKey,
                appBar: AppBar(
                    backgroundColor: white,
                    iconTheme: IconThemeData(color: black),
                    title: CustomText(
                        text: 'Identitas Pemilik',
                        size: 18.0,
                        weight: FontWeight.w600),
                    actions: <Widget>[
                      IconButton(
                          icon: Icon(Icons.help_outline, color: black),
                          onPressed: null)
                    ]),
                body: SingleChildScrollView(
                    child: Form(
                        key: _formKey,
                        child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  CustomText(
                                      text: 'Nomor HP Pemilik',
                                      weight: FontWeight.w700),
                                  SizedBox(height: 5.0),
                                  Row(
                                    children: <Widget>[
                                      Container(
                                          width: 70.0,
                                          height: 40.0,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              color: Colors.grey[200]),
                                          child: CountryCodePicker(
                                              // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                                              onChanged: (countryCode) {
                                                _onCountryChange(countryCode);
                                              },
                                              initialSelection: 'ID',
                                              favorite: ['ID'],
                                              // optional. Shows only country name and flag
                                              showCountryOnly: true,
                                              // optional. Shows only country name and flag when popup is closed
                                              showOnlyCountryWhenClosed: false,
                                              // optional. aligns the flag and the Text left
                                              alignLeft: false,
                                              onInit: (countryCode) {
                                                _onInitCountry(countryCode);
                                              },
                                              searchDecoration: InputDecoration(
                                                  isDense: true,
                                                  prefixIcon:
                                                      Icon(Icons.search),
                                                  hintText: 'Ketik nama negara',
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50.0)),
                                                  focusedBorder: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50.0),
                                                      borderSide: BorderSide(
                                                          color: blue))),
                                              searchStyle: TextStyle(
                                                  fontFamily: "Poppins",
                                                  color: black,
                                                  fontSize: 16.0),
                                              textStyle: TextStyle(
                                                  fontFamily: "Poppins",
                                                  color: black),
                                              dialogTextStyle: TextStyle(
                                                  fontFamily: "Poppins",
                                                  color: black,
                                                  fontSize: 16.0))),
                                      SizedBox(width: 10.0),
                                      Flexible(
                                        flex: 2,
                                        child: TextFormField(
                                          keyboardType: TextInputType.phone,
                                          inputFormatters: <TextInputFormatter>[
                                            LengthLimitingTextInputFormatter(
                                                11),
                                            FilteringTextInputFormatter
                                                .digitsOnly
                                          ],
                                          style: TextStyle(
                                              fontFamily: "Poppins",
                                              color: black),
                                          decoration: InputDecoration(
                                              isDense: true,
                                              counterStyle: TextStyle(
                                                  fontFamily: "Poppins",
                                                  color: black),
                                              hintText: 'Contoh: 81234567890',
                                              hintStyle: TextStyle(
                                                  fontFamily: "Poppins"),
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: blue))),
                                          onChanged: (String str) {
                                            setState(() {
                                              phoneNumberOwner = str;
                                            });
                                          },
                                          validator: (value) => (value.isEmpty)
                                              ? 'Masukkan Nomor Ponsel-mu'
                                              : (value.length > 11 ||
                                                      value.length < 10)
                                                  ? 'Batas Minimal Nomor Ponsel adalah 11'
                                                  : null,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 16.0),
                                  Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        CustomText(
                                            text: 'Unggah foto KTP',
                                            weight: FontWeight.w700),
                                        Container(
                                            height: 30.0,
                                            child: OutlineButton(
                                                color: white,
                                                highlightColor: white,
                                                highlightedBorderColor: green,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                borderSide: BorderSide(
                                                    color: green, width: 1.5),
                                                child: CustomText(
                                                    text: 'UNGGAH',
                                                    color: green,
                                                    size: 12.0,
                                                    weight: FontWeight.w700),
                                                onPressed: () {
                                                  _uploadKTPModalBottomSheet(
                                                      context);
                                                }))
                                      ]),
                                  SizedBox(height: 10.0),
                                  Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 150.0,
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          child: widgetKTP())),
                                  SizedBox(height: 16.0),
                                  CustomText(
                                      text: 'NIK sesuai KTP',
                                      weight: FontWeight.w700),
                                  TextFormField(
                                      keyboardType: TextInputType.number,
                                      style: TextStyle(
                                          fontFamily: "Poppins", color: black),
                                      inputFormatters: <TextInputFormatter>[
                                        LengthLimitingTextInputFormatter(16),
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      decoration: InputDecoration(
                                          isDense: true,
                                          counterStyle: TextStyle(
                                              fontFamily: "Poppins",
                                              color: black),
                                          hintText:
                                              'Masukkan NIK sesuai KTP Pemilik',
                                          hintStyle:
                                              TextStyle(fontFamily: "Poppins"),
                                          errorStyle:
                                              TextStyle(fontFamily: "Poppins"),
                                          focusedBorder: UnderlineInputBorder(
                                              borderSide:
                                                  BorderSide(color: blue))),
                                      onChanged: (String str) {
                                        setState(() {
                                          nik = str;
                                        });
                                      },
                                      validator: (value) => (value.isEmpty)
                                          ? 'Masukkan NIK sesuai KTP Anda'
                                          : (value.length > 16)
                                              ? 'Batas Maksimal NIK adalah 16'
                                              : null),
                                  SizedBox(height: 16.0),
                                  CustomText(
                                      text: 'Nama pemilik sesuai KTP',
                                      weight: FontWeight.w700),
                                  TextFormField(
                                      textCapitalization:
                                          TextCapitalization.words,
                                      style: TextStyle(
                                          fontFamily: "Poppins", color: black),
                                      decoration: InputDecoration(
                                          isDense: true,
                                          counterStyle: TextStyle(
                                              fontFamily: "Poppins",
                                              color: black),
                                          hintText:
                                              'Masukkan nama pemilik sesuai KTP',
                                          hintStyle:
                                              TextStyle(fontFamily: "Poppins"),
                                          errorStyle:
                                              TextStyle(fontFamily: "Poppins"),
                                          focusedBorder: UnderlineInputBorder(
                                              borderSide:
                                                  BorderSide(color: blue))),
                                      onChanged: (String str) {
                                        setState(() {
                                          ktpName = str;
                                        });
                                      },
                                      validator: (value) => (value.isEmpty)
                                          ? 'Masukkan nama pemilik sesuai KTP Anda'
                                          : null),
                                  Card(
                                      margin: const EdgeInsets.fromLTRB(
                                          0, 16.0, 0, 5.0),
                                      child: ExpansionTile(
                                          tilePadding: const EdgeInsets.only(
                                              left: 8.0, right: 8.0),
                                          title: CustomText(
                                              text: 'Anda punya NPWP?',
                                              color: isExpanded ? blue : black,
                                              weight: FontWeight.w700),
                                          trailing: Icon(Icons.check_circle,
                                              color: isExpanded ? blue : grey),
                                          childrenPadding:
                                              const EdgeInsets.all(8.0),
                                          onExpansionChanged: (bool expanding) {
                                            setState(() {
                                              this.isExpanded = expanding;
                                            });
                                          },
                                          expandedCrossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  CustomText(
                                                      text: 'Unggah foto NPWP',
                                                      weight: FontWeight.w700),
                                                  Container(
                                                      height: 30.0,
                                                      child: OutlineButton(
                                                          color: white,
                                                          highlightColor: white,
                                                          highlightedBorderColor:
                                                              green,
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10)),
                                                          borderSide:
                                                              BorderSide(
                                                                  color: green,
                                                                  width: 1.5),
                                                          child: CustomText(
                                                              text: 'UNGGAH',
                                                              color: green,
                                                              size: 12.0,
                                                              weight: FontWeight
                                                                  .w700),
                                                          onPressed: () {
                                                            _uploadNPWPModalBottomSheet(
                                                                context);
                                                          }))
                                                ]),
                                            SizedBox(height: 10.0),
                                            Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: 150.0,
                                                child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0),
                                                    child: widgetNPWP())),
                                            SizedBox(height: 16.0),
                                            CustomText(
                                                text: 'Nomor NPWP',
                                                weight: FontWeight.w700),
                                            TextFormField(
                                                keyboardType: TextInputType
                                                    .number,
                                                style: TextStyle(
                                                    fontFamily: "Poppins",
                                                    color: black),
                                                inputFormatters: <
                                                    TextInputFormatter>[
                                                  LengthLimitingTextInputFormatter(
                                                      15),
                                                  FilteringTextInputFormatter
                                                      .digitsOnly
                                                ],
                                                decoration: InputDecoration(
                                                    isDense: true,
                                                    counterStyle: TextStyle(
                                                        fontFamily: "Poppins",
                                                        color: black),
                                                    hintText:
                                                        'Masukkan nomor NPWP Anda',
                                                    hintStyle: TextStyle(
                                                        fontFamily: "Poppins"),
                                                    errorStyle: TextStyle(
                                                        fontFamily: "Poppins"),
                                                    focusedBorder:
                                                        UnderlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                                    color:
                                                                        blue))),
                                                onChanged: (String str) {
                                                  setState(() {
                                                    (isExpanded)
                                                        ? npwpNumber = str
                                                        : npwpNumber = "";
                                                  });
                                                },
                                                validator: (value) => (isExpanded &&
                                                        value.isEmpty)
                                                    ? 'Masukkan nomor NPWP dengan benar'
                                                    : (isExpanded &&
                                                            value.length > 15)
                                                        ? 'Batas maksimal nomor NPWP adalah 15'
                                                        : null),
                                            SizedBox(height: 16.0),
                                            CustomText(
                                                text:
                                                    'Nama pemilik sesuai NPWP',
                                                weight: FontWeight.w700),
                                            TextFormField(
                                                textCapitalization:
                                                    TextCapitalization.words,
                                                style: TextStyle(
                                                    fontFamily: "Poppins",
                                                    color: black),
                                                decoration: InputDecoration(
                                                    isDense: true,
                                                    counterStyle: TextStyle(
                                                        fontFamily: "Poppins",
                                                        color: black),
                                                    hintText:
                                                        'Masukkan nama pemilik sesuai NPWP',
                                                    hintStyle: TextStyle(
                                                        fontFamily: "Poppins"),
                                                    errorStyle: TextStyle(
                                                        fontFamily: "Poppins"),
                                                    focusedBorder:
                                                        UnderlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                                    color:
                                                                        blue))),
                                                onChanged: (String str) {
                                                  setState(() {
                                                    (isExpanded)
                                                        ? npwpName = str
                                                        : npwpName = "";
                                                  });
                                                },
                                                validator: (value) => (isExpanded &&
                                                        value.isEmpty)
                                                    ? 'Masukkan nama sesuai NPWP Anda'
                                                    : null)
                                          ]))
                                ])))),
                bottomNavigationBar: Container(
                    height: 45.0,
                    margin: EdgeInsets.all(16.0),
                    child: FlatButton(
                        color: green,
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

  void _uploadKTPModalBottomSheet(context) {
    showModalBottomSheet<void>(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0))),
        context: context,
        builder: (BuildContext context) {
          return Column(
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
                              text: 'Panduan Unggah KTP',
                              size: 18.0,
                              weight: FontWeight.w700),
                          SizedBox(height: 20.0),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Stack(
                                    alignment: Alignment.bottomRight,
                                    children: <Widget>[
                                      Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2.3,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              3.5,
                                          padding: const EdgeInsets.only(
                                              right: 10.0, bottom: 10.0),
                                          child: Image.asset(
                                              "assets/images/noimage.png",
                                              fit: BoxFit.fill)),
                                      Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              color: white),
                                          child: Icon(Icons.check_circle,
                                              color: green))
                                    ]),
                                Stack(
                                    alignment: Alignment.bottomRight,
                                    children: <Widget>[
                                      Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2.3,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              3.5,
                                          padding: const EdgeInsets.only(
                                              right: 10.0, bottom: 10.0),
                                          child: Image.asset(
                                              "assets/images/noimage.png",
                                              fit: BoxFit.fill)),
                                      Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              color: white),
                                          child: Icon(Icons.cancel,
                                              color: Colors.red))
                                    ]),
                              ]),
                          SizedBox(height: 10.0),
                          CustomText(
                              text:
                                  'Pastikan Anda unggah foto KTP asli, bukan hasil scan ataupun fotokopi.'),
                          SizedBox(height: 10.0),
                          CustomText(text: 'Pastikan KTP Anda masih valid.'),
                          SizedBox(height: 10.0),
                          CustomText(text: 'Pastikan KTP terlihat jelas.'),
                          SizedBox(height: 16.0),
                          Container(
                              height: 45.0,
                              color: white,
                              child: FlatButton(
                                  color: green,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Center(
                                      child: CustomText(
                                          text: 'LANJUT',
                                          color: white,
                                          size: 16.0,
                                          weight: FontWeight.w700)),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    _getImageKTP(ImageSource.camera);
                                  }))
                        ]))
              ]);
        });
  }

  void _uploadNPWPModalBottomSheet(context) {
    showModalBottomSheet<void>(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0))),
        context: context,
        builder: (BuildContext context) {
          return Column(
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
                              text: 'Panduan Unggah NPWP',
                              size: 18.0,
                              weight: FontWeight.w700),
                          SizedBox(height: 20.0),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Stack(
                                    alignment: Alignment.bottomRight,
                                    children: <Widget>[
                                      Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2.3,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              3.5,
                                          padding: const EdgeInsets.only(
                                              right: 10.0, bottom: 10.0),
                                          child: Image.asset(
                                              "assets/images/noimage.png",
                                              fit: BoxFit.fill)),
                                      Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              color: white),
                                          child: Icon(Icons.check_circle,
                                              color: green))
                                    ]),
                                Stack(
                                    alignment: Alignment.bottomRight,
                                    children: <Widget>[
                                      Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2.3,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              3.5,
                                          padding: const EdgeInsets.only(
                                              right: 10.0, bottom: 10.0),
                                          child: Image.asset(
                                              "assets/images/noimage.png",
                                              fit: BoxFit.fill)),
                                      Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              color: white),
                                          child: Icon(Icons.cancel,
                                              color: Colors.red))
                                    ])
                              ]),
                          SizedBox(height: 10.0),
                          CustomText(
                              text:
                                  'Pastikan Anda unggah foto NPWP asli, bukan hasil scan ataupun fotokopi.'),
                          SizedBox(height: 10.0),
                          CustomText(text: 'Pastikan NPWP Anda masih valid.'),
                          SizedBox(height: 10.0),
                          CustomText(text: 'Pastikan NPWP terlihat jelas.'),
                          SizedBox(height: 16.0),
                          Container(
                              height: 45.0,
                              color: white,
                              child: FlatButton(
                                  color: green,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Center(
                                      child: CustomText(
                                          text: 'LANJUT',
                                          color: white,
                                          size: 16.0,
                                          weight: FontWeight.w700)),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    _getImageNPWP(ImageSource.camera);
                                  })),
                        ]))
              ]);
        });
  }

  Widget widgetKTP() {
    final partnerProvider =
        Provider.of<PartnerProvider>(context, listen: false);
    if (_ktpImage != null) {
      return Image.file(
        _ktpImage,
        fit: BoxFit.cover,
      );
    } else {
      return CachedNetworkImage(
          imageUrl: partnerProvider
              .businessPartnerModel?.ownerDataModel?.ktpImage
              .toString(),
          imageBuilder: (context, imageProvider) => Container(
              width: MediaQuery.of(context).size.width,
              height: 150.0,
              decoration: BoxDecoration(
                  image:
                      DecorationImage(image: imageProvider, fit: BoxFit.cover),
                  color: white,
                  borderRadius: BorderRadius.circular(5.0))),
          placeholder: (context, url) => Container(
              width: MediaQuery.of(context).size.width,
              height: 150.0,
              decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(5.0),
                  border: Border.all(color: Colors.grey[200], width: 1.0)),
              child: SpinKitThreeBounce(color: black, size: 20.0)),
          errorWidget: (context, url, error) => Container(
              width: MediaQuery.of(context).size.width,
              height: 150.0,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/noimage.png"),
                      fit: BoxFit.contain),
                  color: white,
                  border: Border.all(color: Colors.grey[200], width: 1.0),
                  borderRadius: BorderRadius.circular(5.0))));
    }
  }

  Future _getImageKTP(ImageSource source) async {
    final pickedImage = await picker.getImage(source: source);

    setState(() {
      if (pickedImage != null) {
        _ktpImage = File(pickedImage.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Widget widgetNPWP() {
    final partnerProvider =
        Provider.of<PartnerProvider>(context, listen: false);
    if (_npwpImage != null) {
      return Image.file(
        _npwpImage,
        fit: BoxFit.cover,
      );
    } else {
      return CachedNetworkImage(
          imageUrl: partnerProvider
              .businessPartnerModel?.ownerDataModel?.npwpImage
              .toString(),
          imageBuilder: (context, imageProvider) => Container(
              width: MediaQuery.of(context).size.width,
              height: 150.0,
              decoration: BoxDecoration(
                  image:
                      DecorationImage(image: imageProvider, fit: BoxFit.cover),
                  color: white,
                  borderRadius: BorderRadius.circular(5.0))),
          placeholder: (context, url) => Container(
              width: MediaQuery.of(context).size.width,
              height: 150.0,
              decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(5.0),
                  border: Border.all(color: Colors.grey[200], width: 1.0)),
              child: SpinKitThreeBounce(color: black, size: 20.0)),
          errorWidget: (context, url, error) => Container(
              width: MediaQuery.of(context).size.width,
              height: 150.0,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/noimage.png"),
                      fit: BoxFit.contain),
                  color: white,
                  border: Border.all(color: Colors.grey[200], width: 1.0),
                  borderRadius: BorderRadius.circular(5.0))));
    }
  }

  Future _getImageNPWP(ImageSource source) async {
    final pickedImage = await picker.getImage(source: source);

    setState(() {
      if (pickedImage != null) {
        _npwpImage = File(pickedImage.path);
      } else {
        print('No image selected.');
      }
    });
  }

  void save() async {
    final partnerProvider =
        Provider.of<PartnerProvider>(context, listen: false);
    if (_formKey.currentState.validate()) {
      setState(() => loading = true);
      String phoneNumber = dialCode + phoneNumberOwner;
      bool value = await partnerProvider.addOwnerData(
          phoNumberOwner: phoneNumber,
          ktpImage: _ktpImage.toString(),
          nik: int.parse(nik),
          ktpName: ktpName,
          npwpImage: _npwpImage.toString(),
          npwpNumber: (npwpNumber == "" || npwpNumber == null)
              ? 0
              : int.parse(npwpNumber),
          npwpName: npwpName);
      if (value) {
        print("Owner Saved!");
        _scaffoldStateKey.currentState.showSnackBar(
          SnackBar(
            content: CustomText(
                text: "Saved!", color: white, weight: FontWeight.w600),
          ),
        );
        partnerProvider.reloadPartnerModel();
        setState(() {
          loading = false;
        });
        Navigator.pop(context);
      } else {
        print("Owner failed to Save!");
        setState(() {
          loading = false;
        });
      }
      setState(() => loading = false);
    } else {
      setState(() => loading = false);
    }
  }
}
