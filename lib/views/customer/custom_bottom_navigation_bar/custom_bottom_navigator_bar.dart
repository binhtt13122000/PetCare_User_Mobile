import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/bottom_navigation_bar_controller.dart';
import 'package:petapp_mobile/models/bottom_bar_item_model/bottom_bar_item_model.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class CustomBottomNavigatorBar extends StatelessWidget {
  const CustomBottomNavigatorBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BottomNavigationBarController navigationBarController =
        Get.put(BottomNavigationBarController());

    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: WHITE_COLOR,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 6,
          )
        ],
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
      child: SizedBox(
        height: 35,
        width: isSelectedItem ? 110 : 30,
        child: Material(
          color: isSelectedItem
              ? PRIMARY_LIGHT_COLOR.withOpacity(0.4)
              : WHITE_COLOR,
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              isSelectedItem
                  ? GRADIENT_WIDGET(
                      gradient: const LinearGradient(colors: [
                        Color.fromARGB(255, 1, 206, 206),
                        Color.fromARGB(255, 114, 35, 241),
                      ]),
                      child: SvgPicture.asset(
                        bottomBarItem.iconURL,
                        color: SUPPER_LIGHT_GREY_COLOR,
                        height: isSelectedItem ? 26 : 23,
                      ),
                    )
                  : SvgPicture.asset(
                      bottomBarItem.iconURL,
                      color: SUPPER_LIGHT_GREY_COLOR,
                      height: isSelectedItem ? 26 : 23,
                    ),
              isSelectedItem
                  ? GRADIENT_WIDGET(
                      gradient: const LinearGradient(colors: [
                        Color.fromARGB(255, 114, 35, 241),
                        Color.fromARGB(255, 1, 221, 221),
                      ]),
                      child: Text(
                        bottomBarItem.name,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.itim(
                          fontSize: 18,
                          color: PRIMARY_COLOR,
                          height: 1.5,
                        ),
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
