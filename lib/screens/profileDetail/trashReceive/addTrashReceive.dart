import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lingkung_partner/services/trashReceiveService.dart';
//  Services
import 'package:lingkung_partner/services/trashService.dart';
//  Utilities
import 'package:lingkung_partner/utilities/colorStyle.dart';
import 'package:lingkung_partner/utilities/textStyle.dart';
//  Widgets
import 'package:lingkung_partner/widgets/loading.dart';

class AddTrashReceivePage extends StatefulWidget {
  @override
  _AddTrashReceivePageState createState() => _AddTrashReceivePageState();
}

class _AddTrashReceivePageState extends State<AddTrashReceivePage> {
  final _scaffoldStateKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  TrashServices _trashService = TrashServices();
  TrashReceiveServices _trashReceiveService = TrashReceiveServices();

  String currenTrash;
  String price = '';

  List<DocumentSnapshot> trashes = <DocumentSnapshot>[];
  List<DropdownMenuItem<String>> trashesDropDown = <DropdownMenuItem<String>>[];

  bool loading = false;

  @override
  void initState() {
    super.initState();
    _gettrashes();
  }

  List<DropdownMenuItem<String>> getTrashesDropdown() {
    List<DropdownMenuItem<String>> items = new List();
    for (int i = 0; i < trashes.length; i++) {
      setState(() {
        items.insert(
            0,
            DropdownMenuItem(
                child: Text(trashes[i].data['name']),
                value: trashes[i].data['name']));
      });
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            key: _scaffoldStateKey,
            resizeToAvoidBottomPadding: false,
            backgroundColor: white,
            appBar: AppBar(
              backgroundColor: blue,
              elevation: 0.0,
              iconTheme: IconThemeData(color: white),
              title: CustomText(
                text: 'Tambah Jenis Sampah',
                color: white,
                size: 18.0,
                weight: FontWeight.w600,
              ),
            ),
            body: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: CustomText(
                          text: 'Jenis Sampah',
                          weight: FontWeight.w600,
                        ),
                      ),
                      DropdownButton(
                        hint: CustomText(text: 'Pilih'),
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 16.0,
                            color: black,
                            fontWeight: FontWeight.normal),
                        items: trashesDropDown,
                        onChanged: changeSelectedTrash,
                        value: currenTrash,
                      ),
                      SizedBox(height: 10.0),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration:
                            BoxDecoration(border: Border.all(color: grey)),
                        child: Image.asset("assets/images/noimage.png"),
                      ),
                      TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              counterStyle: TextStyle(
                                  fontFamily: "Poppins",
                                  color: black,
                                  fontWeight: FontWeight.normal),
                              hintText: 'Berapa harga jual produk mu?',
                              hintStyle: TextStyle(fontFamily: "Poppins"),
                              labelText: 'Harga',
                              labelStyle: TextStyle(
                                  fontFamily: "Poppins",
                                  color: black,
                                  fontWeight: FontWeight.w500),
                              prefixText: 'Rp',
                              prefixStyle: TextStyle(
                                  fontFamily: "Poppins",
                                  color: yellow,
                                  fontSize: 10.0),
                              errorStyle: TextStyle(fontFamily: "Poppins"),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: yellow))),
                          onChanged: (String str) {
                            setState(() {
                              price = str;
                            });
                          },
                          validator: (value) => (value.isEmpty)
                              ? 'Masukkan harga produk'
                              : (value.length > 10)
                                  ? 'Tolong beri harga wajar'
                                  : null),
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
                                  text: 'SIMPAN',
                                  color: white,
                                  weight: FontWeight.w700),
                            ),
                            onPressed: () async {
                              onSubmit();
                            }),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
  }

  _gettrashes() async {
    List<DocumentSnapshot> data = await _trashService.getTrashes();
    setState(() {
      trashes = data;
      trashesDropDown = getTrashesDropdown();
    });
  }

  changeSelectedTrash(String selectedTrash) {
    setState(() => currenTrash = selectedTrash);
  }

  void onSubmit() async {
    if (_formKey.currentState.validate()) {
      setState(() => loading = true);
      if (currenTrash != null) {
        FirebaseAuth auth = FirebaseAuth.instance;
        FirebaseUser _user = await auth.currentUser();
        _trashReceiveService.addTrashReceive({
          "price": int.parse(price),
          "trashName": currenTrash,
          "image": 'assets/images/noimage.png',
          "partnerId": _user.uid,
          "isCheck": false
        });
        setState(() => loading = false);
        Navigator.pop(context);
      } else {
        setState(() {
          _scaffoldStateKey.currentState.showSnackBar(SnackBar(
              content: CustomText(
            text: "Tolong isi data dengan benar",
            color: white,
            weight: FontWeight.w600,
          )));
          loading = false;
        });
      }
    }
  }
}
