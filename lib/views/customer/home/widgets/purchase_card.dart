import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/home_controller.dart';
import 'package:petapp_mobile/models/purchase_post/purchase_post.dart';
import 'package:petapp_mobile/utilities/utilities.dart';

class PurchaseCard extends GetView<HomeController> {
  const PurchaseCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: CustomScrollView(
          slivers: [
            SliverGrid.count(
              crossAxisCount: 2,
              childAspectRatio: 0.65,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
              children: controller.purchasePosts
                  .asMap()
                  .entries
                  .map(
                    (e) => PurchaseCardItem(purchasePost: e.value),
                  )
                  .toList(),
            )
          ],
        ),
      );
}

class PurchaseCardItem extends GetView<HomeController> {
  const PurchaseCardItem({Key? key, required this.purchasePost})
      : super(key: key);
  final PurchasePost purchasePost;

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: () {},
        child: Container(
          margin: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(7),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 3,
              )
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(7),
                      ),
                      child: Container(
                        height: 200,
                        alignment: Alignment.topCenter,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            alignment: Alignment.topCenter,
                            image: NetworkImage(purchasePost.petImage[0]),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 10,
                      left: 10,
                      child: Text(
                        purchasePost.breed,
                        style: GoogleFonts.satisfy(
                          color: WHITE_COLOR,
                          fontSize: 23,
                        ),
                      ),
                    ),
                    // purchasePost.percentDiscount != 0
                    //     ? Positioned(
                    //         top: 16,
                    //         right: 16,
                    //         child: Container(
                    //           width: 30,
                    //           height: 30,
                    //           alignment: Alignment.center,
                    //           decoration: const BoxDecoration(
                    //             color: PRIMARY_TRANSPARENT_COLOR,
                    //             shape: BoxShape.circle,
                    //           ),
                    //           child: Text(
                    //             '-' +
                    //                 purchasePost.percentDiscount.toString() +
                    //                 '%',
                    //             textAlign: TextAlign.center,
                    //             style: const TextStyle(
                    //                 color: Colors.white, fontSize: 12),
                    //           ),
                    //         ),
                    //       )
                    //     : const SizedBox.shrink(),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15, right: 15, bottom: 10, top: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      purchasePost.title,
                      textAlign: TextAlign.left,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.itim(
                        fontSize: 14,
                        color: Colors.black87,
                        height: 1,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Text(
                    //       purchasePost.petName,
                    //       style: GoogleFonts.satisfy(
                    //         color: DARK_GREY_COLOR,
                    //         fontSize: 23,
                    //       ),
                    //     ),
                    //     Text(
                    //       FORMAT_MONEY(
                    //         price: purchasePost.price /
                    //             100 *
                    //             (100 - purchasePost.percentDiscount),
                    //       ),
                    //       style: const TextStyle(
                    //         fontSize: 18,
                    //         color: PRIMARY_COLOR,
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    Center(
                      child: RichText(
                        text: TextSpan(
                          text: 'Price: ',
                          style: GoogleFonts.itim(
                            color: LIGHT_GREY_COLOR,
                            fontSize: 12,
                            fontStyle: FontStyle.italic,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: FORMAT_MONEY(price: purchasePost.price),
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                color: PRIMARY_COLOR,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Wrap(
                      spacing: 4,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        SizedBox(
                          height: 25,
                          width: 55,
                          child: Material(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(25),
                            ),
                            color: purchasePost.isMale
                                ? const Color.fromARGB(255, 196, 213, 245)
                                : const Color.fromARGB(255, 243, 208, 228),
                            child: Text(
                              purchasePost.isMale ? 'Male' : 'Female',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.itim(
                                fontSize: 14,
                                color: purchasePost.isMale
                                    ? const Color.fromARGB(255, 55, 121, 244)
                                    : const Color.fromARGB(255, 244, 55, 165),
                                height: 1.5,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 25,
                          width: 70,
                          child: Material(
                            color: const Color.fromARGB(255, 233, 233, 233),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(25),
                            ),
                            child: Text(
                              purchasePost.age.toString() + ' Month',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.itim(
                                fontSize: 14,
                                color: DARK_GREY_COLOR,
                                height: 1.5,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
}
