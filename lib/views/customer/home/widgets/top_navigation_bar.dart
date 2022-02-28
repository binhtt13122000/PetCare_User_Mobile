import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/home_controller.dart';

class TopNavigationBar extends GetView<HomeController> {
  const TopNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Stack(
      children: [
        Container(
          height: 100,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(IMAGE_PATH + SWEET_HOME_PNG),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          height: 100,
          decoration: const BoxDecoration(
            color: PRIMARY_TRANSPARENT_COLOR,
          ),
          child: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(
              left: 50,
              bottom: 15,
            ),
            child: Text(
              'iU Petshop',
              style: GoogleFonts.satisfy(
                textStyle: const TextStyle(color: WHITE_COLOR),
                fontWeight: FontWeight.w700,
                fontSize: 25,
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: const EdgeInsets.only(bottom: 15),
            width: size.width * 7 / 9,
            height: 60,
            child: Material(
              elevation: 5,
              shadowColor: PRIMARY_COLOR,
              borderRadius: const BorderRadius.all(
                Radius.circular(25),
              ),
              child: TextField(
                onChanged: (value) {
                  //searchItem = value;
                },
                decoration: InputDecoration(
                  isCollapsed: true,
                  prefixIcon: IconButton(
                    icon: const Icon(
                      Icons.search,
                      size: 20,
                    ),
                    onPressed: () {
                      //onTapSearch(searchItem: searchItem);
                    },
                    color: PRIMARY_COLOR,
                  ),
                  hintText: 'Search pet, food, services, etc...',
                  hintStyle: GoogleFonts.itim(
                    textStyle: const TextStyle(color: LIGHT_GREY_COLOR),
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding:
                      const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(25),
                    ),
                    borderSide: BorderSide(color: WHITE_COLOR),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
