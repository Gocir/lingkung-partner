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
    return Scaffold(
        backgroundColor: white,
        body: Column(children: <Widget>[
          Flexible(
              flex: 2,
              child: Container(
                margin: EdgeInsets.only(left: 16.0, top: 24.0, right: 16.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Flexible(
                        flex: 1,
                        child: Container(
                          alignment: Alignment.topLeft,
                          child: Image.asset(
                            'assets/images/logos.png',
                            height: 35.0,
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 3,
                        child: Container(
                          child: Image.asset(
                            'assets/images/otentikasi.png',
                          ),
                        ),
                      ),
                    ]),
              )),
          Flexible(
              flex: 1,
              child: Container(
                margin: EdgeInsets.fromLTRB(16.0, 30.0, 16.0, 16.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Flexible(
                        flex: 1,
                        child: Container(
                          child: CustomText(
                              text: 'Selamat Datang di Lingkung!',
                              size: 20.0,
                              weight: FontWeight.w700),
                        ),
                      ),
                      Flexible(
                          flex: 1,
                          child: Container(
                            alignment: Alignment.topCenter,
                            child: CustomText(
                                text:
                                    'Solusi untuk lingkunganmu dari sampah dengan Lingkung, pasti bersih dan untung!'),
                          )),
                      Flexible(
                          flex: 1,
                          child: Row(
                            children: <Widget>[
                              Flexible(
                                flex: 1,
                                child: Container(
                                  height: 45.0,
                                  child: RaisedButton(
                                      color: green,
                                      elevation: 2.0,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50.0)),
                                      child: Center(
                                          child: CustomText(
                                              text: "MASUK",
                                              color: white,
                                              weight: FontWeight.w700)),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => LoginPage(),
                                            ));
                                      }),
                                ),
                              ),
                              SizedBox(width: 15.0),
                              Flexible(
                                flex: 1,
                                child: Container(
                                  height: 45.0,
                                  child: RaisedButton(
                                    color: white,
                                    elevation: 2.0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(50.0),
                                        side: BorderSide(
                                            color: green, width: 3.0)),
                                    child: Center(
                                        child: CustomText(
                                            text: "DAFTAR",
                                            color: green,
                                            weight: FontWeight.w700)),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                RegisterPage(),
                                          ));
                                    },
                                  ),
                                ),
                              ),
                            ],
                          )),
                      Flexible(
                        flex: 1,
                        child: Container(
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text:
                                      'Dengan masuk atau mendaftar, kamu menyetujui ',
                                  style: TextStyle(
                                    color: black,
                                    fontFamily: 'Poppins',
                                    fontSize: 12.0,
                                  ),
                                ),
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
                                    fontSize: 12.0,
                                  ),
                                ),
                                TextSpan(
                                  text: ' dan ',
                                  style: TextStyle(
                                    color: black,
                                    fontFamily: 'Poppins',
                                    fontSize: 12.0,
                                  ),
                                ),
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
                                    fontSize: 12.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ]),
              )),
        ]));
  }
}
