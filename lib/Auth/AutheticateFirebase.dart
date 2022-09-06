import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:servisfy_mobile/Pages/Parent/ParentCreatPage.dart';
import 'package:servisfy_mobile/Auth/auth_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AutheticateFirebase extends StatefulWidget {
  @override
  State<AutheticateFirebase> createState() => _AutheticateFirebaseState();
}

class _AutheticateFirebaseState extends State<AutheticateFirebase> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> checkSign() async {
    var sp = await SharedPreferences.getInstance();
    String token = sp.getString("token") ?? "";
    if (token == "") {
      return false;
    } else {
      return true;
    }
  }

  @override
  void initState() {
    Firebase.initializeApp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
        // Initialize FlutterFire
        future: checkSign(),
        builder: (context, snapshot) {
          // Once complete, show your application
          if(snapshot.data!=null){
            if (_auth.currentUser != null && snapshot.data!) {
              return ParentCreatPage(0);
            } else {
              return AuthPage();
            }
          }else
            {
              return CircularProgressIndicator();
            }

        });
  }
}
