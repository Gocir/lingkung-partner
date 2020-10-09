import 'package:flutter/material.dart';
//  Models
import 'package:lingkung_partner/models/trashReceiveModel.dart';
//  Services
import 'package:lingkung_partner/services/trashReceiveService.dart';
//  Utilities
import 'package:lingkung_partner/utilities/colorStyle.dart';
import 'package:lingkung_partner/utilities/textStyle.dart';
//  Widgets
import 'package:lingkung_partner/utilities/loading.dart';

class UpdateTrashReceivePage extends StatefulWidget {
  final TrashReceiveModel trashReceiveModel;
  UpdateTrashReceivePage({this.trashReceiveModel});

  @override
  _UpdateTrashReceivePageState createState() => _UpdateTrashReceivePageState();
}

class _UpdateTrashReceivePageState extends State<UpdateTrashReceivePage> {
  final _scaffoldStateKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  TrashReceiveServices _trashReceiveService = TrashReceiveServices();

  TextEditingController nameController;
  TextEditingController priceController;

  String name;
  String price;

  bool loading = false;

  @override
  void initState() {
    super.initState();
    name = widget.trashReceiveModel.trashName;
    price = widget.trashReceiveModel.price.toString();

    nameController =
        TextEditingController(text: widget.trashReceiveModel.trashName);
    priceController =
        TextEditingController(text: widget.trashReceiveModel.price.toString());
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
                text: 'Perbarui Jenis Sampah',
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
                      TextFormField(
                          enabled: false,
                          controller: nameController,
                          decoration: InputDecoration(
                              counterStyle: TextStyle(
                                  fontFamily: "Poppins",
                                  color: black,
                                  fontWeight: FontWeight.normal),
                              labelText: 'Jenis Sampah',
                              labelStyle: TextStyle(
                                  fontFamily: "Poppins",
                                  color: black,
                                  fontWeight: FontWeight.w500))),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration:
                            BoxDecoration(border: Border.all(color: grey)),
                        child: Image.asset("assets/images/noimage.png"),
                      ),
                      TextFormField(
                          controller: priceController,
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
                                borderRadius: BorderRadius.circular(20)),
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
  void onSubmit() async {
    if (_formKey.currentState.validate()) {
      // setState(() => loading = true);
      if (price != null) {
        _trashReceiveService.updateTrashReceive({
          "id": widget.trashReceiveModel.id,
          "price": int.parse(price),
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
