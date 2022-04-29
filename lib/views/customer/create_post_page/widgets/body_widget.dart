import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/create_post_page_controller.dart';

class BodyWidget extends GetView<CreatePostPageController> {
  const BodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
      child: titleTextFieldWidget(size: size),
    );
  }

  Widget titleTextFieldWidget({required Size size}) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Title',
                style: GoogleFonts.quicksand(
                  fontWeight: FontWeight.w500,
                  color: const Color.fromARGB(255, 78, 98, 124),
                  fontSize: 16,
                ),
              ),
              Text(
                '*',
                style: GoogleFonts.quicksand(
                  fontWeight: FontWeight.w800,
                  color: const Color.fromARGB(255, 241, 99, 88),
                  fontSize: 20,
                ),
              ),
            ],
          ),
          SizedBox(
            width: size.width - 100,
            height: 45,
            child: Obx(
              () => TextFormField(
                cursorColor: PRIMARY_COLOR,
                initialValue: controller.title.value,
                maxLength: 40,
                style: GoogleFonts.quicksand(
                  fontWeight: FontWeight.w500,
                  color: const Color.fromARGB(255, 78, 98, 124),
                  fontSize: 16,
                ),
                decoration: controller.title.value.isEmpty &&
                        !controller.isFirstInputTitle
                    ? const InputDecoration(
                        errorText: 'The field title is required',
                        suffixIcon: Icon(
                          Icons.error,
                          color: Color.fromARGB(255, 241, 99, 88),
                          size: 20,
                        ),
                      )
                    : InputDecoration(
                        counterText: '',
                        suffixIcon: Align(
                          widthFactor: 1,
                          heightFactor: 1,
                          child: Text(
                            controller.title.value.length.toString() + '/40',
                            style: GoogleFonts.quicksand(
                              fontWeight: FontWeight.w500,
                              color: const Color.fromARGB(255, 78, 98, 124),
                              fontSize: 13,
                            ),
                          ),
                        ),
                        border: const OutlineInputBorder(),
                      ),
                onChanged: (String? value) {
                  controller.title.value = value!;
                  controller.isFirstInputTitle = false;
                },
              ),
            ),
          ),
        ],
      );

  Widget postTypeWidget() => Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'Post type:',
            style: GoogleFonts.quicksand(
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.italic,
              color: LIGHT_GREY_COLOR,
              fontSize: 16,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Obx(
            () => DropdownButton<String>(
              value: controller.selectedTicketType.value,
              style: GoogleFonts.itim(
                color: PRIMARY_COLOR,
                fontSize: 15,
              ),
              underline: Container(
                height: 2,
                color: PRIMARY_COLOR,
              ),
              onChanged: (String? value) {
                controller.selectedTicketType.value = value!;
              },
              items: <String>['PURCHASE', 'BREEDING']
                  .map<DropdownMenuItem<String>>(
                    (String value) => DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      );
}
