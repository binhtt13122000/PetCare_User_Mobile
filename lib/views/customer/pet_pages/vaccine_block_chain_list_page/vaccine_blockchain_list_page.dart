import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/pet_page_controllers/pet_block_chain_page_controller.dart';
import 'package:petapp_mobile/views/customer/pet_pages/vaccine_block_chain_list_page/widgets/body_widget.dart';
import 'package:petapp_mobile/views/customer/pet_pages/vaccine_block_chain_list_page/widgets/select_vaccine_widget.dart';
import 'package:petapp_mobile/views/customer/pet_pages/vaccine_block_chain_list_page/widgets/top_widget.dart';

class VaccineBlockChainListPage extends GetView<PetBlockChainPageController> {
  const VaccineBlockChainListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller
      ..setMapVaccines()
      ..sortMapVaccines();
    return Scaffold(
      backgroundColor: WHITE_COLOR,
      body: Stack(
        children: [
          Column(
            children: const [
              VaccineBlockChainListPageTopWidget(),
              VaccineBlockChainListPageBodyWidget(),
            ],
          ),
          const VaccineBlockChainListPageVaccinesWidget(),
        ],
      ),
    );
  }
}
