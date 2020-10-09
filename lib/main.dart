import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
//  Providers
import 'package:lingkung_partner/providers/addressProvider.dart';
import 'package:lingkung_partner/providers/operationalTimeProvider.dart';
import 'package:lingkung_partner/providers/partnerProvider.dart';
import 'package:lingkung_partner/providers/trashProvider.dart';
import 'package:lingkung_partner/providers/trashReceiveProvider.dart';
//  Screens
import 'package:lingkung_partner/screens/introduction/splash.dart';
import 'package:lingkung_partner/screens/menu/home.dart';
import 'package:lingkung_partner/screens/menu/order.dart';
import 'package:lingkung_partner/screens/menu/profile.dart';
//  Utilities
import 'package:lingkung_partner/utilities/colorStyle.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: AddressProvider()),
          ChangeNotifierProvider.value(value: PartnerProvider.initialize()),
          ChangeNotifierProvider.value(value: TrashProvider.initialize()),
          ChangeNotifierProvider.value(value: OperationalTimeProvider.initialize()),
          ChangeNotifierProvider.value(
              value: TrashReceiveProvider.initialize()),
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Lingkung Partner',
            home: Splash()));
  }
}

class MainPage extends StatefulWidget {
  final String title;
  MainPage({Key key, this.title}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  final List<Widget> pages = [OrderPage(), HomePage(), ProfilePage()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: pages[_selectedIndex],
        bottomNavigationBar: BottomNavyBar(
            selectedIndex: _selectedIndex,
            showElevation: true,
            itemCornerRadius: 20.0,
            curve: Curves.easeInBack,
            onItemSelected: (index) {
              _onItemTapped(index);
            },
            items: <BottomNavyBarItem>[
              BottomNavyBarItem(
                  title: Text('Lingtra',
                      style: TextStyle(
                          fontFamily: "Poppins", fontWeight: FontWeight.w700)),
                  icon: Icon(Icons.history),
                  activeColor: blue,
                  inactiveColor: grey,
                  textAlign: TextAlign.center),
              BottomNavyBarItem(
                  title: Text('Informasi',
                      style: TextStyle(
                          fontFamily: "Poppins", fontWeight: FontWeight.w700)),
                  icon: Icon(Icons.info_outline),
                  activeColor: blue,
                  inactiveColor: grey,
                  textAlign: TextAlign.center),
              BottomNavyBarItem(
                  title: Text('Saya',
                      style: TextStyle(
                          fontFamily: "Poppins", fontWeight: FontWeight.w700)),
                  icon: Icon(Icons.person_outline),
                  activeColor: blue,
                  inactiveColor: grey,
                  textAlign: TextAlign.center),
            ]));
  }
}
