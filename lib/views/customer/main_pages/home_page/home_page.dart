import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/configs/route.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/main_page_controllers/home_page_controller.dart';
import 'package:petapp_mobile/main.dart';

import 'package:petapp_mobile/views/customer/main_pages/home_page/widgets/list_pet_services_widget.dart';
import 'package:petapp_mobile/views/customer/main_pages/home_page/widgets/body_widget.dart';
import 'package:petapp_mobile/views/customer/main_pages/home_page/widgets/top_widget.dart';
import 'package:petapp_mobile/views/customer/other_pages/custom_bottom_navigation_bar/custom_bottom_navigator_bar.dart';

class HomePage extends GetView<HomePageController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
    _firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    // void showNotification(
    //     String title, String body, String? metaData, String type) async {
    //   await demoNotification(title, body, metaData, type);
    // }

    _firebaseMessaging.subscribeToTopic('all');
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? remoteNotification = message.notification;
      if (remoteNotification != null) {
        showNotification(
            remoteNotification.title ?? "",
            remoteNotification.body ?? "",
            message.data["metadata"],
            message.data["type"]);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      RemoteNotification? remoteNotification = message.notification;
      AndroidNotification? androidNotification = message.notification?.android;
      if (remoteNotification != null && androidNotification != null) {
        showNotification(
            remoteNotification.title ?? "",
            remoteNotification.body ?? "",
            message.data["metadata"],
            message.data["type"]);
      }
    });

    return Scaffold(
      backgroundColor: WHITE_COLOR,
      extendBody: true,
      body: Stack(
        children: [
          Column(
            children: const [
              TopNavigationBar(),
              HomeListPetServiceWidget(),
              Expanded(child: HomeBodyWidget()),
            ],
          ),
          const Align(
            alignment: Alignment.bottomCenter,
            child: CustomBottomNavigatorBarWidget(route: HOME_PAGE_ROUTE),
          ),
        ],
      ),
    );
  }
}
