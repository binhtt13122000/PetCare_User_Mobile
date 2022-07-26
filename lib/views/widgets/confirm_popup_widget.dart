import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class ConfirmPopupWidget extends StatelessWidget {
  const ConfirmPopupWidget({
    Key? key,
    required this.onTapBackground,
    required this.title,
    required this.content,
    required this.onTapSubmit,
  }) : super(key: key);

  final Function() onTapBackground;
  final String title;
  final String content;
  final Function() onTapSubmit;

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: onTapBackground,
        child: Container(
          color: DARK_GREY_TRANSPARENT,
          alignment: Alignment.center,
          child: InkWell(
            onTap: () {},
            child: Container(
              width: 320,
              height: 150,
              decoration: BoxDecoration(
                color: WHITE_COLOR,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: DARK_GREY_COLOR.withOpacity(0.4),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Column(
                children: [
                  CUSTOM_TEXT(
                    title,
                    textAlign: TextAlign.center,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 2,
                    color: PRIMARY_COLOR,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 15),
                  ),
                  Expanded(
                    child: CUSTOM_TEXT(
                      content,
                      textAlign: TextAlign.center,
                      textOverflow: TextOverflow.clip,
                    ),
                  ),
                  submitButtonWidget(onTapSummit: onTapSubmit),
                ],
              ),
            ),
          ),
        ),
      );

  Widget submitButtonWidget({required Function() onTapSummit}) => SizedBox(
        height: 40,
        child: Column(
          children: [
            Container(
              height: 1.5,
              color: LIGHT_GREY_COLOR.withAlpha(30),
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: onTapBackground,
                      child: Container(
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          color: WHITE_COLOR,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'CANCEL',
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.clip,
                              style: GoogleFonts.quicksand(
                                color: PRIMARY_COLOR,
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 2,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 2,
                    color: LIGHT_GREY_COLOR.withAlpha(30),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: onTapSubmit,
                      child: Container(
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          color: PRIMARY_COLOR,
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(10),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'OK',
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.clip,
                              style: GoogleFonts.quicksand(
                                color: WHITE_COLOR,
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 2,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
