import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:petapp_mobile/bindings/home_binding.dart';
import 'package:petapp_mobile/configs/rounter.dart';
import 'package:petapp_mobile/views/customer/history/history.dart';
import 'package:petapp_mobile/views/customer/home/home.dart';
import 'package:petapp_mobile/views/guest/login/login.dart';
import 'package:petapp_mobile/views/profile/profile.dart';
import 'package:petapp_mobile/views/setting/setting.dart';
import 'package:petapp_mobile/views/support/support.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Pet App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      initialRoute: LOGIN_ROUNTER,
      getPages: [
        GetPage(
          name: LOGIN_ROUNTER,
          page: () => const Login(),
        ),
        GetPage(
          name: HOME_ROUNTER,
          page: () => const Home(),
          binding: HomeBinding(),
        ),
        GetPage(
          name: HISTORY_ROUNTER,
          page: () => const History(),
        ),
        GetPage(
          name: SUPPORT_ROUNTER,
          page: () => const Support(),
        ),
        GetPage(
          name: PROFILE_ROUNTER,
          page: () => const Profile(),
        ),
        GetPage(
          name: SETTING_ROUNTER,
          page: () => const Setting(),
        ),
      ],
    );
  }
}
