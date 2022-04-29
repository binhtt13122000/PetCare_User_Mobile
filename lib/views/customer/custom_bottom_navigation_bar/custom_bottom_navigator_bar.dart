import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/bottom_navigation_bar_controller.dart';
import 'package:petapp_mobile/models/bottom_bar_item_model/bottom_bar_item_model.dart';

class CustomBottomNavigatorBar extends StatelessWidget {
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
          padding: const EdgeInsets.only(top: 10),
          decoration: const BoxDecoration(
            color: WHITE_COLOR,
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(255, 224, 230, 243),
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
        height: 35,
        width: isSelectedItem ? 110 : 30,
        decoration: BoxDecoration(
          color: isSelectedItem ? PRIMARY_LIGHT_COLOR : WHITE_COLOR,
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
          border: Border.all(
            color: isSelectedItem
                ? PRIMARY_COLOR.withOpacity(0.5)
                : Colors.transparent,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              bottomBarItem.iconURL,
              color: isSelectedItem
                  ? PRIMARY_COLOR
                  : const Color.fromARGB(255, 167, 178, 197),
              height: 23,
            ),
            isSelectedItem
                ? Padding(
                    padding: const EdgeInsets.only(left: 8),
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
    );
  }
// class BottomBarItemWidget extends GetView<BottomNavigationBarController> {
//   const BottomBarItemWidget({Key? key, required this.bottomBarItem})
//       : super(key: key);
//   final BottomBarItemModel bottomBarItem;
//   @override
//   Widget build(BuildContext context) {
//     bool isSelectedItem =
//         controller.selectedItemIndex.value == bottomBarItem.id;
//     return InkWell(
//       onTap: () {
//         controller.selectedItemIndex.value = bottomBarItem.id;
//         Get.toNamed(bottomBarItem.rounterName);
//       },
//       child: SizedBox(
//         height: 35,
//         width: isSelectedItem ? 110 : 30,
//         child: Material(
//           color: isSelectedItem
//               ? const Color.fromARGB(255, 241, 247, 255)
//               : WHITE_COLOR,
//           borderRadius: const BorderRadius.all(
//             Radius.circular(10),
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               isSelectedItem
//                   ? GRADIENT_WIDGET(
//                       gradient: const LinearGradient(colors: [
//                         Color.fromARGB(255, 1, 206, 206),
//                         Color.fromARGB(255, 114, 35, 241),
//                       ]),
//                       child: SvgPicture.asset(
//                         bottomBarItem.iconURL,
//                         color: SUPPER_LIGHT_GREY_COLOR,
//                         height: isSelectedItem ? 26 : 23,
//                       ),
//                     )
//                   : SvgPicture.asset(
//                       bottomBarItem.iconURL,
//                       color: const Color.fromARGB(255, 167, 178, 197),
//                       height: isSelectedItem ? 26 : 23,
//                     ),
//               isSelectedItem
//                   ? GRADIENT_WIDGET(
//                       gradient: const LinearGradient(colors: [
//                         Color.fromARGB(255, 114, 35, 241),
//                         Color.fromARGB(255, 1, 221, 221),
//                       ]),
//                       child: Text(
//                         bottomBarItem.name,
//                         textAlign: TextAlign.center,
//                         style: GoogleFonts.itim(
//                           fontSize: 18,
//                           color: PRIMARY_COLOR,
//                           height: 1.5,
//                         ),
//                       ),
//                     )
//                   : const SizedBox.shrink(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
}
