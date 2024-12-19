import 'package:astromaagic/Components/theme.dart';
import 'package:astromaagic/UI/HomeScreen/HomeScreen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../UI/GeneralPredictions/ChoosePaymentScreen.dart';
import '../UI/Settings/Setting.dart';
import '../UI/VastuConsulting/ServiceHistory.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
   PageController pageController = PageController(initialPage: 1) ;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: 1);
  }

  int _selectedIndex = 2;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  static const List<Widget> _widgetOptions = <Widget>[
    ChoosePaymentScreen(),
    HomeScreen(),
    ServiceHistory(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
          controller: pageController,
          children: <Widget>[
            ServiceHistory(),
            HomeScreen(),
            Setting(),
          ],
          onPageChanged: (int index) {
            setState(() {
              pageController.jumpToPage(index);
            });
          }),
      bottomNavigationBar: CurvedNavigationBar(
          index: 1,
          animationCurve: Curves.elasticIn,
          animationDuration: Duration(milliseconds: 10),
          color: AppTheme.primaryColor,
          backgroundColor: AppTheme.screenBackground,
          height: 50,
          onTap: (int index) {
            setState(() {
              pageController.jumpToPage(index);
            });
          },
          items: [
            Icon(
              Icons.history,
              color: Colors.black,
              size: 30,
            ),
            Icon(
              Icons.home,
              color: Colors.black,
              size: 30,
            ),
            Icon(
              Icons.person,
              color: Colors.black,
              size: 30,
            ),
          ]),
    );
  }
}
