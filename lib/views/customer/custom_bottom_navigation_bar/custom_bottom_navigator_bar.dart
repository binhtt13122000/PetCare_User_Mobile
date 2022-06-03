import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/configs/route.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/models/bottom_bar_item_model/bottom_bar_item_model.dart';

class CustomBottomNavigatorBarWidget extends StatelessWidget {
  const CustomBottomNavigatorBarWidget({Key? key, required this.route})
      : super(key: key);
  final String route;
  @override
  Widget build(BuildContext context) {
    List<BottomBarItemModel> bottomBarItems = [
      BottomBarItemModel(
        id: 0,
        name: 'Home',
        iconSelectedURL: ICON_PATH + HOME_SELECTED_SVG,
        iconUnselectedURL: ICON_PATH + HOME_UNSELECTED_SVG,
        routeName: HOME_PAGE_ROUTE,
      ),
      BottomBarItemModel(
        id: 1,
        name: 'Action',
        iconSelectedURL: ICON_PATH + ACTION_SELECTED_SVG,
        iconUnselectedURL: ICON_PATH + ACTION_UNSELECTED_SVG,
        routeName: ACTION_PAGE_ROUTE,
      ),
      BottomBarItemModel(
        id: 2,
        name: 'Chat',
        iconSelectedURL: ICON_PATH + CHAT_SELECTED_SVG,
        iconUnselectedURL: ICON_PATH + CHAT_UNSELECTED_SVG,
        routeName: CHATTING_LIST_PAGE_ROUTE,
      ),
      BottomBarItemModel(
        id: 3,
        name: 'Profile',
        iconSelectedURL: ICON_PATH + PROFILE_SELECTED_SVG,
        iconUnselectedURL: ICON_PATH + PROFILE_UNSELECTED_SVG,
        routeName: PROFILE_PAGE_ROUTE,
      ),
    ];
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          color: const Color.fromARGB(255, 235, 239, 247),
          height: 1,
        ),
        Container(
          height: 50,
          decoration: const BoxDecoration(
            color: WHITE_COLOR,
            // boxShadow: [
            //   BoxShadow(
            //     color: Color.fromARGB(255, 224, 230, 243),
            //     blurRadius: 6,
            //   )
            // ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: bottomBarItems
                .asMap()
                .entries
                .map(
                  (e) => bottomBarItemWidget(
                    isSelected: e.value.routeName == route,
                    bottomBarItem: e.value,
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget bottomBarItemWidget(
          {bool isSelected = false,
          required BottomBarItemModel bottomBarItem}) =>
      InkWell(
        onTap: () {
          Get.offAllNamed(bottomBarItem.routeName);
        },
        child: Container(
          height: 36,
          width: isSelected ? 110 : 30,
          decoration: BoxDecoration(
            color: isSelected
                ? const Color.fromARGB(255, 251, 252, 255)
                : Colors.transparent,
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
            border: Border.all(
              color: isSelected
                  ? const Color.fromARGB(255, 214, 222, 238)
                  : Colors.transparent,
              width: 1,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                isSelected
                    ? bottomBarItem.iconSelectedURL
                    : bottomBarItem.iconUnselectedURL,
                color: isSelected
                    ? PRIMARY_COLOR
                    : const Color.fromARGB(255, 72, 82, 99),
                //color: const Color.fromARGB(255, 72, 82, 99),
                height: isSelected ? 18 : 22,
              ),
              isSelected
                  ? FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Text(
                          bottomBarItem.name,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.quicksand(
                            fontSize: 18,
                            color: isSelected
                                ? PRIMARY_COLOR
                                : const Color.fromARGB(255, 72, 82, 99),
                            height: 1.5,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.5,
                          ),
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
      );
}
