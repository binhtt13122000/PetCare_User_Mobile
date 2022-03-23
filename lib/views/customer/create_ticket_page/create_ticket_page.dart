import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/create_ticket_page_controller.dart';
import 'package:petapp_mobile/controllers/home_page_controller.dart';
import 'package:petapp_mobile/services/ticket/ticket_services.dart';

class CreateTicketPage extends GetView<CreateTicketPageController> {
  const CreateTicketPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomePageController homePageController = Get.find();

    return GraphQLProvider(
      client: homePageController.graphqlClient,
      child: Scaffold(
        backgroundColor: WHITE_COLOR,
        extendBody: true,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //!back button
                    InkWell(
                      onTap: () => Get.back(),
                      child: Container(
                        width: 40,
                        height: 40,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          color: PRIMARY_LIGHT_COLOR,
                          shape: BoxShape.circle,
                        ),
                        child: SvgPicture.asset(
                          ICON_PATH + BACK_SVG,
                          color: PRIMARY_COLOR,
                          height: 15,
                        ),
                      ),
                    ),
                    //!app logo
                    Row(
                      children: [
                        SvgPicture.asset(
                          ICON_PATH + PET_LOGO_SVG,
                          color: PRIMARY_COLOR,
                          height: 29,
                        ),
                        const SizedBox(
                          width: 2,
                        ),
                        Text(
                          'iU Petshop',
                          style: GoogleFonts.satisfy(
                            textStyle: const TextStyle(color: PRIMARY_COLOR),
                            fontWeight: FontWeight.w700,
                            fontSize: 25,
                            height: 1,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              //!Title
              Center(
                child: Text(
                  'Create Ticket',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.itim(
                    fontSize: 40,
                    color: PRIMARY_COLOR,
                    height: 2,
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      //!Title text field
                      Obx(
                        () => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: TextFormField(
                            cursorColor: PRIMARY_COLOR,
                            initialValue: controller.title.value,
                            maxLength: 40,
                            decoration: controller.title.value.isEmpty &&
                                    !controller.isFirstInputTitle
                                ? const InputDecoration(
                                    labelText: 'Title*',
                                    errorText: 'The field title is required',
                                    suffixIcon: Icon(
                                      Icons.error,
                                      color: Color.fromARGB(255, 241, 99, 88),
                                      size: 20,
                                    ),
                                  )
                                : const InputDecoration(
                                    labelText: 'Title*',
                                  ),
                            onChanged: (String? value) {
                              controller.title.value = value!;
                              controller.isFirstInputTitle = false;
                            },
                          ),
                        ),
                      ),
                      //!Description text field
                      Obx(
                        () => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: TextFormField(
                            cursorColor: PRIMARY_COLOR,
                            initialValue: controller.description.value,
                            maxLength: 200,
                            maxLines: 2,
                            minLines: 2,
                            decoration: controller.description.value.isEmpty &&
                                    !controller.isFirstInputDescription
                                ? const InputDecoration(
                                    labelText: 'Description*',
                                    errorText:
                                        'The field description is required',
                                    suffixIcon: Icon(
                                      Icons.error,
                                      color: Color.fromARGB(255, 241, 99, 88),
                                      size: 20,
                                    ),
                                  )
                                : const InputDecoration(
                                    labelText: 'Description*',
                                  ),
                            onChanged: (String? value) {
                              controller.description.value = value!;
                              controller.isFirstInputDescription = false;
                            },
                          ),
                        ),
                      ),
                      //!Ticket Type dropdown button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Ticket Type: ',
                            style: GoogleFonts.quicksand(
                              fontWeight: FontWeight.w500,
                              fontStyle: FontStyle.italic,
                              color: LIGHT_GREY_COLOR,
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
                      ),
                      //!Pick Image from Gallery button
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: MaterialButton(
                          color: PRIMARY_LIGHT_COLOR,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Pick Image from Gallery',
                                style: GoogleFonts.quicksand(
                                  color: PRIMARY_COLOR,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              SvgPicture.asset(
                                ICON_PATH + GALLERY_SVG,
                                color: PRIMARY_COLOR,
                                height: 23,
                              ),
                            ],
                          ),
                          onPressed: () {
                            controller.pickImageFromGallery();
                          },
                        ),
                      ),
                      //!Pick Image from Camera button
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: MaterialButton(
                          color: PRIMARY_LIGHT_COLOR,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Pick Image from Camera',
                                style: GoogleFonts.quicksand(
                                  color: PRIMARY_COLOR,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              SvgPicture.asset(
                                ICON_PATH + CAMERA_SVG,
                                color: PRIMARY_COLOR,
                                height: 23,
                              ),
                            ],
                          ),
                          onPressed: () {
                            controller.pickImageFromCamera();
                          },
                        ),
                      ),
                      //!Image view
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 40),
                        child: Obx(() {
                          return controller.evidences.isNotEmpty
                              ? SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Wrap(
                                    spacing: 10,
                                    children: controller.evidences
                                        .asMap()
                                        .entries
                                        .map((e) => ImageItem(index: e.key))
                                        .toList(),
                                  ))
                              : Container(
                                  width: 250,
                                  height: 180,
                                  alignment: Alignment.center,
                                  decoration: const BoxDecoration(
                                    color: Colors.black12,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(5),
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'No image is selected',
                                        style: GoogleFonts.itim(
                                          fontSize: 15,
                                          fontStyle: FontStyle.italic,
                                          color: Colors.black38,
                                        ),
                                      ),
                                      SvgPicture.asset(
                                        ICON_PATH + NO_IMAGE_SVG,
                                        color: Colors.black38,
                                        height: 30,
                                      ),
                                    ],
                                  ),
                                );
                        }),
                      ), //!Send Ticket button
                      // Mutation(
                      //   options: MutationOptions(document: gql(INSERT_TICKET)),
                      //   builder: (
                      //     RunMutation runMutaion,
                      //     QueryResult? result,
                      //   ) =>
                      //       Padding(
                      //     padding: const EdgeInsets.symmetric(
                      //       horizontal: 50,
                      //     ),
                      //     child: Obx(
                      //       () => MaterialButton(
                      //         height: 45,
                      //         color: controller.title.value.isNotEmpty &&
                      //                 controller.description.isNotEmpty
                      //             ? PRIMARY_COLOR
                      //             : PRIMARY_COLOR.withAlpha(100),
                      //         child: Row(
                      //           mainAxisAlignment: MainAxisAlignment.center,
                      //           children: [
                      //             Text(
                      //               'Send Ticket',
                      //               style: GoogleFonts.quicksand(
                      //                 color: WHITE_COLOR,
                      //                 fontWeight: FontWeight.w800,
                      //               ),
                      //             ),
                      //             const SizedBox(
                      //               width: 10,
                      //             ),
                      //             SvgPicture.asset(
                      //               ICON_PATH + SEND_SVG,
                      //               color: WHITE_COLOR,
                      //               height: 18,
                      //             ),
                      //           ],
                      //         ),
                      //         onPressed: () => controller
                      //                     .title.value.isNotEmpty &&
                      //                 controller.description.isNotEmpty
                      //             ? runMutaion({
                      //                 'name': 'Lap',
                      //                 'title': controller.title.value,
                      //                 'description':
                      //                     controller.description.value,
                      //                 'type':
                      //                     controller.selectedTicketType.value
                      //               })
                      //             : null,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      Obx(
                        () => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: MaterialButton(
                            height: 45,
                            color: controller.title.value.isNotEmpty &&
                                    controller.description.isNotEmpty
                                ? PRIMARY_COLOR
                                : PRIMARY_COLOR.withAlpha(100),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Send Ticket',
                                  style: GoogleFonts.quicksand(
                                    color: WHITE_COLOR,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                SvgPicture.asset(
                                  ICON_PATH + SEND_SVG,
                                  color: WHITE_COLOR,
                                  height: 18,
                                ),
                              ],
                            ),
                            onPressed: () => controller
                                        .title.value.isNotEmpty &&
                                    controller.description.isNotEmpty
                                ? TicketServices.CREATE_TICKET(
                                    name: 'Tiêu Trung Lập',
                                    phoneNumber: '+84901605667',
                                    type: controller.selectedTicketType.value,
                                    title: controller.title.value,
                                    date: DateTime.now(),
                                    description: controller.description.value,
                                    meetingTime: DateTime.now(),
                                    files: controller.evidencesPath)
                                : null,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ImageItem extends GetView<CreateTicketPageController> {
  const ImageItem({Key? key, required this.index}) : super(key: key);
  final int index;
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Stack(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(7),
            ),
            child: Image.file(
              controller.evidences[index],
              height: 180,
            ),
          ),
          Positioned(
            top: 5,
            right: 5,
            child: InkWell(
              onTap: () => controller.evidences.removeAt(index),
              child: Container(
                width: 25,
                height: 25,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 167, 53, 255),
                  shape: BoxShape.circle,
                ),
                child: Text(
                  'x',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.sourceSansPro(
                    color: WHITE_COLOR,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 5,
            right: 5,
            child: Container(
              width: 35,
              height: 25,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: Colors.white60,
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              child: Text(
                (index + 1).toString() +
                    ' / ' +
                    controller.evidences.length.toString(),
                textAlign: TextAlign.center,
                style: GoogleFonts.itim(
                  color: const Color.fromARGB(255, 167, 53, 255),
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
