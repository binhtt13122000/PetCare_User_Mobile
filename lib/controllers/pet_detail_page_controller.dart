// ignore_for_file: avoid_print

import 'dart:io';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class PetDetailPageController extends GetxController {
  RxList<dynamic> images = List.empty(growable: true).obs;
  
  Future pickImageFromGallery() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) return;

      final tmpImage = File(image.path);

      images.add(tmpImage);
    } on PlatformException catch (e) {
      print(e.toString());
    }
  }

  Future pickImageFromCamera() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);

      if (image == null) return;

      final tmpImage = File(image.path);

      images.add(tmpImage);
    } on PlatformException catch (e) {
      print(e.toString());
    }
  }
}
