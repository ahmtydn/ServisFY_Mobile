
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:servisfy_mobile/Auth/auth_page.dart';

Future logOut(BuildContext context) async{
  FirebaseAuth _auth=FirebaseAuth.instance;
  try{
    await _auth.signOut();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>AuthPage()));
  }catch(exc){
    print(exc);
  }
}