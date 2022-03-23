import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:petapp_mobile/configs/path.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/transaction_page_controller.dart';
import 'package:petapp_mobile/graphql/query_mutation/sale_transaction.dart';
import 'package:petapp_mobile/services/sale_transaction_services/sale_transaction_services.dart';
import 'package:petapp_mobile/utilities/utilities.dart';
import 'package:petapp_mobile/views/customer/sale_transaction_detail_for_buyer_page/sale_transaction_detail_for_buyer_page.dart';
import 'package:petapp_mobile/views/customer/sale_transaction_detail_for_seller_page/sale_transaction_detail_for_seller_page.dart';

class TransactionPage extends GetView<TransactionPageController> {
  const TransactionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: controller.graphqlClient,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(
                  bottom: 20,
                ),
                decoration: BoxDecoration(
                  color: WHITE_COLOR,
                  boxShadow: [
                    BoxShadow(
                      color: DARK_GREY_COLOR.withOpacity(0.35),
                      offset: const Offset(1, 1),
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 20,
                        right: 20,
                        top: 10,
                        bottom: 10,
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
                          //!title
                          Text(
                            'Transaction History',
                            style: GoogleFonts.satisfy(
                              textStyle: const TextStyle(color: PRIMARY_COLOR),
                              fontWeight: FontWeight.w700,
                              fontSize: 25,
                              height: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                    //!Services
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: controller.services
                              .asMap()
                              .entries
                              .map(
                                (e) => Obx(
                                  () => Padding(
                                    padding: const EdgeInsets.only(
                                      right: 20,
                                      top: 5,
                                      bottom: 5,
                                    ),
                                    child: InkWell(
                                      onTap: () => controller
                                                  .selectedSevices.value ==
                                              e.value.name
                                          ? controller.selectedSevices.value =
                                              ''
                                          : controller.selectedSevices.value =
                                              e.value.name,
                                      child: Container(
                                          height: 30,
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                          ),
                                          decoration: BoxDecoration(
                                            color: e.value.name ==
                                                    controller
                                                        .selectedSevices.value
                                                ? PRIMARY_COLOR
                                                : PRIMARY_COLOR
                                                    .withOpacity(0.13),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            boxShadow: [
                                              BoxShadow(
                                                color: e.value.name ==
                                                        controller
                                                            .selectedSevices
                                                            .value
                                                    ? PRIMARY_COLOR
                                                        .withOpacity(0.7)
                                                    : WHITE_COLOR,
                                                offset: const Offset(1, 1),
                                                blurRadius: 8,
                                              ),
                                            ],
                                          ),
                                          child: Text(
                                            e.value.name,
                                            style: GoogleFonts.itim(
                                              color: e.value.name ==
                                                      controller
                                                          .selectedSevices.value
                                                  ? WHITE_COLOR
                                                  : PRIMARY_COLOR
                                                      .withOpacity(0.7),
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                              height: 1.5,
                                            ),
                                          )),
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 5,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //!Filter
                          InkWell(
                            onTap: () {},
                            child: Container(
                              height: 30,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 18,
                              ),
                              decoration: BoxDecoration(
                                color: PRIMARY_LIGHT_COLOR,
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                    color: PRIMARY_COLOR, width: 1.5),
                              ),
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    ICON_PATH + FILTER_SVG,
                                    height: 17,
                                    color: PRIMARY_COLOR,
                                  ),
                                  const SizedBox(
                                    width: 3,
                                  ),
                                  Text(
                                    'Filter',
                                    style: GoogleFonts.itim(
                                      color: PRIMARY_COLOR,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      height: 1.5,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          //!Sort
                          Row(
                            children: [
                              SvgPicture.asset(
                                ICON_PATH + SORT_SVG,
                                width: 15,
                                color: PRIMARY_COLOR,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Obx(
                                () => Padding(
                                  padding: const EdgeInsets.only(
                                    bottom: 4,
                                  ),
                                  child: DropdownButton<String>(
                                    value: controller.selectedSort.value,
                                    style: GoogleFonts.itim(
                                      color: PRIMARY_COLOR,
                                      fontSize: 15,
                                    ),
                                    underline: Container(
                                      height: 2,
                                      color: PRIMARY_COLOR,
                                    ),
                                    onChanged: (String? value) {
                                      controller.selectedSort.value = value!;
                                    },
                                    items: controller.sorts
                                        .asMap()
                                        .entries
                                        .map(
                                          (e) => DropdownMenuItem(
                                            child: Text(e.value),
                                            value: e.value,
                                          ),
                                        )
                                        .toList(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Obx(
                () => Visibility(
                  visible: controller.selectedSevices.value == 'Purchase',
                  child: Expanded(
                    child: Query(
                      options: QueryOptions(
                          document:
                              gql(FETCH_SALE_TRANSACTION_LIST_BY_BUYER_ID),
                          variables: {"_eq1": 3, "_eq2": 3}),
                      builder: (
                        QueryResult result, {
                        VoidCallback? refetch,
                        FetchMore? fetchMore,
                      }) {
                        if (result.hasException) {
                          return Text(result.exception.toString());
                        }
                        if (result.isLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        controller.saleTransactions =
                            SaleTransactionService.getSaleTransactionList(
                                    result.data!)
                                .obs;
                        return Column(
                          children: controller.saleTransactions
                              .asMap()
                              .entries
                              .map(
                                (e) => transactionItemWidget(index: e.key),
                              )
                              .toList(),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget transactionItemWidget({required int index}) => InkWell(
        onTap: () => Get.to(() =>
            controller.saleTransactions[index].buyerId == 1
                ? SaleTransactionForBuyerDetailPage(index: index)
                : SaleTransactionForSellerDetailPage(index: index)),
        child: Container(
          height: 100,
          margin: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          decoration: BoxDecoration(
            color: WHITE_COLOR,
            boxShadow: [
              BoxShadow(
                color: DARK_GREY_COLOR.withOpacity(
                  0.3,
                ),
                blurRadius: 10,
              ),
            ],
            borderRadius: const BorderRadius.all(Radius.circular(15)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.horizontal(
                  left: Radius.circular(15),
                ),
                child: Container(
                  width: 90,
                  alignment: Alignment.topCenter,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      alignment: Alignment.topCenter,
                      image: NetworkImage(controller
                          .saleTransactions[index].postModel.mediaModels!
                          .elementAt(0)
                          .url),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Golden Retriever',
                    style: GoogleFonts.quicksand(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: DARK_GREY_COLOR.withOpacity(0.9),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 4,
                    ),
                    child: Row(
                      children: [
                        Text(
                          'Status: ',
                          style: GoogleFonts.quicksand(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: DARK_GREY_COLOR.withOpacity(0.7),
                          ),
                        ),
                        Text(
                          controller.saleTransactions[index].status ==
                                  'NOT_PET_AVAILABLE'
                              ? 'Deposited'
                              : '',
                          style: GoogleFonts.quicksand(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: const Color.fromARGB(255, 83, 161, 197),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    FORMAT_DATE_TIME(
                        dateTime: controller.saleTransactions[index].createTime,
                        pattern: DATE_TIME_PATTERN),
                    style: GoogleFonts.quicksand(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: DARK_GREY_COLOR.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '540.000₫',
                    style: GoogleFonts.quicksand(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: PRIMARY_COLOR),
                  ),
                  Text(
                    'Type: Purchase',
                    style: GoogleFonts.quicksand(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.italic,
                      color: DARK_GREY_COLOR.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
              const SizedBox(),
            ],
          ),
        ),
      );
}
