import 'package:flutter/material.dart';
import 'package:lingkung_partner/main.dart';
import 'package:lingkung_partner/providers/partnerProvider.dart';
import 'package:lingkung_partner/utilities/colorStyle.dart';
import 'package:lingkung_partner/utilities/textStyle.dart';
import 'package:lingkung_partner/widgets/loading.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
                        CustomText(text: 'Bantuan', size: 12.0, color: white),
                      ],
                    ),
                    onPressed: () {
                      // Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //         builder: (context) => HelpRegisterList(),
                      //       ));
                    },
                  ),
                ),
              ],
            ),
            body: SingleChildScrollView(
                          child: Container(
                margin: EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                        child: CustomText(
                            text:
                                'Lengkapi data pengelola bank sampah di bawah ini',
                            size: 22.0,
                            weight: FontWeight.w700)),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: TextFormField(
                              controller: authProvider.name,
                              decoration: InputDecoration(
                                labelText: 'Nama Bank Sampah',
                                labelStyle: TextStyle(
                                    color: grey,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16.0),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: blue)),
                              ),
                              validator: (val) => val.isEmpty
                                  ? 'Isi tanpa awalan Bank Sampah'
                                  : null,
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            child: TextFormField(
                              controller: authProvider.phoNumber,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: 'Nomor HP',
                                labelStyle: TextStyle(
                                    color: grey,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16.0),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: blue)),
                              ),
                              validator: (val) => val.length < 11
                                  ? 'Panjangnya harus lebih dari 11'
                                  : null,
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            child: TextFormField(
                              controller: authProvider.address,
                              decoration: InputDecoration(
                                labelText: 'Alamat Bank Sampah',
                                labelStyle: TextStyle(
                                    color: grey,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16.0),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: blue)),
                              ),
                              maxLines: 3,
                              validator: (val) => val.isEmpty
                                  ? 'Isi Alamat hingga kel., kec., kab., prov., kode POS'
                                  : null,
                            ),
                          ),
                          SizedBox(height: 10),
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
                              validator: (val) => val.isEmpty
                                  ? 'Gunakan email bank sampah/milik direktur'
                                  : null,
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
                          SizedBox(height: 10),
                          Container(
                            height: 45.0,
                            margin: EdgeInsets.only(top: 30.0, bottom: 16.0),
                            child: RaisedButton(
                                color: green,
                                elevation: 2.0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50)),
                                child: Center(
                                  child: CustomText(
                                      text: 'DAFTAR',
                                      color: white,
                                      weight: FontWeight.w700),
                                ),
                                onPressed: () async {
                                  if (_formKey.currentState.validate()) {
                                    setState(() => loading = true);
                                    dynamic result =
                                        await authProvider.register();
                                    if (result != null) {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                MainPage()),
                                      );
                                      authProvider.clearController();
                                    } else {
                                      setState(() {
                                        _scaffoldStateKey.currentState
                                            .showSnackBar(SnackBar(
                                                content: CustomText(
                                          text: "Tolong isi data dengan benar",
                                          color: white,
                                          weight: FontWeight.w600,
                                        )));
                                        loading = false;
                                      });
                                    }
                                  }
                                }),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
