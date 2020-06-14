import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:lingkung_partner/main.dart';
// Providers
import 'package:lingkung_partner/providers/partnerProvider.dart';
// Utilities
import 'package:lingkung_partner/utilities/colorStyle.dart';
import 'package:lingkung_partner/utilities/textStyle.dart';
// Widgets
import 'package:lingkung_partner/widgets/loading.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _scaffoldStateKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<PartnerProvider>(context);
    return loading
        ? Loading()
        : Scaffold(
            key: _scaffoldStateKey,
            resizeToAvoidBottomPadding: false,
            backgroundColor: white,
            appBar: AppBar(
              backgroundColor: white,
              elevation: 0.0,
              iconTheme: IconThemeData(color: black),
              actions: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 10.0, right: 16.0, bottom: 10.0),
                  height: 10.0,
                  child: RaisedButton(
                    color: green,
                    elevation: 2.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.help_outline,
                          color: white,
                          size: 26.0,
                        ),
                        SizedBox(width: 5.0),
                        CustomText(
                          text: 'Bantuan',
                          size: 12.0,
                          color: white,
                        ),
                      ],
                    ),
                    onPressed: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (context) => HelpLoginList(),
                      //     ));
                    },
                  ),
                ),
              ],
            ),
            body: Container(
              margin: EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Image.asset(
                      'assets/images/masuk.png',
                      scale: 1.25,
                    ),
                  ),
                  Container(
                    child: CustomText(
                        text:
                            'Silakan masuk dengan Email & Password yang terdaftar',
                        size: 22.0,
                        weight: FontWeight.w700),
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: TextFormField(
                            controller: authProvider.email,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              labelStyle: TextStyle(
                                  color: grey,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16.0),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: blue)),
                            ),
                            validator: (val) =>
                                val.isEmpty ? 'Masukkan email kamu' : null,
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          child: TextFormField(
                            controller: authProvider.password,
                            decoration: InputDecoration(
                              labelText: 'Kata Sandi',
                              labelStyle: TextStyle(
                                  color: grey,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16.0),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: blue)),
                            ),
                            obscureText: true,
                            validator: (val) => val.length < 8
                                ? 'Panjangnya harus lebih dari 8'
                                : null,
                          ),
                        ),
                        Container(
                          height: 45.0,
                          margin: EdgeInsets.only(top: 20.0),
                          child: RaisedButton(
                            color: green,
                            elevation: 2.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50)),
                            child: Center(
                              child: CustomText(
                                  text: 'MASUK',
                                  color: white,
                                  weight: FontWeight.w700),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                setState(() => loading = true);
                                dynamic result = await authProvider.login();
                                if (result != null) {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MainPage()),
                                  );
                                  authProvider.clearController();
                                } else {
                                  setState(() {
                                    _scaffoldStateKey.currentState
                                        .showSnackBar(SnackBar(
                                            content: CustomText(
                                      text:
                                          "Tidak dapat masuk dengan akun tersebut",
                                      color: white,
                                      weight: FontWeight.w600,
                                    )));
                                  });
                                }
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
