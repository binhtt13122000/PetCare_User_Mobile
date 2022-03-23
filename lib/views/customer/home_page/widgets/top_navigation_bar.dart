import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/home_page_controller.dart';

class TopNavigationBar extends GetView<HomePageController> {
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
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(
            left: 22.5,
            bottom: 14,
          ),
          child:
              //!App logo
              Row(
            children: [
              SvgPicture.asset(
                ICON_PATH + PET_LOGO_SVG,
                color: WHITE_COLOR,
                height: 29,
              ),
              const SizedBox(
                width: 2,
              ),
              Text(
                'iU Petshop',
                style: GoogleFonts.satisfy(
                  textStyle: const TextStyle(color: WHITE_COLOR),
                  fontWeight: FontWeight.w700,
                  fontSize: 25,
                  height: 1,
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 100,
          decoration: const BoxDecoration(
            color: Color.fromARGB(137, 155, 39, 245),
          ),
          child: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(
              left: 20,
              bottom: 15,
              right: 20,
            ),
            child:
                //!App logo
                Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      ICON_PATH + PET_LOGO_SVG,
                      color: WHITE_COLOR,
                      height: 29,
                    ),
                    const SizedBox(
                      width: 2,
                    ),
                    Text(
                      'iU Petshop',
                      style: GoogleFonts.satisfy(
                        textStyle: const TextStyle(color: WHITE_COLOR),
                        fontWeight: FontWeight.w700,
                        fontSize: 25,
                        height: 1,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 27.75,
                  width: 27,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: SvgPicture.asset(
                          ICON_PATH + BELL_NOTIFICATION_SVG,
                          color: WHITE_COLOR.withOpacity(0.85),
                          height: 26,
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: CircleAvatar(
                          backgroundColor:
                              const Color.fromARGB(255, 240, 121, 100),
                          radius: 6.5,
                          child: Text(
                            '1',
                            style: GoogleFonts.itim(
                              fontSize: 12,
                              color: WHITE_COLOR,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        //!Search bar
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: const EdgeInsets.only(bottom: 15),
            width: size.width * 7 / 9,
            height: 55,
            child: Material(
              elevation: 5,
              shadowColor: PRIMARY_COLOR.withOpacity(0.5),
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
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                    fontStyle: FontStyle.italic,
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
