import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
//  Services
import 'package:lingkung_partner/services/trashService.dart';
//  Utilities
import 'package:lingkung_partner/utilities/colorStyle.dart';
import 'package:lingkung_partner/utilities/textStyle.dart';
//  Widgets
import 'package:lingkung_partner/widgets/loading.dart';

class AddTrashPage extends StatefulWidget {
  @override
  _AddTrashPageState createState() => _AddTrashPageState();
}

class _AddTrashPageState extends State<AddTrashPage> {
  final _scaffoldStateKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final _picker = ImagePicker();

  bool loading = false;
  File _image;
  TextEditingController _name = TextEditingController();
  TrashServices _trashService = TrashServices();

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
                          text: 'Lengkapi data Jenis Sampah',
                          size: 22.0,
                          weight: FontWeight.w700)),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: TextFormField(
                              controller: _name,
                              decoration: InputDecoration(
                                labelText: 'Nama Jenis Sampah',
                                labelStyle: TextStyle(
                                    color: grey,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16.0),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: blue)),
                              ),
                              validator: (val) => val.isEmpty
                                  ? 'Masukkan Nama Jenis Sampah'
                                  : null),
                        ),
                        SizedBox(height: 10),
                        Container(
                          child: OutlineButton(
                              borderSide: BorderSide(
                                  color: grey.withOpacity(0.5), width: 2),
                              onPressed: () {
                                getImage();
                              },
                              child: _displayChild1()),
                        ),
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

  Future getImage() async {
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image = File(pickedFile.path);
    });
  }

  Widget _displayChild1() {
    if (_image == null) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(14, 50, 14, 50),
        child: new Icon(
          Icons.add,
          color: Colors.grey,
        ),
      );
    } else {
      return Image.file(
        _image,
        fit: BoxFit.fill,
        width: double.infinity,
      );
    }
  }

  void onSubmit() async {
    if (_formKey.currentState.validate()) {
      setState(() => loading = true);
      if (_image != null) {
        String imageUrl;

        final FirebaseStorage storage = FirebaseStorage.instance;
        final String picture =
            "T${DateTime.now().millisecondsSinceEpoch.toString()}.jpg";

        StorageUploadTask task = storage.ref().child(picture).putFile(_image);
        StorageTaskSnapshot snapshot1 =
            await task.onComplete.then((snapshot) => snapshot);

        task.onComplete.then((snapshot) async {
          imageUrl = await snapshot1.ref.getDownloadURL();
          _trashService.addTrash({
            "name": _name.text,
            "image": imageUrl,
          });
          
          setState(() => loading = false);
          //  Fluttertoast.showToast(msg: 'Restaurant added');
          Navigator.pop(context);
        });
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
