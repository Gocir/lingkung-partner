import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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
        : SafeArea(
            top: false,
            child: Scaffold(
              key: _scaffoldStateKey,
              resizeToAvoidBottomPadding: false,
              backgroundColor: white,
              appBar: AppBar(
                backgroundColor: green,
                elevation: 0.0,
                iconTheme: IconThemeData(color: white),
                // title: CustomText(
                //   text: 'Perbarui Jenis Sampah',
                //   color: white,
                //   size: 18.0,
                //   weight: FontWeight.w600,
                // ),
                actions: [
                  IconButton(
                    icon: Icon(Icons.help_outline),
                    onPressed: () {},
                  ),
                ],
              ),
              body: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        CustomText(
                          text: 'Jenis Sampah',
                          weight: FontWeight.w600,
                        ),
                        TextFormField(
                          enabled: false,
                          controller: nameController,
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: const EdgeInsets.only(bottom: 8.0),
                            counterStyle: TextStyle(
                              fontFamily: "Poppins",
                              color: grey,
                            ),
                          ),
                        ),
                        SizedBox(height: 16.0),
                        CachedNetworkImage(
                          imageUrl: widget.trashReceiveModel.image.toString(),
                          imageBuilder: (context, imageProvider) => Container(
                            width: MediaQuery.of(context).size.width,
                            height: 200.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(color: Colors.grey[200]),
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          placeholder: (context, url) => Container(
                            width: MediaQuery.of(context).size.width,
                            height: 200.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: SpinKitThreeBounce(
                              color: black,
                              size: 10.0,
                            ),
                          ),
                          errorWidget: (context, url, error) => Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.width / 2,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/images/noimage.png"),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                        SizedBox(height: 16.0),
                        CustomText(
                          text: 'Harga',
                          weight: FontWeight.w600,
                        ),
                        TextFormField(
                          controller: priceController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: const EdgeInsets.only(bottom: 8.0),
                            counterStyle: TextStyle(
                              fontFamily: "Poppins",
                              color: black,
                            ),
                            hintText: 'Contoh: 6000',
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
              ),
              bottomNavigationBar: Container(
                height: 80.0,
                padding: const EdgeInsets.all(16.0),
                child: FlatButton(
                  color: yellow,
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
                    save();
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
      if (price != null) {
        _trashReceiveService.updateTrashReceive({
          "id": widget.trashReceiveModel.id,
          "price": int.parse(price),
        });
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
}
