import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:servisfy_mobile/Auth/LoginPage.dart';
import 'package:servisfy_mobile/Auth/Methods.dart';
import 'package:servisfy_mobile/Auth/auth_page.dart';
import 'package:servisfy_mobile/Pages/Parent/ParentEditProfilePage.dart';
import 'package:servisfy_mobile/Pages/Parent/ParentNotificationPage.dart';
import 'package:servisfy_mobile/Pages/Parent/ParentStudentsPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class DriverProfilePage extends StatefulWidget {
  const DriverProfilePage({Key? key}) : super(key: key);

  @override
  State<DriverProfilePage> createState() => _DriverProfilePageState();
}

class _DriverProfilePageState extends State<DriverProfilePage> {
/*
  UserModel parseUserModelResponse(String response) {
    return userModelFromJson(response);
  }


  Future<UserModel> UserRequest(TokenModel tokenModel) async {
    final response = await http.get(
      Uri.parse( "https://tk1919.herokuapp.com/api/auth"),
      headers: {
        'Authorization':"Bearer ${tokenModel.accessToken}"
      },);
    return parseUserModelResponse(response.body);

  }

  Future<UserModel> getUserInfo() async {
    var sp=await SharedPreferences.getInstance();
    var token=sp.get("token");
    TokenModel tokenModel=TokenModel(accessToken: token.toString());
    var model = await UserRequest(tokenModel);
    return model;
  }
*/

  var isimSoyisim="",email="";
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;
  Map<String, dynamic>? userMap;
  var isLoading = false;

  Future<void> bilgileriAl() async {
    setState(()  {
      isLoading = true;
    });

    await _firestore
        .collection("users")
        .where("email", isEqualTo:  _auth.currentUser!.email)
        .get()
        .then((data) {
      userMap = data.docs[0].data();
      setState(()  {
        isLoading = false;
      });
    });
  }

  @override
  void initState() {
    bilgileriAl();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: const Size(414, 896), minTextAdapt: true);
    if(userMap!=null){
      isimSoyisim=userMap!["name"];
    }
    else{
      isimSoyisim="";
    }
    var _profileInfo = Expanded(
      child: Column(
        children: [
          Container(
            height: 100,
            width: 100,
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('images/default_logo.png'),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    height:  30.5,
                    width:  30.5,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      LineAwesomeIcons.pen,
                      color: Colors.white,
                      size: ScreenUtil().setSp(20.5),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height:20),
          Text(
            "$isimSoyisim",
            style: TextStyle(
                fontSize: ScreenUtil().setSp(30.5),
                fontWeight: FontWeight.w600,
                color: Colors.black
            ),
          ),
          SizedBox(height: 25), Text(
            "Bursa/Türkiye",
            style: TextStyle(
                fontSize: ScreenUtil().setSp(20.5),
                fontWeight: FontWeight.w600,
                color: Colors.black
            ),
          ),
          SizedBox(height: 25),

        ],
      ),
    );

    return isLoading?Center(child: CircularProgressIndicator()): Scaffold(
      backgroundColor: Colors.grey[100],
      body: Column(
        children: [
          SizedBox(height:10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30),
              _profileInfo,
            ],
          ),
          SizedBox(height:  10),
          Expanded(
              child: ListView(
                children: [
                  GestureDetector(
                    onTap:(){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ParentEditProfilePage()));
                    },
                    child: ProfileListItem(
                      icon: LineAwesomeIcons.user_edit,
                      text: 'Bilgilerimi Düzenle',

                    ),
                  ),

                  GestureDetector(
                    onTap: () async {
                      logOut(context);
                      var sp=await SharedPreferences.getInstance();
                      sp.remove("token");
                    },
                    child: ProfileListItem(
                      icon: LineAwesomeIcons.door_open,
                      text: 'Çıkış Yap',
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}

class ProfileListItem extends StatelessWidget {
  final IconData icon;
  final text;
  final bool hasNavigation;

  ProfileListItem(
      {Key? key,
        required this.icon,
        required this.text,
        this.hasNavigation = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.5,
      margin: EdgeInsets.symmetric(
        horizontal:20,
      ).copyWith(
        bottom: 35,
      ),
      padding: EdgeInsets.symmetric(horizontal:20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.black,
      ),
      child: Row(
        children: [
          Icon(
            this.icon,
            size: 20.5,
            color: Colors.white,
          ),
          SizedBox(width:20.5),
          Text(this.text,
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(30.5),
                  fontWeight: FontWeight.w600,
                  color: Colors.white
              )),
          Spacer(),
          if (this.hasNavigation)
            Icon(
              LineAwesomeIcons.angle_right,
              size: 20.5,
              color: Colors.white,
            ),
        ],
      ),
    );
  }
}
