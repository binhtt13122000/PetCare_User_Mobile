import 'package:get/get.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/configs/rounter.dart';
import 'package:petapp_mobile/models/bottom_bar_item/bottom_bar_item.dart';

class BottomNavigationBarController extends GetxController {
  RxInt selectedItemIndex = 0.obs;

  List<BottomBarItem> bottomBarItems = [
    BottomBarItem(
        id: 0,
        name: 'Home',
        iconURL: ICON_PATH + HOME_PAGE_SVG,
        rounterName: HOME_ROUNTER),
    BottomBarItem(
        id: 1,
        name: 'History',
        iconURL: ICON_PATH + HISTORY_SVG,
        rounterName: HISTORY_ROUNTER),
    BottomBarItem(
        id: 2,
        name: 'Support',
        iconURL: ICON_PATH + SUPPROT_SVG,
        rounterName: SUPPORT_ROUNTER),
    BottomBarItem(
        id: 3,
        name: 'Profile',
        iconURL: ICON_PATH + USER_SVG,
        rounterName: PROFILE_ROUNTER),
    BottomBarItem(
        id: 4,
        name: 'Setting',
        iconURL: ICON_PATH + SETTING_SVG,
        rounterName: SETTING_ROUNTER)
  ];
}
