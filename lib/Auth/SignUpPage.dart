import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';


class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool isLoading = false;
  var adiController = TextEditingController();
  var soyadiController = TextEditingController();
  var tckimlikController = TextEditingController();
  var epostaController = TextEditingController();
  var sifreController = TextEditingController();
  var userLogoDefault;

  Future<User?> creatAccount(String name,String surname, String email, String password) async {
    FirebaseAuth _auth = FirebaseAuth.instance;

    FirebaseFirestore _firestore = FirebaseFirestore.instance;

    try {
      User? user = (await _auth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user;
      if (user != null) {
        print("Hesap Oluşturuldu");
        user.updateDisplayName(email);
        await _firestore.collection("users").doc(_auth.currentUser!.uid).set({
          "name": name+" "+surname,
          "email": email,
          "status": "Unavalibe",
          "lastMessage": 'son mesaj',
          "time": "3 dk önce",
        });
        showTopSnackBar(
            context,
            CustomSnackBar.success(
              message: "Hesap Oluşturuldu",
            ));

        return user;
      } else {
        print("Hesap oluşturulurken hata oluştu");
        return user;
      }
    } catch (exc) {
      print(exc);
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    userLogoDefault = Image.asset("selfie_2.jpg");
    return Scaffold(
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
                  child: Padding(
                    padding: const EdgeInsets.only(right: 35.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 25,
                        ),
                        Text(
                          "Merhabalar",
                          style: GoogleFonts.bebasNeue(fontSize: 45),
                        ),
                        SizedBox(height: 5),
                        Padding(
                          padding: const EdgeInsets.only(left: 35.0),
                          child: Text(
                            "Sizinle Tanışacağımız İçin Çok Mutluyuz!",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        SizedBox(height: 15),

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
                                controller: adiController,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Adı",
                                    hintStyle: TextStyle(
                                      color: Colors.black,
                                    )),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
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
                                controller: soyadiController,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Soyadı",
                                    hintStyle: TextStyle(
                                      color: Colors.black,
                                    )),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
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
                                controller: tckimlikController,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "TC Kimlik",
                                    hintStyle: TextStyle(
                                      color: Colors.black,
                                    )),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),

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
                        SizedBox(height: 10),
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
                                    hintStyle: TextStyle(
                                      color: Colors.black,
                                    )),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        //sing in button
                        GestureDetector(
                          onTap: () {
                            if (adiController.text.isNotEmpty &&
                                soyadiController.text.isNotEmpty &&
                                tckimlikController.text.isNotEmpty &&
                                epostaController.text.isNotEmpty &&
                                sifreController.text.isNotEmpty) {
                              setState(() {
                                isLoading = true;
                              });
                              creatAccount(
                                      adiController.text,
                                      soyadiController.text,
                                      epostaController.text,
                                      sifreController.text)
                                  .then((user) {
                                if (user != null) {
                                  setState(() {
                                    isLoading = false;
                                  });
                                  print("Hesap Oluşturma Başarılı");
                                } else {
                                  showTopSnackBar(
                                      context,
                                      CustomSnackBar.error(
                                        message:
                                            "Hesap Oluşturulken hata Oluştu!",
                                      ));
                                  setState(() {
                                    isLoading=false;
                                  });
                                }
                              });
                            } else {
                              showTopSnackBar(
                                  context,
                                  CustomSnackBar.error(
                                    message: "Hiç bir alan boş geçilemez",
                                  ));
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
                                  "Kayıt",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 57),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
