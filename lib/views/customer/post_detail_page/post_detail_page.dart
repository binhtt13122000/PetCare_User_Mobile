import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/purchase_posts_page_controller.dart';
import 'package:petapp_mobile/models/post_model/post_model.dart';
import 'package:petapp_mobile/utilities/utilities.dart';
import 'package:petapp_mobile/views/customer/deposit_page/deposit_page.dart';

class PostDetaiPage extends GetView<PurchasePostsPageController> {
  const PostDetaiPage({Key? key, required this.postModel}) : super(key: key);
  final PostModel postModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            //!Pet image
            Stack(
              children: [
                Container(
                  height: 400,
                  margin: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(30),
                    ),
                    image: DecorationImage(
                      image: NetworkImage(postModel.petModel!.avatar),
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
                        color: Color.fromARGB(88, 156, 39, 245),
                        shape: BoxShape.circle,
                      ),
                      child: SvgPicture.asset(
                        ICON_PATH + BOOKMARK_SVG,
                        color: WHITE_COLOR,
                        height: 21,
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
            //!Detail information
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            postModel.petModel!.breedModel.name,
                            style: GoogleFonts.itim(
                              fontSize: 30,
                              color: DARK_GREY_COLOR,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            '(' +
                                postModel
                                    .petModel!.breedModel.speciesModel!.name +
                                ')',
                            style: GoogleFonts.itim(
                              fontSize: 20,
                              color: DARK_GREY_COLOR.withOpacity(0.6),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                ' Price: ',
                                style: GoogleFonts.quicksand(
                                  fontSize: 18,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                              Text(
                                FORMAT_MONEY(price: postModel.price!),
                                style: GoogleFonts.quicksand(
                                  fontSize: 23,
                                  color: PRIMARY_COLOR,
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                ' Deposit: ',
                                style: GoogleFonts.quicksand(
                                  fontSize: 15,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                              Text(
                                FORMAT_MONEY(price: postModel.deposit!),
                                style: GoogleFonts.quicksand(
                                  fontSize: 18,
                                  color: PRIMARY_COLOR,
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                      ),
                      child: Row(
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
                                  'Type',
                                  style: GoogleFonts.quicksand(
                                    fontSize: 14,
                                    color: Colors.black38,
                                  ),
                                ),
                                Text(
                                  postModel.type!,
                                  style: GoogleFonts.quicksand(
                                      fontSize: 15,
                                      color: PRIMARY_COLOR,
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
                                  'Sex',
                                  style: GoogleFonts.quicksand(
                                    fontSize: 14,
                                    color: Colors.black38,
                                  ),
                                ),
                                Text(
                                  postModel.petModel!.gender,
                                  style: GoogleFonts.quicksand(
                                      fontSize: 15,
                                      color:
                                          postModel.petModel!.gender == 'MALE'
                                              ? const Color.fromARGB(
                                                  255, 39, 111, 245)
                                              : const Color.fromARGB(
                                                  255, 244, 55, 165),
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
                                  postModel.petModel!.ageRange.toString() +
                                      ' months',
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
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        postModel.title!,
                        style: GoogleFonts.itim(
                          fontSize: 18,
                          color: DARK_GREY_COLOR,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 5,
                      ),
                      child: Text(
                        postModel.description != null
                            ? postModel.description!
                            : '',
                        style: GoogleFonts.quicksand(
                          fontSize: 15,
                          color: Colors.black54,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 45,
                  width: 150,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(15),
                    ),
                    border: Border.all(
                      width: 1,
                      color: PRIMARY_COLOR,
                    ),
                  ),
                  child: Text(
                    'View Papers',
                    style: GoogleFonts.itim(
                        fontSize: 15,
                        color: PRIMARY_COLOR,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                InkWell(
                  onTap: () => Get.to(DepositPage(postModel: postModel)),
                  child: Container(
                    height: 45,
                    width: 150,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: PRIMARY_COLOR,
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    child: Text(
                      'Deposit',
                      style: GoogleFonts.itim(
                        fontSize: 17,
                        color: WHITE_COLOR,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
