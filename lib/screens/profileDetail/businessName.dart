import 'package:flutter/material.dart';
import 'package:lingkung_partner/providers/partnerProvider.dart';
import 'package:lingkung_partner/screens/profileDetail/dataVerification.dart';
import 'package:lingkung_partner/screens/authenticate/login.dart';
import 'package:lingkung_partner/services/partnerService.dart';
import 'package:lingkung_partner/utilities/colorStyle.dart';
import 'package:lingkung_partner/utilities/textStyle.dart';
import 'package:lingkung_partner/utilities/loading.dart';
import 'package:provider/provider.dart';

class AddBusinessName extends StatefulWidget {
  @override
  _AddBusinessNameState createState() => _AddBusinessNameState();
}

class _AddBusinessNameState extends State<AddBusinessName> {
  final _scaffoldStateKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  PartnerServices _partnerService = PartnerServices();

  String _businessName = '';
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    final partnerProvider = Provider.of<PartnerProvider>(context);
    return loading
        ? Loading()
        : SafeArea(
            child: Scaffold(
                key: _scaffoldStateKey,
                backgroundColor: white,
                appBar: AppBar(
                    backgroundColor: white,
                    iconTheme: IconThemeData(color: black),
                    leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () async {
                          await partnerProvider.logout();
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginPage(),
                              ));
                        },),
                    title: CustomText(
                        text: 'Data Mitra Pengelola',
                        size: 18.0,
                        weight: FontWeight.w600),
                    actions: <Widget>[
                      IconButton(
                          icon: Icon(Icons.help_outline, color: black),
                          onPressed: null)
                    ]),
                body: Form(
                    key: _formKey,
                    child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                  text: 'Nama Bank Sampah',
                                  size: 18.0,
                                  weight: FontWeight.w600),
                              CustomText(
                                  text:
                                      'Masukkan nama tempat pengelolaan Anda, ya.',
                                  size: 12.0),
                              TextFormField(
                                  textCapitalization: TextCapitalization.words,
                                  style: TextStyle(
                                      fontFamily: "Poppins",
                                      color: black),
                                  decoration: InputDecoration(
                                      counterStyle: TextStyle(
                                          fontFamily: "Poppins",
                                          color: black),
                                      hintText: 'Contoh: Lingkung Berseri',
                                      hintStyle:
                                          TextStyle(fontFamily: "Poppins"),
                                      prefixText: 'BS. ',
                                      prefixStyle: TextStyle(
                                          fontFamily: "Poppins",
                                          color: black,
                                          fontWeight: FontWeight.w500),
                                      errorStyle:
                                          TextStyle(fontFamily: "Poppins"),
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(color: blue))),
                                  onChanged: (String str) {
                                    setState(() {
                                      _businessName = str;
                                    });
                                  },
                                  validator: (value) => (value.isEmpty)
                                      ? 'Masukkan nama tempat pengelolaan Anda'
                                      : null)
                            ]))),
                bottomNavigationBar: Container(
                    height: 77.0,
                    color: white,
                    padding: const EdgeInsets.all(16.0),
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
                          save();
                        }))));
  }

  void save() async {
    final partnerProvider =
        Provider.of<PartnerProvider>(context, listen: false);
    if (_formKey.currentState.validate()) {
      setState(() => loading = true);
      if (_businessName != null) {
        _partnerService.updatePartnerData({
          "uid": partnerProvider.businessPartner.uid,
          "businessName": _businessName,
        });
        setState(() => loading = false);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => DataVerification()));
        partnerProvider.reloadPartnerModel();
        _businessName = '';
      } else {
        setState(() => loading = false);
      }
    }
  }
}
