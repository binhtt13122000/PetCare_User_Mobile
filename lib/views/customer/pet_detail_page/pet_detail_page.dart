import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/pet_management_page_controller.dart';
import 'package:petapp_mobile/models/pet_model/pet_model.dart';
import 'package:petapp_mobile/utilities/utilities.dart';

class PetDetaiPage extends GetView<PetManagementPageController> {
  const PetDetaiPage({Key? key, required this.petModel}) : super(key: key);
  final PetModel petModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 400,
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(30),
                    ),
                    image: DecorationImage(
                      image: NetworkImage(petModel.avatar),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 25,
                  left: 25,
                  child: InkWell(
                    onTap: () => Get.back(),
                    child: Container(
                      width: 40,
                      height: 40,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        color: Colors.white70,
                        shape: BoxShape.circle,
                      ),
                      child: SvgPicture.asset(
                        ICON_PATH + BACK_SVG,
                        color: PRIMARY_COLOR,
                        height: 15,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 25,
                  right: 25,
                  child: InkWell(
                    child: Container(
                      width: 40,
                      height: 40,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        color: Colors.white70,
                        shape: BoxShape.circle,
                      ),
                      child: SvgPicture.asset(
                        ICON_PATH + ADD_IMAGE_SVG,
                        color: PRIMARY_COLOR,
                        height: 23,
                      ),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(top: 370),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 5,
                        width: 30,
                        margin: const EdgeInsets.symmetric(horizontal: 3),
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          color: PRIMARY_COLOR,
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                      ),
                      Container(
                        height: 5,
                        width: 15,
                        margin: const EdgeInsets.symmetric(horizontal: 3),
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 234, 217, 235),
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                      ),
                      Container(
                        height: 5,
                        width: 15,
                        margin: const EdgeInsets.symmetric(horizontal: 3),
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 234, 217, 235),
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    petModel.breedModel.name,
                    style: GoogleFonts.itim(
                      fontSize: 30,
                      color: DARK_GREY_COLOR,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    petModel.breedModel.speciesModel!.id == 1
                        ? '(Dog)'
                        : '(Cat)',
                    style: GoogleFonts.itim(
                      fontSize: 20,
                      color: DARK_GREY_COLOR.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(
                left: 10,
                bottom: 10,
              ),
              child: Row(
                children: [
                  SvgPicture.asset(
                    ICON_PATH + BIRTH_CAKE_SVG,
                    color: Colors.black54,
                    height: 23,
                  ),
                  Text(
                    ' DOB: ',
                    style: GoogleFonts.quicksand(
                      fontSize: 15,
                      color: Colors.black54,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  Text(
                    FORMAT_DATE_TIME(
                        dateTime: petModel.dob, pattern: DATE_PATTERN),
                    style: GoogleFonts.quicksand(
                      fontSize: 15,
                      color: Colors.black54,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    ' Status: ',
                    style: GoogleFonts.quicksand(
                      fontSize: 15,
                      color: Colors.black54,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  Text(
                    petModel.status,
                    style: GoogleFonts.quicksand(
                      fontSize: 15,
                      color: Colors.black54,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(15),
                    ),
                    border: Border.all(
                      width: 1,
                      color: Colors.black12,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Sex',
                        style: GoogleFonts.quicksand(
                          fontSize: 14,
                          color: Colors.black38,
                        ),
                      ),
                      Text(
                        petModel.gender,
                        style: GoogleFonts.quicksand(
                            fontSize: 15,
                            color: petModel.gender == 'MALE'
                                ? const Color.fromARGB(255, 39, 111, 245)
                                : const Color.fromARGB(255, 244, 55, 165),
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(15),
                    ),
                    border: Border.all(
                      width: 1,
                      color: Colors.black12,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Age',
                        style: GoogleFonts.quicksand(
                          fontSize: 14,
                          color: Colors.black38,
                        ),
                      ),
                      Text(
                        '12 months',
                        style: GoogleFonts.quicksand(
                            fontSize: 13,
                            color: DARK_GREY_COLOR,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(15),
                    ),
                    border: Border.all(
                      width: 1,
                      color: Colors.black12,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Weight',
                        style: GoogleFonts.quicksand(
                          fontSize: 14,
                          color: Colors.black38,
                        ),
                      ),
                      Text(
                        '3.5 kg',
                        style: GoogleFonts.quicksand(
                            fontSize: 15,
                            color: DARK_GREY_COLOR,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Container(
              height: 100,
              padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
              margin: const EdgeInsets.only(bottom: 20),
              alignment: Alignment.centerLeft,
              child: SingleChildScrollView(
                child: Text(
                  petModel.description != null ? petModel.description! : '',
                  style: GoogleFonts.quicksand(
                    fontSize: 15,
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 55,
                  width: 110,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(15),
                    ),
                    border: Border.all(
                      width: 1,
                      color: PRIMARY_COLOR,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        ICON_PATH + EDIT_SVG,
                        color: PRIMARY_COLOR,
                        height: 23,
                      ),
                      Text(
                        'Edit Profile',
                        style: GoogleFonts.itim(
                            fontSize: 15,
                            color: PRIMARY_COLOR,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 55,
                  width: 200,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: PRIMARY_COLOR,
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                  child: Text(
                    'Health Records',
                    style: GoogleFonts.itim(
                      fontSize: 17,
                      color: WHITE_COLOR,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
