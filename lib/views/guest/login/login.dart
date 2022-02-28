import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/configs/rounter.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Login Page'),
            InkWell(
              child: const Text('Login'),
              onTap: () => Get.offAndToNamed(HOME_ROUNTER),
            )
          ],
        ),
      ),
    );
  }
}
