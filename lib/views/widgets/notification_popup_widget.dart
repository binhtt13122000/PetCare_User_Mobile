import 'package:flutter/material.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class NotificationPopupWidget extends StatelessWidget {
  const NotificationPopupWidget({
    Key? key,
    required this.onTapBackground,
    required this.onTapOk,
    required this.content,
    this.isSuccessNotification = true,
  }) : super(key: key);

  final Function() onTapBackground;
  final Function() onTapOk;
  final String content;
  final bool isSuccessNotification;

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: onTapBackground,
        child: Container(
          color: DARK_GREY_TRANSPARENT,
          alignment: Alignment.center,
          child: Container(
            decoration: BoxDecoration(
              color: WHITE_COLOR,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: DARK_GREY_COLOR.withOpacity(0.3),
                  blurRadius: 3,
                  offset: const Offset(2, 2),
                ),
              ],
            ),
            height: 250,
            width: 290,
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          top: 20,
                          bottom: isSuccessNotification ? 5 : 20,
                        ),
                        child: Image.asset(
                          isSuccessNotification
                              ? IMAGE_PATH + PET_WITH_CAKE_PNG
                              : IMAGE_PATH + LAZY_CAT_PNG,
                          height: isSuccessNotification ? 85 : 50,
                        ),
                      ),
                      CUSTOM_TEXT(
                        isSuccessNotification ? 'Success!' : 'Failed!',
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: isSuccessNotification ? GREEN_COLOR : RED_COLOR,
                        letterSpacing: 1.5,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: SizedBox(
                              child: CUSTOM_TEXT(
                                content,
                                textOverflow: TextOverflow.clip,
                                textAlign: TextAlign.center,
                                color: DARK_GREY_TEXT_COLOR.withOpacity(0.8),
                                fontSize: 14,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 5),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 1,
                  color: LIGHT_GREY_COLOR.withAlpha(30),
                ),
                InkWell(
                  onTap: onTapOk,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: PRIMARY_COLOR,
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(10),
                      ),
                    ),
                    child: CUSTOM_TEXT(
                      'OK',
                      color: WHITE_COLOR,
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                      letterSpacing: 2,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
