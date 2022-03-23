import 'package:get/get.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/configs/rounter.dart';
import 'package:petapp_mobile/models/bottom_bar_item_model/bottom_bar_item_model.dart';

class BottomNavigationBarController extends GetxController {
  RxInt selectedItemIndex = 0.obs;

  List<BottomBarItemModel> bottomBarItems = [
    BottomBarItemModel(
        id: 0,
        name: 'Home',
        iconURL: ICON_PATH + HOME_PAGE_SVG,
        rounterName: HOME_PAGE_ROUNTER),
    BottomBarItemModel(
        id: 1,
        name: 'Action',
        iconURL: ICON_PATH + HISTORY_SVG,
        rounterName: ACTION_PAGE_ROUNTER),
    BottomBarItemModel(
        id: 2,
        name: 'Support',
        iconURL: ICON_PATH + SUPPROT_SVG,
        rounterName: SUPPORT_PAGE_ROUNTER),
    BottomBarItemModel(
        id: 3,
        name: 'Profile',
        iconURL: ICON_PATH + USER_SVG,
        rounterName: PROFILE_PAGE_ROUNTER),
    BottomBarItemModel(
        id: 4,
        name: 'Setting',
        iconURL: ICON_PATH + SETTING_SVG,
        rounterName: SETTING_PAGE_ROUNTER)
  ];
}
