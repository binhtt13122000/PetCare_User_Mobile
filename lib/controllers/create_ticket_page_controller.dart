// ignore_for_file: avoid_print

import 'dart:io';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CreateTicketPageController extends GetxController {
  RxList<File> evidences = <File>[].obs;
  RxList<String> evidencesPath = <String>[].obs;
  RxString title = ''.obs;
  RxString description = ''.obs;
  RxString selectedTicketType = 'PURCHASE'.obs;
  bool isFirstInputTitle = true;
  bool isFirstInputDescription = true;

  Future pickImageFromGallery() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) return;

      final tmpImage = File(image.path);

      evidences.add(tmpImage);
      evidencesPath.add(tmpImage.path);
    } on PlatformException catch (e) {
      print(e.toString());
    }
  }

  Future pickImageFromCamera() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);

      if (image == null) return;

      final tmpImage = File(image.path);

      evidences.add(tmpImage);
      evidencesPath.add(tmpImage.path);
    } on PlatformException catch (e) {
      print(e.toString());
    }
  }
}
