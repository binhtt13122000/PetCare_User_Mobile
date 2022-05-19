import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/configs/rounter.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class AcctionTopWidget extends GetView {
  const AcctionTopWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding:
              const EdgeInsets.only(left: 15, right: 15, top: 30, bottom: 20),
          child:
              //*App logo
              Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  GRADIENT_WIDGET(
                    child: SvgPicture.asset(
                      ICON_PATH + PET_LOGO_SVG,
                      height: 29,
                      width: 29,
                      fit: BoxFit.cover,
                      allowDrawingOutsideViewBox: true,
                    ),
                    gradient: const LinearGradient(colors: [
                      Color.fromARGB(255, 90, 253, 253),
                      Color.fromARGB(255, 123, 41, 255),
                    ]),
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  GRADIENT_WIDGET(
                    child: Text(
                      'iU Petshop',
                      style: GoogleFonts.satisfy(
                        textStyle: const TextStyle(color: WHITE_COLOR),
                        fontWeight: FontWeight.w700,
                        fontSize: 25,
                        height: 1.2,
                      ),
                    ),
                    gradient: const LinearGradient(colors: [
                      Color.fromARGB(255, 123, 41, 255),
                      Color.fromARGB(255, 1, 226, 226),
                    ]),
                  )
                ],
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () => Get.toNamed(NOTIFICATION_PAGE_ROUNTER),
                    child: Container(
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                        color: WHITE_COLOR,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: DARK_GREY_COLOR.withOpacity(0.1),
                            blurRadius: 5,
                            offset: const Offset(2, 2),
                          )
                        ],
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            bottom: 5,
                            left: 5,
                            child: SvgPicture.asset(
                              ICON_PATH + BELL_SVG,
                              color: const Color.fromARGB(255, 110, 117, 131),
                              height: 25,
                              width: 25,
                              fit: BoxFit.cover,
                              allowDrawingOutsideViewBox: true,
                            ),
                          ),
                          Positioned(
                            top: 3,
                            right: 3,
                            child: CircleAvatar(
                              backgroundColor:
                                  const Color.fromARGB(255, 240, 121, 100),
                              radius: 7,
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
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
