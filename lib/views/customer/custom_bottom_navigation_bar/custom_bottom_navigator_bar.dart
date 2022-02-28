import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/bottom_navigation_bar_controller.dart';
import 'package:petapp_mobile/models/bottom_bar_item/bottom_bar_item.dart';

class CustomBottomNavigatorBar extends StatelessWidget {
  const CustomBottomNavigatorBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BottomNavigationBarController navigationBarController =
        Get.put(BottomNavigationBarController());

    return Container(
      height: 60,
      color: WHITE_COLOR,
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
    );
  }
}

class BottomBarItemWidget extends GetView<BottomNavigationBarController> {
  const BottomBarItemWidget({Key? key, required this.bottomBarItem})
      : super(key: key);
  final BottomBarItem bottomBarItem;
  @override
  Widget build(BuildContext context) {
    bool isSelectedItem =
        controller.selectedItemIndex.value == bottomBarItem.id;
    return InkWell(
      onTap: () {
        controller.selectedItemIndex.value = bottomBarItem.id;
        Get.toNamed(bottomBarItem.rounterName);
      },
      child: SizedBox(
        height: 30,
        width: isSelectedItem ? 90 : 30,
        child: Material(
          color: isSelectedItem ? PRIMARY_LIGHT_COLOR : WHITE_COLOR,
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SvgPicture.asset(
                bottomBarItem.iconURL,
                color: isSelectedItem ? PRIMARY_COLOR : SUPPER_LIGHT_GREY_COLOR,
                height: 23,
              ),
              isSelectedItem
                  ? Text(
                      bottomBarItem.name,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.itim(
                        fontSize: 14,
                        color: PRIMARY_COLOR,
                        height: 1.5,
                      ),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
