import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
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
    final trashReceiveProvider = Provider.of<TrashReceiveProvider>(context);
    return loading
        ? Loading()
        : SafeArea(
            top: false,
            child: Scaffold(
              key: _scaffoldStateKey,
              resizeToAvoidBottomPadding: false,
              backgroundColor: white,
              appBar: AppBar(
                backgroundColor: green,
                elevation: 0,
                iconTheme: IconThemeData(color: white),
                // titleSpacing: 0,
                // title: CustomText(
                //   text: 'Tambah Jenis Sampah',
                //   color: white,
                //   size: 18.0,
                //   weight: FontWeight.w600,
                // ),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.help_outline),
                    onPressed: () {},
                  ),
                ],
              ),
              body: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      CustomText(
                        text: 'Jenis Sampah',
                        weight: FontWeight.w600,
                      ),
                      DropdownButton(
                        hint: CustomText(
                          text: 'Pilih Jenis Sampah',
                          weight: FontWeight.w500,
                        ),
                        style: TextStyle(
                          fontFamily: "Poppins",
                          color: black,
                        ),
                        isExpanded: true,
                        items: trashModelDropDown,
                        value: trashes,
                        onChanged: (value) {
                          setState(() {
                            trashes = value;
                            print(trashes.name);
                          });
                        },
                      ),
                      SizedBox(height: 10.0),
                      (trashes == null)
                          ? Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.width / 2,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image:
                                      AssetImage("assets/images/noimage.png"),
                                  fit: BoxFit.cover,
                                ),
                                color: white,
                                border: Border.all(color: grey),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            )
                          : CachedNetworkImage(
                              imageUrl: trashes.image.toString(),
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.width / 2,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.contain,
                                  ),
                                  color: white,
                                  border: Border.all(color: Colors.grey[200]),
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                              ),
                              placeholder: (context, url) => Container(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.width / 2,
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                child: SpinKitThreeBounce(
                                  color: black,
                                  size: 20.0,
                                ),
                              ),
                              errorWidget: (context, url, error) => Container(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.width / 2,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image:
                                        AssetImage("assets/images/noimage.png"),
                                    fit: BoxFit.cover,
                                  ),
                                  color: white,
                                  border: Border.all(color: Colors.grey[200]),
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                              ),
                            ),
                      SizedBox(height: 16.0),
                      CustomText(
                        text: 'Harga',
                        weight: FontWeight.w600,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        style: TextStyle(
                          fontFamily: "Poppins",
                          color: black,
                        ),
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: const EdgeInsets.only(bottom: 8.0),
                          counterStyle: TextStyle(
                            fontFamily: "Poppins",
                            color: black,
                          ),
                          hintText: 'Contoh: 13000',
                          hintStyle: TextStyle(fontFamily: "Poppins"),
                          prefixText: 'Rp',
                          prefixStyle: TextStyle(
                            fontFamily: "Poppins",
                            color: Colors.red,
                          ),
                          errorStyle: TextStyle(fontFamily: "Poppins"),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: blue),
                          ),
                        ),
                        onChanged: (str) {
                          setState(() {
                            price = str;
                          });
                        },
                        validator: (value) => (value.isEmpty)
                            ? 'Masukkan harga produk'
                            : (value.length > 10)
                                ? 'Tolong beri harga wajar'
                                : null,
                      ),
                    ],
                  ),
                ),
              ),
              bottomNavigationBar: Container(
                height: 80.0,
                padding: const EdgeInsets.all(16.0),
                child: FlatButton(
                  color: (trashes == null || price == "") ? grey : yellow,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Center(
                    child: CustomText(
                      text: 'SIMPAN',
                      size: 16.0,
                      color: white,
                      weight: FontWeight.w700,
                    ),
                  ),
                  onPressed: () {
                    (trashes?.name == null)
                        ? _emptyModalBottomSheet(context)
                        : trashReceiveProvider.loadTrashReceiveByName(
                            widget.partnerModel.id, trashes.name);
                    print(trashReceiveProvider.trashReceiveByName.length);
                    if (trashReceiveProvider.trashReceiveByName.isEmpty) {
                      save();
                    } else {
                      _notEmptyModalBottomSheet(context);
                    }
                  },
                ),
              ),
            ),
          );
  }

  void save() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        loading = true;
      });

      if (trashes != null) {
        _trashReceiveService.addTrashReceive({
          "trashName": trashes.name,
          "image": trashes.image,
          "price": int.parse(price),
          "partnerId": widget.partnerModel?.id,
          "isCheck": false
        });
        print('Saved!');
        setState(() {
          loading = false;
        });
        Navigator.pop(context);
      } else {
        setState(() {
          loading = false;
        });
        _emptyModalBottomSheet(context);
      }
    }
  }

  void _emptyModalBottomSheet(context) {
    showModalBottomSheet<void>(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      context: context,
      builder: (BuildContext context) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.width / 2.2,
                    alignment: Alignment.center,
                    child: Image.asset("assets/images/verifailed.png"),
                  ),
                  SizedBox(height: 16.0),
                  CustomText(
                    text: 'Tunggu! Ada data yang kosong',
                    size: 18.0,
                    weight: FontWeight.w700,
                  ),
                  SizedBox(height: 5.0),
                  CustomText(
                    text:
                        'Kamu tidak dapat menyimpan bila datamu kosong. Yuk, lengkapi datamu!',
                  ),
                  SizedBox(height: 16.0),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 48,
                    child: FlatButton(
                      color: yellow,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: CustomText(
                        text: 'OKE',
                        color: white,
                        size: 16.0,
                        weight: FontWeight.w700,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  void _notEmptyModalBottomSheet(context) {
    showModalBottomSheet<void>(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      context: context,
      builder: (BuildContext context) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.width / 2.2,
                    alignment: Alignment.center,
                    child: Image.asset("assets/images/verifailed.png"),
                  ),
                  SizedBox(height: 16.0),
                  CustomText(
                    text: 'Ehh, sepertinya ini sudah ada',
                    size: 18.0,
                    weight: FontWeight.w700,
                  ),
                  SizedBox(height: 5.0),
                  CustomText(
                    text:
                        'Kamu sudah menambahkan jenis sampah ini ke daftarmu. Plih jenis sampah lain, yuk!',
                  ),
                  SizedBox(height: 16.0),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 48,
                    child: FlatButton(
                      color: yellow,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: CustomText(
                        text: 'OKE',
                        color: white,
                        size: 16.0,
                        weight: FontWeight.w700,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
