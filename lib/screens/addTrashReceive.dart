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
  final FirebaseUser partner;
  AddTrashReceivePage({Key key, this.partner}) : super(key: key);

  @override
  _AddTrashReceivePageState createState() => _AddTrashReceivePageState();
}

class _AddTrashReceivePageState extends State<AddTrashReceivePage> {
  final _scaffoldStateKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  String _currentTrash;
  bool loading = false;
  TrashServices _trashService = TrashServices();
  TrashReceiveServices _trashReceiveService = TrashReceiveServices();
  TextEditingController _price = TextEditingController();
  List<DocumentSnapshot> trashes = <DocumentSnapshot>[];
  List<DropdownMenuItem<String>> trashesDropDown = <DropdownMenuItem<String>>[];

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
            body: Container(
              margin: EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                      child: CustomText(
                          text: 'Buat daftar jenis sampah yang diterima',
                          size: 22.0,
                          weight: FontWeight.w700)),
                  SizedBox(height: 10.0),
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: CustomText(
                            text: 'Nama Jenis Sampah',
                            weight: FontWeight.w600,
                          ),
                        ),
                        DropdownButton(
                          items: trashesDropDown,
                          onChanged: changeSelectedTrash,
                          value: _currentTrash,
                        ),
                        SizedBox(height: 10.0),
                        Container(
                          child: TextFormField(
                              controller: _price,
                              decoration: InputDecoration(
                                labelText: 'Harga Sampah',
                                labelStyle: TextStyle(
                                    color: grey,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16.0),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: blue)),
                              ),
                              validator: (val) => val.isEmpty
                                  ? 'Berikan harga Sampah yang sesuai'
                                  : null),
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
                ],
              ),
            ),
          );
  }

  _gettrashes() async {
    List<DocumentSnapshot> data = await _trashService.getTrashes();
    print(data.length);
    setState(() {
      trashes = data;
      trashesDropDown = getTrashesDropdown();
      _currentTrash = trashes[0].data['name'];
    });
  }

  changeSelectedTrash(String selectedTrash) {
    setState(() => _currentTrash = selectedTrash);
  }

  void onSubmit() async {
    if (_formKey.currentState.validate()) {
      // setState(() => loading = true);
      if (_currentTrash != null) {
        _trashReceiveService.addTrashReceive({
          "price": double.parse(_price.text),
          "trashName": _currentTrash,
          "partnerId": widget.partner.uid,
        });
        _formKey.currentState.reset();
        setState(() => loading = false);
        //  Fluttertoast.showToast(msg: 'Restaurant added');
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
//        Fluttertoast.showToast(msg: 'all the images must be provided');
      }
    }
  }
}
