import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lingkung_partner/contents/bankListContents.dart';
import 'package:lingkung_partner/models/bankAccountModel.dart';
import 'package:lingkung_partner/utilities/colorStyle.dart';
import 'package:lingkung_partner/utilities/textStyle.dart';
import 'package:lingkung_partner/utilities/loading.dart';
import 'package:provider/provider.dart';
import 'package:lingkung_partner/providers/partnerProvider.dart';

class BankAccount extends StatefulWidget {
  @override
  _BankAccountState createState() => _BankAccountState();
}

class _BankAccountState extends State<BankAccount> {
  final _scaffoldStateKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  bool loading = false;
  String bankName = '';
  String accountNumber = '';
  String accountName = '';
  List<DropdownMenuItem<BankAccountModel>> bankAccountDropDown;
  BankAccountModel selectedItem;

  @override
  void initState() {
    super.initState();
    bankAccountDropDown = getBankAccount(bankList);
  }

  List<DropdownMenuItem<BankAccountModel>> getBankAccount(
      List bankAccountList) {
    List<DropdownMenuItem<BankAccountModel>> items = [];
    for (BankAccountModel bankAccount in bankAccountList) {
      items.add(
        DropdownMenuItem(child: Text(bankAccount.bankName), value: bankAccount),
      );
    }
    return items;
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
                        text: 'Informasi Rekening Bank',
                        size: 18.0,
                        weight: FontWeight.w600),
                    titleSpacing: 0,
                    actions: <Widget>[
                      IconButton(
                          icon: Icon(Icons.help_outline, color: black),
                          onPressed: null)
                    ]),
                body: Form(
                    key: _formKey,
                    child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child:
                            Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
                                Widget>[
                          CustomText(
                              text: 'Nama Bank', weight: FontWeight.w700),
                          DropdownButton<BankAccountModel>(
                              hint: CustomText(
                                  text: 'Pilih Nama Bank',
                                  size: 16.0,
                                  weight: FontWeight.w500),
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 16.0,
                                  color: black),
                              isExpanded: true,
                              items: bankAccountDropDown,
                              onChanged: (value) {
                                setState(() {
                                  selectedItem = value;
                                  print(selectedItem.bankName);
                                });
                              },
                              value: selectedItem),
                          SizedBox(height: 16.0),
                          CustomText(
                              text: 'Nomor rekening', weight: FontWeight.w700),
                          TextFormField(
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                LengthLimitingTextInputFormatter(15),
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              style: TextStyle(
                                  fontFamily: "Poppins", color: black),
                              decoration: InputDecoration(
                                  isDense: true,
                                  counterStyle: TextStyle(
                                      fontFamily: "Poppins", color: black),
                                  hintText: 'Masukkan nomor rekening',
                                  hintStyle: TextStyle(fontFamily: "Poppins"),
                                  errorStyle: TextStyle(fontFamily: "Poppins"),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: blue))),
                              onChanged: (String str) {
                                setState(() {
                                  accountNumber = str;
                                });
                              },
                              validator: (value) => (value.isEmpty)
                                  ? 'Masukkan nomor rekening sesuai buku tabungan'
                                  : (value.length > 16)
                                      ? 'Batas Maksimal nomor rekening adalah 15'
                                      : null),
                          SizedBox(height: 16.0),
                          CustomText(
                              text: 'Nomor pemilik rekening',
                              weight: FontWeight.w700),
                          TextFormField(
                              textCapitalization: TextCapitalization.words,
                              style: TextStyle(
                                  fontFamily: "Poppins", color: black),
                              decoration: InputDecoration(
                                  isDense: true,
                                  counterStyle: TextStyle(
                                      fontFamily: "Poppins", color: black),
                                  hintText: 'Nama harus sesuai buku tabungan',
                                  hintStyle: TextStyle(fontFamily: "Poppins"),
                                  errorStyle: TextStyle(fontFamily: "Poppins"),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: blue))),
                              onChanged: (String str) {
                                setState(() {
                                  accountName = str;
                                });
                              },
                              validator: (value) => (value.isEmpty)
                                  ? 'Masukkan nama pemilik sesuai buku tabungan'
                                  : null)
                        ]))),
                bottomNavigationBar: Container(
                    height: 45.0,
                    margin: EdgeInsets.all(16.0),
                    child: FlatButton(
                        color: (bankName == "" &&
                                accountName == "" ||
                                accountNumber == "")
                            ? grey
                            : green,
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

  void save() async {
    final partnerProvider =
        Provider.of<PartnerProvider>(context, listen: false);
    if (_formKey.currentState.validate()) {
      setState(() => loading = true);
      bool value = await partnerProvider.addBankAccount(
          bankName: bankName,
          accountNumber: int.parse(accountNumber),
          accountName: accountName);
      if (value) {
        print("Bank Account Saved!");
        _scaffoldStateKey.currentState.showSnackBar(SnackBar(
            content: CustomText(
                text: "Saved!", color: white, weight: FontWeight.w600)));
        partnerProvider.reloadPartnerModel();
        setState(() {
          loading = false;
        });
        Navigator.pop(context);
      } else {
        print("Bank Account failed to Save!");
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
