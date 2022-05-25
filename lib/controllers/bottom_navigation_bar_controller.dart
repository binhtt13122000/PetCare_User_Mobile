import 'package:get/get.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/configs/route.dart';
import 'package:petapp_mobile/models/bottom_bar_item_model/bottom_bar_item_model.dart';

class BottomNavigationBarController extends GetxController {
  RxInt selectedItemIndex = 0.obs;

  List<BottomBarItemModel> bottomBarItems = [
    BottomBarItemModel(
      id: 0,
      name: 'Home',
      iconSelectedURL: ICON_PATH + HOME_SELECTED_SVG,
      iconUnselectedURL: ICON_PATH + HOME_UNSELECTED_SVG,
      rounterName: HOME_PAGE_ROUNTER,
    ),
    BottomBarItemModel(
      id: 1,
      name: 'Action',
      iconSelectedURL: ICON_PATH + ACTION_SELECTED_SVG,
      iconUnselectedURL: ICON_PATH + ACTION_UNSELECTED_SVG,
      rounterName: ACTION_PAGE_ROUNTER,
    ),
    BottomBarItemModel(
      id: 2,
      name: 'Chat',
      iconSelectedURL: ICON_PATH + CHAT_SELECTED_SVG,
      iconUnselectedURL: ICON_PATH + CHAT_UNSELECTED_SVG,
      rounterName: CHATTING_LIST_PAGE_ROUNTER,
    ),
    BottomBarItemModel(
      id: 3,
      name: 'Profile',
      iconSelectedURL: ICON_PATH + PROFILE_SELECTED_SVG,
      iconUnselectedURL: ICON_PATH + PROFILE_UNSELECTED_SVG,
      rounterName: PROFILE_PAGE_ROUNTER,
    ),
    // BottomBarItemModel(
    //     id: 4,
    //     name: 'Setting',
    //     iconURL: ICON_PATH + SETTING_SVG,
    //     rounterName: SETTING_PAGE_ROUNTER)
  ];
}
