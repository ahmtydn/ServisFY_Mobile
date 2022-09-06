import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:servisfy_mobile/Pages/Driver/DriverChatPage.dart';
import 'package:servisfy_mobile/Pages/Driver/DriverHomePage.dart';
import 'package:servisfy_mobile/Pages/Driver/DriverProfilePage.dart';
import 'package:servisfy_mobile/Pages/Driver/DriverShiftControlPage.dart';

class DriverCreatPage extends StatefulWidget {
  int index;

  DriverCreatPage(this.index);

  @override
  State<DriverCreatPage> createState() => _DriverCreatPageState();
}

class _DriverCreatPageState extends State<DriverCreatPage> {
  final screens = [
    DriverHomePage(),
    DriverShiftControlPage(),
    DriverChatPage(),
    DriverProfilePage(),
  ];

  final screensName = [
    "Anasayfa",
    "Canlı Konum",
    "Sohbet",
    "Profil",
  ];

  @override
  Widget build(BuildContext context) {

    final items = [
      Icon(
        Icons.home,
        size: 30,
        color: Colors.black,
      ),
      Icon(
        Icons.work_outline_sharp,
        size: 30,
        color: Colors.black,
      ),
      Icon(
        Icons.mark_unread_chat_alt_outlined,
        size: 30,
        color: Colors.black,
      ),
      Icon(
        Icons.person,
        size: 30,
        color: Colors.black,
      ),
    ];

    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          "${screensName[widget.index]}",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      bottomNavigationBar: CurvedNavigationBar(
        items: items,
        index: widget.index,
        buttonBackgroundColor: Colors.white,
        onTap: (index) => setState(() => this.widget.index = index),
        height: 60,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 300),
        color: Colors.white,
        backgroundColor: Colors.transparent,
      ),
      body: screens[widget.index],
    );
  }
}
