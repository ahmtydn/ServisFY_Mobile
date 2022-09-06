import 'package:flutter/material.dart';

import '../core/app_images.dart';

/// Sosyal ağ butonlarının olduğu hat
class SocialButtons extends StatelessWidget {
  const SocialButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () {
            print("Facebook Tıklandı");
          },
          icon: Image.asset(
            AppImages.facebook,
            color: Colors.black,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: Image.asset(
            AppImages.phone,
            color: Colors.black,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: Image.asset(
            AppImages.email,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
