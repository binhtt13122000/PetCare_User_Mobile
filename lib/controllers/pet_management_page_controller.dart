// ignore_for_file: avoid_print

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petapp_mobile/graphql/graphql_config.dart';
import 'package:petapp_mobile/models/pet_model/pet_model.dart';

class PetManagementPageController extends GetxController {
  RxList<dynamic> images = List.empty(growable: true).obs;
  ValueNotifier<GraphQLClient> graphqlClient = GRAPHQL_CLIENT;

  late RxList<PetModel> pets;

  final RxMap<String, int> petManagementTableHeaders = {
    'Name': 0,
    'Breed': 0,
    'Sex': 0,
  }.obs;

  setHeaderFilter(String headerKey) {
    petManagementTableHeaders.forEach((key, value) {
      if (key == headerKey) {
        if (value == 0 || value == 2) {
          petManagementTableHeaders[key] = 1;
          switch (headerKey) {
            case 'Name':
              break;
            case 'Breed':
              break;
            case 'Age':
              break;
            case 'Gender':
              break;
          }
        } else {
          petManagementTableHeaders[key] = 2;
          switch (headerKey) {
            case 'Name':
              break;
            case 'Breed':
              break;
            case 'Age':
              break;
            case 'Gender':
              break;
          }
        }
      } else {
        petManagementTableHeaders[key] = 0;
      }
    });
  }

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
