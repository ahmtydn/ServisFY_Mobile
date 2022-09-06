import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:servisfy_mobile/Pages/Parent/ParentCreatPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:servisfy_mobile/models/authmodel/LoginModel.dart';
import 'package:servisfy_mobile/models/authmodel/TokenModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLoading = false;
  var epostaController = TextEditingController();
  var sifreController = TextEditingController();
  bool apiSign=false;

  TokenModel parseTokenResponse(String response) {
    return tokenModelFromJson(response);
  }


  var scaffoldKey = GlobalKey<ScaffoldState>();

  Future<TokenModel?> LoginRequest(LoginModel loginModel) async {
    final response = await http.post(
        Uri.parse("http://127.0.0.1:5000/api/auth/login"),
        headers: {'Content-Type': "application/json"},
        body: jsonEncode({
          "username": "ahmet@gmail.com",
          "password": "123456"
        }));
    if (response.statusCode == 200) {
      return parseTokenResponse(response.body);
    }
    return null;
  }

  Future<void> LoginApi(String email, String password) async {
    var model =
    await LoginRequest(LoginModel(email: email, password: password));
    if (model != null) {
      var sp = await SharedPreferences.getInstance();
      sp.setString("token", model.tokenZexly);
      apiSign=true;
    }
  }
  Future<User?> logIn(String email,String password) async {
    FirebaseAuth _auth=FirebaseAuth.instance;

    try{

      User? user=(await _auth.signInWithEmailAndPassword(email: email, password: password)).user;

      if(user!=null){
        print("Giriş yapıldı");
        showTopSnackBar(
            context,
            CustomSnackBar.success(
              message: "Giriş başarılı",
            )
        );
        return user;
      }else{
        print("Giriş yapılırken hata oluştu");
        return user;
      }

    }catch(exc){
      print(exc);

      return null;
    }
  }
  GlobalKey keyScaffold=GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key:keyScaffold,
      backgroundColor: Colors.white,
      body: isLoading
          ? Center(
        child: CircularProgressIndicator(),
      )
          : Padding(
        padding: EdgeInsets.only(top: 130, bottom: 1),
        child: SingleChildScrollView(
          child: Container(
            color: Colors.grey[100],
            child: SafeArea(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 2,
                      ),
                      //Hoşgeldin
                      Text(
                        "Tekrar Merhaba",
                        style: GoogleFonts.bebasNeue(fontSize: 45),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Hoşgeldiniz,sizi özledik!",
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(height: 50),
                      //email textfield
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: TextField(
                             controller: epostaController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "E-Posta",
                                  hintStyle: TextStyle(
                                    color: Colors.black,
                                  )),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      //password textfield
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: TextField(
                              controller: sifreController,
                              obscureText: true,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Şifre",
                                hintStyle: TextStyle(color: Colors.black)
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 40),

                      //sing in button
                      GestureDetector(
                        onTap: () {

                          if(epostaController.text.isNotEmpty&&sifreController.text.isNotEmpty){
                              setState(() {
                                isLoading=true;
                              });
                              LoginApi(epostaController.text,sifreController.text);
                              logIn(epostaController.text,sifreController.text).then((user){

                                if(user!=null/*&&apiSign*/){
                                    print("Giriş Başırılı");
                                    setState(() {
                                      isLoading=false;
                                    });
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ParentCreatPage(3)));
                                }
                                else
                                  {
                                    showTopSnackBar(
                                        context,
                                        CustomSnackBar.error(
                                          message: "Eposta veya Şifre hatalı!",
                                        )
                                    );

                                    print("Giriş Başarısız");
                                    setState(() {
                                      isLoading=false;
                                    });
                                  }
                              });

                          }
                          else{
                            showTopSnackBar(
                              context,
                                CustomSnackBar.error(
                                  message: "Hiç bir alan boş geçilemez",
                                )
                            );
                            print("Gerekli Alanları doldurunuz");
                          }



                        },
                        child: Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: 50.0),
                          child: Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(12)),
                            child: Center(
                              child: Text(
                                "Giriş",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 150),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
