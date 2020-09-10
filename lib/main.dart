import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
//  Providers
import 'package:lingkung_partner/providers/trashReceiveProvider.dart';
import 'package:lingkung_partner/providers/partnerProvider.dart';
//  Screens
import 'package:lingkung_partner/screens/introduction/splash.dart';
import 'package:lingkung_partner/screens/menu/home.dart';
import 'package:lingkung_partner/screens/menu/message.dart';
import 'package:lingkung_partner/screens/menu/orderHistory.dart';
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
        ChangeNotifierProvider.value(value: PartnerProvider.initialize()),
        ChangeNotifierProvider.value(value: TrashReceiveProvider.initialize()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Lingkung Partner',
        home: Splash(),
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  
  final List<Widget> pages = [
    HomePage(),
    OrderHistoryPage(),
    MessagePage(),
    ProfilePage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: green,
        unselectedItemColor: grey,
        onTap: (index) {
          _onItemTapped(index);
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            title: Text('Beranda'),
            icon: Icon(Icons.home)
          ),
          BottomNavigationBarItem(
            title: Text('Riwayat'),
            icon: Icon(Icons.history)
          ),
          BottomNavigationBarItem(
            title: Text('Pesan'),
            icon: Icon(Icons.chat_bubble_outline)
          ),
          BottomNavigationBarItem(
            title: Text('Saya'),
            icon: Icon(Icons.person_outline)
          ),
        ],
      ),      
    );
  }
}
