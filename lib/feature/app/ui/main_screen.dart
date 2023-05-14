import 'package:flutter/material.dart';
import 'package:riandgo2/feature/Trips/ui/trips_main_screen.dart';
import 'package:riandgo2/feature/addCard/ui/addCard_screen.dart';
import 'package:riandgo2/feature/profile/ui/profile_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  static final List<Widget> _widgetOptions = <Widget>[
    const TripScreen(),
    const AddCard(),
    const Profile(),
  ];

  int _selectedTab = 2;

  void onSelectTab(int index) {
    if (_selectedTab == index) return;
    setState(() {
      _selectedTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        body: Center(
          child: _widgetOptions[_selectedTab],
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: const Color(0xffEAC498),
          selectedItemColor: Colors.white,
          currentIndex: _selectedTab,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Поиск',
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.add_circle_outline_outlined), label: ''),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Профиль',
            ),
          ],
          onTap: onSelectTab,
        ),
      ),
      onWillPop: () async => false,
    );
  }
}
