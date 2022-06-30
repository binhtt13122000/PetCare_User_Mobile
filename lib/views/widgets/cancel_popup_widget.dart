import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class CancelPopupWidget extends StatelessWidget {
  const CancelPopupWidget({
    Key? key,
    required this.onTapBackground,
    required this.title,
    required this.content,
    required this.quickRateText,
    required this.onChangeDescription,
    required this.descriptionHintText,
    required this.isAllowSubmit,
    required this.onTapSubmit,
    required this.onTapQuickRateText,
    required this.isSelected,
    required this.counterDescriptionText,
    required this.onDeleteDescription,
    required this.checkEmptyDescription,
  }) : super(key: key);

  final Function() onTapBackground;
  final String title;
  final String content;
  final List<String> quickRateText;
  final Function(String? content) onChangeDescription;
  final String descriptionHintText;
  final Function<bool>() isAllowSubmit;
  final Function() onTapSubmit;
  final Function({required String content}) onTapQuickRateText;
  final Function<bool>({required String content}) isSelected;
  final Function<String>() counterDescriptionText;
  final Function() onDeleteDescription;
  final Function<bool>() checkEmptyDescription;

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
              height: 345,
              decoration: BoxDecoration(
                color: WHITE_COLOR,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 15),
                    child: Column(
                      children: [
                        CUSTOM_TEXT(
                          title,
                          textAlign: TextAlign.center,
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 2,
                          color: PRIMARY_COLOR,
                        ),
                        quickRateWidget(
                            content: content, quickRateText: quickRateText),
                        descriptionWidget(
                          onChangeDescription: onChangeDescription,
                          descriptionHintText: descriptionHintText,
                          checkEmptyDescription: checkEmptyDescription,
                          counterDescriptionText: counterDescriptionText,
                          onDeleteDescription: onDeleteDescription,
                        ),
                      ],
                    ),
                  ),
                  submitButtonWidget(
                      isAllowSummit: isAllowSubmit, onTapSummit: onTapSubmit),
                ],
              ),
            ),
          ),
        ),
      );

  Widget quickRateWidget(
          {required String content, required List<String> quickRateText}) =>
      Column(
        children: [
          Container(
            height: 1,
            color: DARK_GREY_COLOR.withOpacity(0.1),
            margin: const EdgeInsets.symmetric(vertical: 10),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: CUSTOM_TEXT(
              content,
              textAlign: TextAlign.start,
              fontSize: 13,
              color: DARK_GREY_TEXT_COLOR.withOpacity(0.85),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Wrap(
              alignment: WrapAlignment.start,
              direction: Axis.horizontal,
              crossAxisAlignment: WrapCrossAlignment.start,
              runAlignment: WrapAlignment.start,
              verticalDirection: VerticalDirection.down,
              spacing: 10,
              runSpacing: 10,
              children: quickRateText
                  .map((e) => quickRateTextWidget(
                        content: e,
                        onTapQuickRateText: onTapQuickRateText,
                        isSelectedQuickRateText: isSelected,
                      ))
                  .toList(),
            ),
          ),
        ],
      );

  Widget quickRateTextWidget({
    required content,
    required Function({required String content}) onTapQuickRateText,
    required Function<bool>({required String content}) isSelectedQuickRateText,
  }) =>
      Obx(
        () => InkWell(
          onTap: () {
            onTapQuickRateText(content: content);
          },
          child: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: isSelectedQuickRateText.call(content: content)
                  ? PRIMARY_COLOR
                  : WHITE_COLOR,
              border: Border.all(
                color: isSelectedQuickRateText.call(content: content)
                    ? PRIMARY_COLOR
                    : const Color.fromARGB(255, 85, 91, 110),
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              content,
              textAlign: TextAlign.start,
              style: GoogleFonts.quicksand(
                color: isSelectedQuickRateText.call(content: content)
                    ? WHITE_COLOR
                    : const Color.fromARGB(255, 85, 91, 110),
                fontWeight: FontWeight.w500,
                fontSize: 15,
                height: 1,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ),
      );

  Widget submitButtonWidget(
          {required Function() onTapSummit,
          required Function<bool>() isAllowSummit}) =>
      Expanded(
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
                    child: Obx(
                      () => InkWell(
                        onTap: onTapSubmit,
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: isAllowSummit.call()
                                ? PRIMARY_COLOR.withOpacity(0.9)
                                : PRIMARY_COLOR.withOpacity(0.3),
                            borderRadius: const BorderRadius.only(
                              bottomRight: Radius.circular(10),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'SUBMIT',
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.clip,
                                style: GoogleFonts.quicksand(
                                  color: WHITE_COLOR,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 2,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 7),
                                child: SvgPicture.asset(
                                  ICON_PATH + SEND_SVG,
                                  height: 18,
                                  color: WHITE_COLOR,
                                ),
                              ),
                            ],
                          ),
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

  Widget descriptionWidget({
    required Function(String? content) onChangeDescription,
    required String descriptionHintText,
    required Function<String>() counterDescriptionText,
    required Function() onDeleteDescription,
    required Function<bool>() checkEmptyDescription,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 0),
            child: Text(
              'Description',
              style: GoogleFonts.quicksand(
                fontWeight: FontWeight.w500,
                color: DARK_GREY_TEXT_COLOR.withOpacity(0.85),
                fontSize: 14,
                letterSpacing: 0.5,
              ),
            ),
          ),
          CUSTOM_REQUIRED_TEXT_FIELD(
              hintText: descriptionHintText,
              maxLength: 200,
              height: 80,
              maxLines: 3,
              onChange: onChangeDescription,
              checkEmptyString: checkEmptyDescription,
              checkErrorText: <bool>() {
                return false;
              },
              onDelete: onDeleteDescription,
              errorText: '',
              countText: counterDescriptionText,
              padding: const EdgeInsets.only(top: 5)),
        ],
      ),
    );
  }
}
