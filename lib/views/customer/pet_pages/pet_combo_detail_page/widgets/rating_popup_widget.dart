import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/pet_page_controllers/pet_combo_detail_page_controller.dart';
import 'package:petapp_mobile/services/pet_services/pet_combo_detail_services.dart';

class PetComboDetailRatingPopupWidget
    extends GetView<PetComboDetailPageController> {
  const PetComboDetailRatingPopupWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isShowRatingPopup.value
          ? InkWell(
              onTap: () => controller.isShowRatingPopup.value = false,
              child: Container(
                color: const Color.fromARGB(106, 198, 188, 201),
                alignment: Alignment.center,
                child: InkWell(
                  onTap: () {},
                  child: Container(
                    width: 320,
                    height: 420,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 15),
                    decoration: BoxDecoration(
                      color: WHITE_COLOR,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              text: 'Rating for services\n',
                              style: GoogleFonts.quicksand(
                                color: DARK_GREY_TEXT_COLOR,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 1,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: controller.selectedPetComboDetailModel
                                      .centerServiceModel.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: PRIMARY_COLOR,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        ratingBarWidget(),
                        quickRateWidget(),
                        descriptionWidget(),
                        submitButtonWidget(),
                      ],
                    ),
                  ),
                ),
              ),
            )
          : const SizedBox.shrink(),
    );
  }

  Widget quickRateWidget() => Column(
        children: [
          Container(
            height: 1,
            color: DARK_GREY_COLOR.withOpacity(0.1),
            margin: const EdgeInsets.symmetric(vertical: 10),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'What was great about your services?',
              textAlign: TextAlign.start,
              style: GoogleFonts.quicksand(
                color: const Color.fromARGB(255, 85, 91, 110),
                fontWeight: FontWeight.w500,
                fontSize: 13,
                height: 1,
                letterSpacing: 0.5,
              ),
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
              children: [
                quickRateTextWidget(content: 'Followed instructions'),
                quickRateTextWidget(content: 'Good price'),
                quickRateTextWidget(content: 'Enthusiastic staff'),
                quickRateTextWidget(content: 'Punctuality'),
              ],
            ),
          ),
        ],
      );

  Widget quickRateTextWidget({required content}) => Obx(
        () => InkWell(
          onTap: () => controller.quickFeedBackList.contains(content)
              ? controller.quickFeedBackList.remove(content)
              : controller.quickFeedBackList.add(content),
          child: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: controller.quickFeedBackList.contains(content)
                  ? PRIMARY_COLOR
                  : WHITE_COLOR,
              border: Border.all(
                color: controller.quickFeedBackList.contains(content)
                    ? PRIMARY_COLOR
                    : const Color.fromARGB(255, 85, 91, 110),
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              content,
              textAlign: TextAlign.start,
              style: GoogleFonts.quicksand(
                color: controller.quickFeedBackList.contains(content)
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

  Widget ratingBarWidget() => Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Obx(
          () => Row(
            children: [
              SizedBox(
                width: 90,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    controller.ratingText.value,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.quicksand(
                      color: const Color.fromARGB(255, 85, 91, 110),
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                      height: 1,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: RatingBar.builder(
                  initialRating: controller.selectedStar.value.toDouble(),
                  itemCount: 5,
                  itemSize: 40,
                  allowHalfRating: false,
                  unratedColor: Colors.amber.withOpacity(0.2),
                  itemBuilder: (context, index) => const Icon(
                    Icons.star_rate_rounded,
                    color: Color.fromARGB(255, 255, 211, 78),
                  ),
                  onRatingUpdate: (index) {
                    controller
                      ..selectedStar.value = index.toInt()
                      ..updateRatingText();
                  },
                ),
              ),
            ],
          ),
        ),
      );

  Widget submitButtonWidget() => Padding(
        padding: const EdgeInsets.only(
          top: 30,
        ),
        child: InkWell(
          onTap: () async {
            if (controller.selectedStar.value != 0) {
              controller
                ..isShowRatingPopup.value = false
                ..isWaitLoadingDataForeGround.value = true;
              String reviewContent = '';
              int index = 0;
              do {
                reviewContent += index == controller.quickFeedBackList.length
                    ? '${controller.quickFeedBackList[index]}, '
                    : '${controller.quickFeedBackList[index]}. ';
                index++;
              } while (index < controller.quickFeedBackList.length - 1);

              reviewContent = reviewContent.isNotEmpty
                  ? reviewContent + ' ' + controller.reviewContent
                  : controller.reviewContent;

              await PetComboDetailServices.updatePetComboDetail(
                  jwt: controller.accountModel.jwtToken,
                  id: controller.selectedPetComboDetailModel.id,
                  star: controller.selectedStar.value,
                  realTime: controller.selectedPetComboDetailModel.realTime!,
                  isCompleted: true,
                  review: reviewContent,
                  isAllCompleted: false);

              controller
                ..selectedStar.value = 0
                ..reviewContent = ''
                ..quickFeedBackList.clear()
                ..notificationTitle = 'Send feedback for services '
                ..isWaitLoadingDataForeGround.value = false
                ..isShowNotificationPopup.value = true;
            }
          },
          child: Obx(
            () => Container(
              height: 35,
              decoration: BoxDecoration(
                color: controller.selectedStar.value != 0
                    ? PRIMARY_COLOR.withOpacity(0.9)
                    : PRIMARY_COLOR.withOpacity(0.3),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: controller.selectedStar.value != 0
                      ? PRIMARY_COLOR
                      : PRIMARY_COLOR.withOpacity(0.3),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: DARK_GREY_COLOR.withOpacity(0.1),
                    blurRadius: 5,
                    offset: const Offset(2, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Submit',
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
      );

  Widget descriptionWidget() {
    TextEditingController _textEditingController = TextEditingController();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Text(
            'Description',
            style: GoogleFonts.quicksand(
              fontWeight: FontWeight.w500,
              color: const Color.fromARGB(255, 61, 78, 100),
              fontSize: 16,
              letterSpacing: 0.5,
            ),
          ),
        ),
        Container(
          height: 70,
          alignment: Alignment.topLeft,
          margin: const EdgeInsets.only(top: 8),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color.fromARGB(255, 167, 181, 201),
              width: 1.2,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: TextField(
                  minLines: 3,
                  maxLines: 3,
                  controller: _textEditingController,
                  onChanged: (String text) {
                    controller.reviewContent = text;
                  },
                  keyboardType: TextInputType.multiline,
                  cursorColor: PRIMARY_COLOR,
                  style: GoogleFonts.quicksand(
                    fontWeight: FontWeight.w500,
                    color: const Color.fromARGB(255, 113, 135, 168),
                    fontSize: 15,
                    letterSpacing: 1,
                  ),
                  decoration: InputDecoration.collapsed(
                    hintText: 'Tell us more about your services experience...',
                    hintStyle: GoogleFonts.quicksand(
                      fontWeight: FontWeight.w500,
                      color: const Color.fromARGB(255, 162, 176, 194),
                      fontSize: 13,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
