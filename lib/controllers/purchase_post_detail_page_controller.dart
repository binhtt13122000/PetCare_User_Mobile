import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petapp_mobile/models/post_model/post_model.dart';

class PurchasePostDetailPageController extends GetxController {
  final PostModel postModel;

  RxInt selectedPetImageIndex = 0.obs;
  RxBool isShowDescription = false.obs;
  ScrollController mainScrollController = ScrollController();
  PurchasePostDetailPageController({required this.postModel});
}
