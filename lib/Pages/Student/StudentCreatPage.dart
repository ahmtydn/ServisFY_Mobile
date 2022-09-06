import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:servisfy_mobile/Pages/Student/StudentHomePage.dart';
import 'package:servisfy_mobile/Pages/Student/StudentProfilePage.dart';
import 'package:servisfy_mobile/Pages/Student/StudentQRScanPage.dart';

class StudentCreatPage extends StatefulWidget {
  int index;

  StudentCreatPage(this.index);

  @override
  State<StudentCreatPage> createState() => _StudentCreatPageState();
}

class _StudentCreatPageState extends State<StudentCreatPage> {
  final screens = [
   StudentHomePage(),
    StudentQRScanPage(),
    StudentProfilePage(),
  ];

  final screensName = [
    "Anasayfa",
    "QR Kod Okut",
    "Profil",
  ];

  final items = [
    Icon(
      Icons.home,
      size: 30,
      color: Colors.black,
    ),
    Icon(
      Icons.qr_code,
      size: 30,
      color: Colors.black,
    ),
    Icon(
      Icons.person,
      size: 30,
      color: Colors.black,
    ),
  ];
  @override
  Widget build(BuildContext context) {
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
