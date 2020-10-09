import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lingkung_partner/models/partnerModel.dart';
import 'package:lingkung_partner/models/trashModel.dart';
import 'package:lingkung_partner/providers/trashProvider.dart';
import 'package:lingkung_partner/providers/trashReceiveProvider.dart';
import 'package:lingkung_partner/services/trashReceiveService.dart';
//  Utilities
import 'package:lingkung_partner/utilities/colorStyle.dart';
import 'package:lingkung_partner/utilities/textStyle.dart';
//  Widgets
import 'package:lingkung_partner/utilities/loading.dart';
import 'package:provider/provider.dart';

class AddTrashReceivePage extends StatefulWidget {
  final PartnerModel partnerModel;
  AddTrashReceivePage({this.partnerModel});
  @override
  _AddTrashReceivePageState createState() => _AddTrashReceivePageState();
}

class _AddTrashReceivePageState extends State<AddTrashReceivePage> {
  final _scaffoldStateKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  TrashReceiveServices _trashReceiveService = TrashReceiveServices();

  bool loading = false;
  String price = '';
  TrashModel trashes;
  List<TrashModel> trashModeList;
  List<DropdownMenuItem<TrashModel>> trashModelDropDown;

  @override
  void initState() {
    super.initState();
    final trashProvider = Provider.of<TrashProvider>(context, listen: false);
    trashModelDropDown = getTrashesDropdown(trashProvider.trashes);
  }

  List<DropdownMenuItem<TrashModel>> getTrashesDropdown(List trash) {
    List<DropdownMenuItem<TrashModel>> items = [];
    for (TrashModel trashModel in trash) {
      items.add(
        DropdownMenuItem(child: Text(trashModel.name), value: trashModel),
      );
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : SafeArea(
            top: false,
            child: Scaffold(
                key: _scaffoldStateKey,
                resizeToAvoidBottomPadding: false,
                backgroundColor: white,
                appBar: AppBar(
                    backgroundColor: blue,
                    iconTheme: IconThemeData(color: white),
                    titleSpacing: 0,
                    title: CustomText(
                        text: 'Tambah Jenis Sampah',
                        color: white,
                        size: 18.0,
                        weight: FontWeight.w600),
                    actions: <Widget>[
                      IconButton(
                          icon: Icon(Icons.help_outline, color: white),
                          onPressed: null)
                    ]),
                body: Form(
                    key: _formKey,
                    child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              CustomText(
                                  text: 'Jenis Sampah',
                                  weight: FontWeight.w700),
                              DropdownButton(
                                  hint: CustomText(
                                      text: 'Pilih Jenis Sampah',
                                      weight: FontWeight.w500),
                                  style: TextStyle(
                                      fontFamily: "Poppins", color: black),
                                  isExpanded: true,
                                  items: trashModelDropDown,
                                  onChanged: (value) {
                                    setState(() {
                                      trashes = value;
                                      print(trashes.name);
                                    });
                                  },
                                  value: trashes),
                              SizedBox(height: 10.0),
                              (trashes == null)
                                  ? Container(
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.width / 2,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  "assets/images/noimage.png"),
                                              fit: BoxFit.cover),
                                          color: white,
                                          border: Border.all(color: grey),
                                          borderRadius:
                                              BorderRadius.circular(5.0)))
                                  : CachedNetworkImage(
                                      imageUrl: trashes.image.toString(),
                                      imageBuilder: (context, imageProvider) => Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: imageProvider,
                                                  fit: BoxFit.contain),
                                              color: white,
                                              border: Border.all(color: Colors.grey[200]),
                                              borderRadius:
                                                  BorderRadius.circular(5.0))),
                                      placeholder: (context, url) => Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: MediaQuery.of(context).size.width / 2,
                                          decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(5.0)),
                                          child: SpinKitThreeBounce(color: black, size: 20.0)),
                                      errorWidget: (context, url, error) => Container(width: MediaQuery.of(context).size.width, height: MediaQuery.of(context).size.width / 2, decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/noimage.png"), fit: BoxFit.cover), color: white, border: Border.all(color: Colors.grey[200]), borderRadius: BorderRadius.circular(5.0)))),
                              SizedBox(height: 16.0),
                              CustomText(
                                  text: 'Harga Jenis Sampah',
                                  weight: FontWeight.w700),
                              TextFormField(
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  style: TextStyle(
                                      fontFamily: "Poppins", color: black),
                                  decoration: InputDecoration(
                                    isDense: true,
                                      counterStyle: TextStyle(
                                          fontFamily: "Poppins", color: black),
                                      hintText: 'Contoh: 13000',
                                      hintStyle:
                                          TextStyle(fontFamily: "Poppins"),
                                      prefixText: 'Rp ',
                                      prefixStyle: TextStyle(
                                          fontFamily: "Poppins",
                                          color: Colors.red),
                                      errorStyle:
                                          TextStyle(fontFamily: "Poppins"),
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(color: blue))),
                                  onChanged: (String str) {
                                    setState(() {
                                      price = str;
                                    });
                                  },
                                  validator: (value) => (value.isEmpty)
                                      ? 'Masukkan harga produk'
                                      : (value.length > 10)
                                          ? 'Tolong beri harga wajar'
                                          : null)
                            ]))),
                bottomNavigationBar: Container(
                    height: 77.0,
                    padding: const EdgeInsets.all(16.0),
                    child: FlatButton(
                        color: (trashes == null || price == "") ? grey : green,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                            child: CustomText(
                                text: 'SIMPAN',
                                color: white,
                                size: 16.0,
                                weight: FontWeight.w700)),
                        onPressed: () {
                          onSubmit();
                        }))));
  }

  void onSubmit() async {
    final trashReceiveProvider = Provider.of<TrashReceiveProvider>(context, listen: false);
    trashReceiveProvider.loadTrashReceiveByName(widget.partnerModel.id, trashes.name);
    if (_formKey.currentState.validate()) {
      setState(() => loading = true);

      bool value = trashReceiveProvider.trashReceiveByName.isEmpty;
      print(value);

      if (value) {
        if (trashes != null) {
          FirebaseAuth auth = FirebaseAuth.instance;
          FirebaseUser _user = await auth.currentUser();
          _trashReceiveService.addTrashReceive({
            "price": int.parse(price),
            "trashName": trashes.name,
            "image": trashes.image,
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
        }} else {
          setState(() {
            _scaffoldStateKey.currentState.showSnackBar(SnackBar(
                content: CustomText(
              text: "Jenis sampah telah tersedia di daftarmu!",
              color: white,
              weight: FontWeight.w600,
            )));
            loading = false;
          });
        }
    }
  }
}
