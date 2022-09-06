import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:http/http.dart' as http;
import 'package:servisfy_mobile/Pages/Parent/ParentChatPage.dart';
import 'package:servisfy_mobile/Pages/Parent/ParentHomePage.dart';
import 'package:servisfy_mobile/Pages/Parent/ParentLokationTrackerPage.dart';
import 'package:servisfy_mobile/Pages/Parent/ParentProfilePage.dart';

class ParentCreatPage extends StatefulWidget {
  int index;

  ParentCreatPage(this.index);

  @override
  State<ParentCreatPage> createState() => _ParentCreatPageState();
}

class _ParentCreatPageState extends State<ParentCreatPage> {
  final screens = [
    ParentHomePage(),
    ParentLokationTrackerPage(),
    ParentChatPage(),
    ParentProfilePage()
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
        Icons.location_on,
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
