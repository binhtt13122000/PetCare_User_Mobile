// ignore_for_file: constant_identifier_names, non_constant_identifier_names

import 'dart:io';

import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

const DATE_PATTERN = 'MMM dd yyyy';
const DATE_PATTERN_2 = 'dd/MM/yyyy';
const DATE_PATTERN_3 = 'dd/MM/yy';

const TIME_PATTERN = 'HH:mm a';
const DATE_TIME_PATTERN = 'MMM dd yyyy, HH:mm a';

String FORMAT_MONEY({required int price}) {
  String moneyText =
      NumberFormat.currency(locale: 'vi', symbol: '₫', decimalDigits: 0)
          .format(price);
  return moneyText;
}

String FORMAT_MONEY_WITHOUT_SYMBOL({required int price}) {
  String moneyText =
      NumberFormat.currency(locale: 'vi', symbol: '', decimalDigits: 0)
          .format(price);
  return moneyText;
}

String FORMAT_DATE_TIME({required DateTime dateTime, required String pattern}) {
  DateFormat dateFormat = DateFormat(pattern);
  return dateFormat.format(dateTime);
}

Future<File?> PICK_IMAGE({bool isPickFromGalley = true}) async {
  try {
    final XFile? image = await ImagePicker().pickImage(
        source: isPickFromGalley ? ImageSource.gallery : ImageSource.camera);

    return image == null ? null : File(image.path);
  } on PlatformException catch (_) {
    return null;
  }
}

Future<List<File>?> PICK_IMAGE_LIST() async {
  try {
    final List<XFile>? imagesXFile = await ImagePicker().pickMultiImage();

    if (imagesXFile != null) {
      List<File> images = [];
      for (var element in imagesXFile) {
        images.add(File(element.path));
      }
      return images;
    }

    return null;
  } on PlatformException catch (_) {
    return null;
  }
}

class CustomTextFormatter extends TextInputFormatter {
  final String sample;
  final String separator;

  CustomTextFormatter({required this.sample, required this.separator});

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isNotEmpty) {
      if (newValue.text.length > oldValue.text.length) {
        if (newValue.text.length > sample.length) return oldValue;
        if (newValue.text.length < sample.length &&
            sample[newValue.text.length - 1] == separator) {
          return TextEditingValue(
            text:
                '${oldValue.text}$separator${newValue.text.substring(newValue.text.length - 1)}',
            selection:
                TextSelection.collapsed(offset: newValue.selection.end + 1),
          );
        }
      }
    }
    return newValue;
  }
}
