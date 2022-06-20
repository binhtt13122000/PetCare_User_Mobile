import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/pet_page_controllers/pet_block_chain_page_controller.dart';
import 'package:petapp_mobile/views/customer/pet_pages/remove_ticks_blockchain_history_page/widgets/body_widget.dart';
import 'package:petapp_mobile/views/customer/pet_pages/remove_ticks_blockchain_history_page/widgets/top_widget.dart';

class RemoveTickBlockchainHistoryPage
    extends GetView<PetBlockChainPageController> {
  const RemoveTickBlockchainHistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: WHITE_COLOR,
        body: Column(
          children: const [
            RemoveTicksBlockchainHistoryTopWidget(),
            RemoveTicksBlockchainHistoryBodyWidget(),
          ],
        ),
      );
}
