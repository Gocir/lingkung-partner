import 'package:country_code_picker/country_code_picker.dart';
import 'package:lingkung_partner/models/partnerModel.dart';
import 'package:lingkung_partner/providers/partnerProvider.dart';
import 'package:lingkung_partner/screens/authenticate/register.dart';
import 'package:lingkung_partner/services/partnerService.dart';
import 'package:lingkung_partner/utilities/colorStyle.dart';
import 'package:lingkung_partner/utilities/textStyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _scaffoldStateKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  PartnerServices _partnerService = PartnerServices();

  String dialCode;
  String smsCode;
  String verificationId;
  String errorMessage;
  String phoneNumber;
  String phoneNumberLogin;
  bool loading = false;

  List<PartnerModel> partnerByPhone = [];

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

  void _phoneNumberChange(String number) {
    //T0D0 : manipulate the selected country code here
    // print("phoneNumber is ${number.toString()}");
    phoneNumber = dialCode + number;
  }

  @override
  Widget build(BuildContext context) {
    final partnerProvider = Provider.of<PartnerProvider>(context);
    partnerProvider.loadUserByPhone(phoneNumber);
    return SafeArea(
      top: false,
      child: Scaffold(
        key: _scaffoldStateKey,
        backgroundColor: white,
        appBar: AppBar(
          backgroundColor: white,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Image.asset('assets/images/logos.png', height: 35.0),
          actions: [
            IconButton(
              icon: Icon(Icons.help_outline, color: black),
              onPressed: () {},
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                // Spacer(),
                Image.asset('assets/images/otentikasi.png',
                    alignment: Alignment.bottomCenter),
                SizedBox(height: 30.0),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    CustomText(
                        text: 'Selamat Datang di Lingra!',
                        size: 20.0,
                        weight: FontWeight.w700),
                    SizedBox(height: 10.0),
                    CustomText(
                        text: 'Jangkau masyarakat lebih luas dari sini.'),
                    SizedBox(height: 16.0),
                    Form(
                      key: _formKey,
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: 70.0,
                            height: 40.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.grey[200],
                            ),
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
                                prefixIcon: Icon(Icons.search),
                                hintText: 'Ketik nama negara',
                                hintStyle: TextStyle(
                                  fontFamily: "Poppins",
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50.0),
                                  borderSide: BorderSide(color: blue),
                                ),
                              ),
                              searchStyle: TextStyle(
                                  fontFamily: "Poppins",
                                  color: black,
                                  fontSize: 16.0),
                              textStyle: TextStyle(
                                  fontFamily: "Poppins", color: black),
                              dialogTextStyle: TextStyle(
                                fontFamily: "Poppins",
                                color: black,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                          SizedBox(width: 10.0),
                          Flexible(
                            flex: 2,
                            child: TextFormField(
                              controller: partnerProvider.phoNumberLogin,
                              keyboardType: TextInputType.phone,
                              inputFormatters: <TextInputFormatter>[
                                LengthLimitingTextInputFormatter(11),
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              style: TextStyle(
                                fontFamily: "Poppins",
                                color: black,
                              ),
                              decoration: InputDecoration(
                                isDense: true,
                                counterStyle: TextStyle(
                                  fontFamily: "Poppins",
                                  color: black,
                                ),
                                hintText: 'Contoh: 81234567890',
                                hintStyle: TextStyle(
                                  fontFamily: "Poppins",
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: blue),
                                ),
                              ),
                              onChanged: (String str) {
                                _phoneNumberChange(str);
                              },
                              validator: (value) => (value.isEmpty)
                                  ? 'Masukkan Nomor Ponsel-mu'
                                  : (value.length > 11 || value.length < 10)
                                      ? 'Batas Minimal Nomor Ponsel adalah 10'
                                      : null,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 48.0,
                      child: FlatButton(
                        color: green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        child: CustomText(
                            text: "MASUK",
                            color: white,
                            weight: FontWeight.w700),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            setState(() {
                              loading = true;
                            });

                            if (phoneNumber == null &&
                                partnerProvider.phoNumberLogin != null) {
                              phoneNumber = dialCode +
                                  partnerProvider.phoNumberLogin.text;
                            }

                            partnerByPhone = await _partnerService
                                .getPartnerByPhone(phoNumberLogin: phoneNumber);
                            print('phoneNumber:' + phoneNumber);
                            print(
                                'ubp:' + partnerByPhone.isNotEmpty.toString());

                            if (partnerByPhone.isEmpty) {
                              setState(() {
                                _scaffoldStateKey.currentState.showSnackBar(
                                  SnackBar(
                                    content: CustomText(
                                      text:
                                          "Nomor Anda Belum Terdaftar, Silahkan Daftar!",
                                      color: white,
                                      weight: FontWeight.w600,
                                    ),
                                  ),
                                );
                                loading = false;
                                partnerProvider.clearController();
                              });
                            } else {
                              partnerProvider.verify(
                                  context,
                                  phoneNumber,
                                  partnerProvider.userName.text,
                                  partnerProvider.email.text);
                            }
                          }
                        },
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Center(
                      child: CustomText(
                        text: 'Atau',
                        weight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 48.0,
                      child: FlatButton(
                        color: white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                          side: BorderSide(
                            color: green,
                            width: 2.0,
                          ),
                        ),
                        child: CustomText(
                          text: "DAFTAR",
                          color: green,
                          weight: FontWeight.w700,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegisterPage(),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
