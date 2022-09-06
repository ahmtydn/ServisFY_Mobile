import 'dart:math';
import 'package:servisfy_mobile/Auth/LoginPage.dart';
import 'package:servisfy_mobile/Auth/SignUpPage.dart';
import 'package:servisfy_mobile/Auth/social_buttons.dart';
import 'package:servisfy_mobile/constants.dart';
import 'package:servisfy_mobile/core/app_colors.dart';
import 'package:servisfy_mobile/core/app_vectors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage>
    with SingleTickerProviderStateMixin {
  bool _showSignUp = false;
  bool isLoading=false;

  late AnimationController _animationController;
  late Animation<double> _textRotateAnimation;

  void setUpAnimation() {
    _animationController =
        AnimationController(vsync: this, duration: defaultDuration);

    _textRotateAnimation =
        Tween<double>(begin: 0, end: 90).animate(_animationController);
  }

  void updateView() {
    setState(() {
      _showSignUp = !_showSignUp;
    });
    _showSignUp
        ? _animationController.forward()
        : _animationController.reverse();
  }

  @override
  void initState() {
    setUpAnimation();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: AnimatedBuilder(
        animation: _animationController,
        builder: (context, _) {
          return Stack(
            children: [
              // login form
              AnimatedPositioned(
                duration: defaultDuration,
                width: _size.width * 0.92,
                height: _size.height,
                left: _showSignUp ? 0 : 0,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _showSignUp = !_showSignUp;
                    });
                  },
                  child: Container(
                    color: AppColors.loginBg,
                    child: LoginPage(),
                  ),
                ),
              ),
              // sign up button
              AnimatedPositioned(
                duration: defaultDuration,
                height: _size.height,
                width: _size.width * 0.92,
                left: _showSignUp ? _size.width * 0.07 : _size.width * 0.88,
                child: Container(
                  color: AppColors.signupBg,
                  child: const SignUpPage(),
                ),
              ),
              //logo animated
              AnimatedPositioned(
                duration: defaultDuration,
                left: _showSignUp ? _size.width * 0.0 - 5 : 0,
                top: _showSignUp ? 65 : 65,
                right: _showSignUp ? _size.width * 0.0 : _size.width * 0.0,
                child: _showSignUp
                    ? SizedBox(
                        height: 50,
                        child: Image.asset(
                          AppVectors.logo,
                          fit: BoxFit.fitHeight,
                        ),
                      )
                    : SizedBox(
                        height: 50,
                        child: Image.asset(
                          AppVectors.logo, //logoyu buraya ekle
                        ),
                      ),
              ),
              AnimatedPositioned(
                duration: defaultDuration,
                //width: _size.width,
                bottom: _size.height * 0.03,
                left: _showSignUp ? _size.width * 0.0 - 5 : 0,
                right: _showSignUp ? _size.width * 0.0 : _size.width * 0.0,
                child: SocialButtons(),
              ),
              // Giriş Metni
              Positioned(
                // yükseklik/2 = ekranın yarısı
                bottom:
                    _showSignUp ? _size.height / 4.3 - 80 : _size.height * 0.10,
                left: _showSignUp
                    ? 60
                    : _size.width * 0.44 -
                        80, //%44=88%/2 -> -80: kelime boyutu 160, yani 160/2
                child: InkWell(
                    onTap: updateView,
                    child: Container(
                      width: _showSignUp ? 260 : 0,
                      child: _showSignUp
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Kayıtlı mısınız?",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  " Giriş Yap",
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            )
                          : null,
                    )),
              ),
              // Kayıt metni
              Positioned(
                // yükseklik/2 = ekranın yarısı -80 -> metin kabının eksi yarısı
                bottom: !_showSignUp
                    ? _size.height / 3.0 - 80
                    : _size.height * 0.10,
                //%44=%88/2 -> -80: kelime boyutu 160, yani 160/2
                right: !_showSignUp ? 100 : _size.width * 0.44 - 80,
                child: InkWell(
                    onTap: updateView,
                    child: Container(
                      width: 210,
                      height: 30,
                      // color: Colors.red,
                      child: _showSignUp
                          ? null
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Kaydınız yok mu?",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "  Kayıt Ol",
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                    )),
              )
            ],
          );
        },
      ),
    );
  }
}
