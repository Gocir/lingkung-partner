import 'package:flutter/material.dart';
import 'package:lingkung_partner/providers/trashReceiveProvider.dart';
import 'package:lingkung_partner/utilities/colorStyle.dart';
import 'package:lingkung_partner/utilities/textStyle.dart';
import 'package:provider/provider.dart';

class TrashReceiveLisTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final trashReceiveProvider = Provider.of<TrashReceiveProvider>(context);
    return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: trashReceiveProvider.trashReceives.length,
        itemBuilder: (_, index) {
          return Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            child: ListTile(
              title: CustomText(
                text: trashReceiveProvider.trashReceives[index].trashName,
                size: 16,
                color: grey,
                weight: FontWeight.w500,
              ),
              subtitle: CustomText(
                text: 'Rp ${trashReceiveProvider.trashReceives[index].price.toString()} /Kg',
                size: 16,
                color: black,
                weight: FontWeight.w600,
              ),
              trailing: GestureDetector(
                child: Icon(Icons.edit, color: blue,),
                onTap: () {},
              ),
            ),
          );
        });
  }
}
