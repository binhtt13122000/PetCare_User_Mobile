import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/bottom_navigation_bar_controller.dart';
import 'package:petapp_mobile/models/bottom_bar_item_model/bottom_bar_item_model.dart';

class CustomBottomNavigatorBar extends GetView<BottomNavigationBarController> {
  const CustomBottomNavigatorBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BottomNavigationBarController navigationBarController =
        Get.put(BottomNavigationBarController());

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
            children: navigationBarController.bottomBarItems
                .asMap()
                .entries
                .map(
                  (e) => BottomBarItemWidget(
                    bottomBarItem: e.value,
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}

class BottomBarItemWidget extends GetView<BottomNavigationBarController> {
  const BottomBarItemWidget({Key? key, required this.bottomBarItem})
      : super(key: key);
  final BottomBarItemModel bottomBarItem;
  @override
  Widget build(BuildContext context) {
    bool isSelectedItem =
        controller.selectedItemIndex.value == bottomBarItem.id;
    return InkWell(
      onTap: () {
        controller.selectedItemIndex.value = bottomBarItem.id;
        Get.toNamed(bottomBarItem.rounterName);
      },
      child: Container(
        height: 36,
        width: isSelectedItem ? 110 : 30,
        decoration: BoxDecoration(
          color: isSelectedItem
              ? const Color.fromARGB(255, 251, 252, 255)
              : Colors.transparent,
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
          border: Border.all(
            color: isSelectedItem
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
              isSelectedItem
                  ? bottomBarItem.iconSelectedURL
                  : bottomBarItem.iconUnselectedURL,
              color: isSelectedItem
                  ? PRIMARY_COLOR
                  : const Color.fromARGB(255, 72, 82, 99),
              //color: const Color.fromARGB(255, 72, 82, 99),
              height: isSelectedItem ? 18 : 22,
            ),
            isSelectedItem
                ? FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Text(
                        bottomBarItem.name,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.quicksand(
                          fontSize: 18,
                          color: isSelectedItem
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
}
