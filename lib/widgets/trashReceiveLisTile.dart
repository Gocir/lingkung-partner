import 'package:flutter/material.dart';
import 'package:lingkung_partner/models/partnerModel.dart';
import 'package:lingkung_partner/providers/trashReceiveProvider.dart';
import 'package:lingkung_partner/screens/updateTrashReceive.dart';
import 'package:lingkung_partner/services/trashReceiveService.dart';
import 'package:lingkung_partner/utilities/colorStyle.dart';
import 'package:lingkung_partner/utilities/textStyle.dart';
import 'package:provider/provider.dart';

class TrashReceiveLisTile extends StatefulWidget {
  final PartnerModel partnerModel;
  TrashReceiveLisTile({this.partnerModel});
  @override
  _TrashReceiveLisTileState createState() => _TrashReceiveLisTileState();
}

class _TrashReceiveLisTileState extends State<TrashReceiveLisTile> {
  TrashReceiveServices _trashReceiveService = TrashReceiveServices();
  @override
  Widget build(BuildContext context) {
    // final partner = Provider.of<PartnerProvider>(context);
    final trashReceiveProvider = Provider.of<TrashReceiveProvider>(context);
    trashReceiveProvider.loadTrashReceiveByPartner(widget.partnerModel.id);

    return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: trashReceiveProvider.trashReceiveByPartner.length,
        itemBuilder: (_, index) {
          return Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            child: ListTile(
              isThreeLine: true,
              leading: Container(
                  height: MediaQuery.of(context).size.height,
                  width: 50,
                  child: Image.asset(
                    trashReceiveProvider.trashReceiveByPartner[index].image,
                    fit: BoxFit.cover,
                  )),
              title: CustomText(
                text:
                    trashReceiveProvider.trashReceiveByPartner[index].trashName,
                size: 16,
                color: grey,
                weight: FontWeight.w500,
              ),
              subtitle: CustomText(
                text:
                    'Rp ${trashReceiveProvider.trashReceiveByPartner[index].price.toString()} /Kg',
                size: 16,
                color: black,
                weight: FontWeight.w600,
              ),
              trailing: Wrap(
                direction: Axis.vertical,
                spacing: 8,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.0),
                      color: green,
                    ),
                    child: GestureDetector(
                      child: Icon(Icons.edit, size: 14.0, color: white),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UpdateTrashReceivePage(
                                  trashReceiveModel: trashReceiveProvider
                                      .trashReceiveByPartner[index]),
                            ));
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.0),
                      color: yellow,
                    ),
                    child: GestureDetector(
                      child:
                          Icon(Icons.delete_outline, size: 14.0, color: white),
                      onTap: () async {
                        await _trashReceiveService.deleteTrashReceive(trashReceiveProvider.trashReceiveByPartner[index].id);
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
