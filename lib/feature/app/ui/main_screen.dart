import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:riandgo2/feature/Trips/ui/trips_main_screen.dart';
import 'package:riandgo2/feature/add_card/ui/addCard_screen.dart';
import 'package:riandgo2/feature/app/bloc/navigator_bloc.dart';
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
    return BlocConsumer<NavigatorBloc, NavigatorScreenState>(
      listener: (context, state) {
        if (state is NavigateProfileState) onSelectTab(2);
        if (state is NavigateSearchState) onSelectTab(0);
      },
      builder: (context, state) {
        return WillPopScope(
          child: Scaffold(
            body: Center(
              child: _widgetOptions[_selectedTab],
            ),
            bottomNavigationBar: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
              ),
              child: BottomNavigationBar(
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
          ),
          onWillPop: () async => false,
        );
      },
    );
  }
}
