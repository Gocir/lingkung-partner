import 'package:lingkung_partner/main.dart';
import 'package:lingkung_partner/providers/partnerProvider.dart';
import 'package:lingkung_partner/screens/authenticate/authenticate.dart';
import 'package:flutter/material.dart';
import 'package:lingkung_partner/widgets/loading.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    final auth = Provider.of<PartnerProvider>(context);
    print(auth);

    //return either home or authenticate widget
    // if (partner == null) {
    //   return Authenticate();
    // } else {
    //   return MainPage();
    // }
     switch (auth.status) {
      case Status.Uninitialized:
        return Loading();
      case Status.Unauthenticated:
      case Status.Authenticating:
        return Authenticate();
      case Status.Authenticated:
        return MainPage();
      default:
        return Authenticate();
    }
  }
}