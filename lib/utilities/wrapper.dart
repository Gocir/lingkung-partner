import 'package:lingkung_partner/main.dart';
import 'package:lingkung_partner/providers/partnerProvider.dart';
import 'package:lingkung_partner/screens/authenticate/login.dart';
import 'package:flutter/material.dart';
import 'package:lingkung_partner/screens/profileDetail/accountStatus.dart';
import 'package:lingkung_partner/screens/profileDetail/businessName.dart';
import 'package:lingkung_partner/screens/profileDetail/dataActivation.dart';
import 'package:lingkung_partner/screens/profileDetail/dataVerification.dart';
import 'package:lingkung_partner/utilities/loading.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    final auth = Provider.of<PartnerProvider>(context);
    print(auth);

     switch (auth.status) {
      case Status.Uninitialized:
        return Loading();
      case Status.Unauthenticated:
      case Status.Authenticating:
        return LoginPage();
      case Status.Authenticated:
        return MainPage();
      case Status.Registering:
        return AddBusinessName();
      case Status.Registered:
        return DataVerification();
      case Status.Verify:
        return AccountStatus();
      case Status.Activate:
        return DataActivation();
      default:
        return LoginPage();
    }
  }
}