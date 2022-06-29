// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/configs/theme.dart';

Widget CUSTOM_REQUIRED_TEXT_FIELD(
    {required String hintText,
    required Function(String?) onChange,
    required Function<bool>() checkEmptyString,
    required Function<bool>() checkErrorText,
    required Function() onDelete,
    required String errorText,
    required Function<String>() countText,
    required int maxLength,
    bool isNumberTextField = false,
    String? initText,
    bool isNumber = false,
    double height = 40,
    int maxLines = 1,
    EdgeInsets padding = EdgeInsets.zero}) {
  FocusNode focusNode = FocusNode();
  TextEditingController textEditingController = TextEditingController();
  if (initText != null) {
    textEditingController.text = initText;
  }

  return Obx(
    () => Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: height,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: checkErrorText.call()
                    ? RED_COLOR
                    : const Color.fromARGB(255, 136, 154, 180),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: textEditingController,
                    textAlign: isNumber ? TextAlign.end : TextAlign.start,
                    cursorColor:
                        checkErrorText.call() ? RED_COLOR : PRIMARY_COLOR,
                    maxLength: maxLength,
                    style: GoogleFonts.quicksand(
                      fontWeight: FontWeight.w500,
                      color: DARK_GREY_TEXT_COLOR.withOpacity(0.9),
                      fontSize: 16,
                    ),
                    maxLines: maxLines,
                    focusNode: focusNode,
                    keyboardType: isNumberTextField
                        ? const TextInputType.numberWithOptions(
                            decimal: false, signed: false)
                        : null,
                    inputFormatters: isNumberTextField
                        ? [
                            FilteringTextInputFormatter.allow(
                              RegExp(
                                r'[0-9 ]',
                              ),
                            ),
                          ]
                        : null,
                    decoration: InputDecoration(
                      hintText: hintText,
                      hintStyle: GoogleFonts.quicksand(
                        fontSize: 12,
                        color: DARK_GREY_TEXT_COLOR.withOpacity(0.6),
                        fontWeight: FontWeight.w500,
                      ),
                      counterText: '',
                      isCollapsed: true,
                      border: InputBorder.none,
                    ),
                    onChanged: onChange,
                  ),
                ),
                Visibility(
                  visible: !checkEmptyString.call(),
                  child: InkWell(
                    onTap: () {
                      onDelete.call();
                      textEditingController.text = '';
                      focusNode.requestFocus();
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      maxRadius: 10,
                      child: SvgPicture.asset(
                        ICON_PATH + CLOSE_SVG,
                        height: 10,
                        color: RED_COLOR.withOpacity(0.8),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Visibility(
            visible: checkErrorText.call(),
            child: Align(
              alignment: Alignment.topRight,
              child: Text(
                errorText,
                style: GoogleFonts.quicksand(
                  fontWeight: FontWeight.w500,
                  color: RED_COLOR,
                  fontSize: 10,
                  letterSpacing: 1,
                  height: 2,
                ),
              ),
            ),
          ),
          Visibility(
            visible: !checkEmptyString.call() || !checkErrorText.call(),
            child: Align(
              alignment: Alignment.topRight,
              child: Text(
                countText.call(),
                style: GoogleFonts.quicksand(
                  fontWeight: FontWeight.w500,
                  color: DARK_GREY_TEXT_COLOR.withOpacity(0.8),
                  fontSize: 12,
                  letterSpacing: 1,
                  height: 2,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget CUSTOM_DISABLE_TEXT_FIELD({
  required String initText,
  TextInputFormatter? textInputFormatter,
  bool isNumber = false,
}) {
  FocusNode focusNode = FocusNode();
  TextEditingController textEditingController = TextEditingController();
  textEditingController.text = initText;
  List<TextInputFormatter> textInputFormatterList = [];
  if (textInputFormatter != null) {
    textInputFormatterList.add(textInputFormatter);
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        height: 45,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: const Color.fromARGB(255, 185, 197, 214),
          ),
          color: const Color.fromARGB(255, 241, 244, 247),
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: textEditingController,
                textAlign: isNumber ? TextAlign.end : TextAlign.start,
                style: GoogleFonts.quicksand(
                  fontWeight: FontWeight.w500,
                  color: DARK_GREY_TEXT_COLOR.withOpacity(0.6),
                  fontSize: 16,
                  letterSpacing: 1,
                ),
                enabled: false,
                focusNode: focusNode,
                decoration: const InputDecoration(
                  counterText: '',
                  isCollapsed: true,
                  border: InputBorder.none,
                ),
                onChanged: (_) {},
                inputFormatters: textInputFormatterList,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget GRADIENT_WIDGET({
  required Widget child,
  Gradient gradient = const LinearGradient(colors: [
    Color.fromARGB(255, 123, 41, 255),
    Color.fromARGB(255, 1, 226, 226),
  ]),
}) =>
    ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: child,
    );

Widget CUSTOM_TEXT(
  String data, {
  TextAlign textAlign = TextAlign.start,
  FontWeight fontWeight = FontWeight.w500,
  Color color = DARK_GREY_TEXT_COLOR,
  double fontSize = 16,
  double letterSpacing = 0.5,
  FontStyle fontStyle = FontStyle.normal,
  Color backGroundColor = Colors.transparent,
  TextOverflow textOverflow = TextOverflow.ellipsis,
  EdgeInsets padding = EdgeInsets.zero,
}) =>
    Padding(
      padding: padding,
      child: Text(
        data,
        textAlign: textAlign,
        overflow: textOverflow,
        style: GoogleFonts.quicksand(
            fontWeight: fontWeight,
            color: color,
            fontSize: fontSize,
            letterSpacing: letterSpacing,
            fontStyle: fontStyle,
            backgroundColor: backGroundColor),
      ),
    );

Widget LOADING_WIDGET({double size = 150}) => Center(
      child: SpinKitSpinningLines(
        color: PRIMARY_COLOR,
        size: size,
      ),
    );

Widget NO_DATA_WIDGET({double size = 200, String? content}) => Center(
      child: SizedBox(
        height: size,
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Column(
            children: [
              Image.asset(
                IMAGE_PATH + NO_DATA_ART_PNG,
                height: 140,
              ),
              CUSTOM_TEXT(
                'OOOPS!',
                fontSize: 20,
                fontWeight: FontWeight.w700,
                padding: const EdgeInsets.only(bottom: 5),
              ),
              CUSTOM_TEXT(
                content ?? 'Sorry no data found.',
                fontSize: 14,
                color: DARK_GREY_TEXT_COLOR.withOpacity(0.7),
              ),
            ],
          ),
        ),
      ),
    );

Widget NOTIFICATION_POPUP_WIDGET({
  required Function() onTapBackground,
  required Function() onTapOk,
  required String content,
  required Function<bool>() isVisible,
  bool isSuccessNotification = true,
}) =>
    Obx(
      () => Visibility(
        visible: isVisible.call(),
        child: InkWell(
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
              height: 230,
              width: 290,
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 20,
                            bottom: 20,
                          ),
                          child: Image.asset(
                            isSuccessNotification
                                ? IMAGE_PATH + LAZY_CAT_PNG
                                : IMAGE_PATH + LAZY_CAT_PNG,
                            height: 50,
                          ),
                        ),
                        CUSTOM_TEXT(
                          isSuccessNotification ? 'Success!' : 'Failed!',
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color:
                              isSuccessNotification ? GREEN_COLOR : RED_COLOR,
                          letterSpacing: 1.5,
                        ),
                        CUSTOM_TEXT(
                          content,
                          textOverflow: TextOverflow.clip,
                          textAlign: TextAlign.center,
                          color: DARK_GREY_TEXT_COLOR.withOpacity(0.8),
                          fontSize: 14,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 5),
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
        ),
      ),
    );
