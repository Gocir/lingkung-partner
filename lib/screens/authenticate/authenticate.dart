import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:lingkung_partner/screens/authenticate/login.dart';
import 'package:lingkung_partner/screens/authenticate/register.dart';
import 'package:lingkung_partner/utilities/colorStyle.dart';
import 'package:lingkung_partner/utilities/textStyle.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: white,
          appBar: AppBar(
              backgroundColor: white,
              elevation: 0,
              automaticallyImplyLeading: false,
              title: Row(children: [
                RotatedBox(
                    quarterTurns: 3,
                    child: CustomText(
                        text: 'mitra',
                        color: blue,
                        size: 10.0,
                        weight: FontWeight.w700)),
                Image.asset('assets/images/logos.png', height: 35.0)
              ])),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(children: <Widget>[
              Spacer(),
              Image.asset('assets/images/otentikasi.png',
                  alignment: Alignment.bottomCenter),
              SizedBox(height: 40.0),
              Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    CustomText(
                        text: 'Selamat Datang di Lingkung!',
                        size: 20.0,
                        weight: FontWeight.w700),
                    SizedBox(height: 10.0),
                    CustomText(
                        text:
                            'Solusi untuk lingkunganmu dari sampah dengan Lingkung, pasti bersih dan untung!'),
                    SizedBox(height: 16.0),
                    Row(children: <Widget>[
                      Expanded(
                          child: Container(
                              height: 50.0,
                              child: RaisedButton(
                                  color: green,
                                  elevation: 1.5,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(50.0)),
                                  child: CustomText(
                                      text: "MASUK",
                                      color: white,
                                      weight: FontWeight.w700),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => LoginPage()));
                                  }))),
                      SizedBox(width: 16.0),
                      Expanded(
                        child: Container(
                            height: 50.0,
                            child: RaisedButton(
                                color: white,
                                elevation: 1.5,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50.0),
                                    side: BorderSide(color: green, width: 3.0)),
                                child: CustomText(
                                    text: "DAFTAR",
                                    color: green,
                                    weight: FontWeight.w700),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              RegisterPage()));
                                })),
                      )
                    ]),
                    SizedBox(height: 16.0),
                    RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: 'Dengan masuk atau mendaftar, kamu menyetujui ',
                          style: TextStyle(
                              color: black,
                              fontFamily: 'Poppins',
                              fontSize: 12.0)),
                      TextSpan(
                          text: 'Ketentuan Layanan',
                          recognizer: new TapGestureRecognizer()
                            ..onTap = () {
                              // Navigator.push(context,
                              //   MaterialPageRoute(builder: (context) => TermsOfService()),);
                            },
                          style: TextStyle(
                              color: green,
                              fontFamily: 'Poppins',
                              fontSize: 12.0)),
                      TextSpan(
                          text: ' dan ',
                          style: TextStyle(
                              color: black,
                              fontFamily: 'Poppins',
                              fontSize: 12.0)),
                      TextSpan(
                          text: 'Kebijakan Privasi.',
                          recognizer: new TapGestureRecognizer()
                            ..onTap = () {
                              // Navigator.push(context,
                              //   MaterialPageRoute(builder: (context) => PrivacyPolicy()),);
                            },
                          style: TextStyle(
                              color: green,
                              fontFamily: 'Poppins',
                              fontSize: 12.0))
                    ]))
                  ])
            ]),
          ),
        ));
  }
}
