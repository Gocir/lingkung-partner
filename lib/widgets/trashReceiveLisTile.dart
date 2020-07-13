import 'package:flutter/material.dart';
import 'package:lingkung_partner/providers/partnerProvider.dart';
import 'package:lingkung_partner/providers/trashReceiveProvider.dart';
import 'package:lingkung_partner/screens/updateTrashReceive.dart';
import 'package:lingkung_partner/utilities/colorStyle.dart';
import 'package:lingkung_partner/utilities/textStyle.dart';
import 'package:provider/provider.dart';

class TrashReceiveLisTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final partner = Provider.of<PartnerProvider>(context);
    final trashReceiveProvider = Provider.of<TrashReceiveProvider>(context);
    
    trashReceiveProvider.loadTrashReceiveByPartner(partner.businessPartner.uid);

    return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: trashReceiveProvider.trashReceiveByPartner.length,
        itemBuilder: (_, index) {
          return Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            child: ListTile(
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
                spacing: 10,
                children: <Widget>[
                  GestureDetector(
                    child: Icon(Icons.edit, color: green),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UpdateTrashReceivePage(trashReceiveModel: trashReceiveProvider.trashReceiveByPartner[index]),
                          ));
                    },
                  ),
                  GestureDetector(
                    child: Icon(Icons.delete_outline, color: yellow),
                    onTap: () {},
                  ),
                ],
              ),
            ),
          );
        });
  }
}
