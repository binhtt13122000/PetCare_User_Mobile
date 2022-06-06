// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/theme.dart';

Widget GRADIENT_WIDGET({
  required Widget child,
  Gradient gradient = const LinearGradient(colors: [
    Color.fromARGB(255, 123, 41, 255),
    Color.fromARGB(255, 1, 226, 226),
  ]),
}) =>
    ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: child,
    );

Widget CUSTOM_TEXT(
  String data, {
  TextAlign textAlign = TextAlign.start,
  FontWeight fontWeight = FontWeight.w500,
  Color color = DARK_GREY_TEXT_COLOR,
  double fontSize = 16,
  double letterSpacing = 0.5,
  FontStyle fontStyle = FontStyle.normal,
  Color backGroundColor = Colors.transparent,
  TextOverflow textOverflow = TextOverflow.ellipsis,
  EdgeInsets padding = EdgeInsets.zero,
}) =>
    Padding(
      padding: padding,
      child: Text(
        data,
        textAlign: textAlign,
        overflow: textOverflow,
        style: GoogleFonts.quicksand(
            fontWeight: fontWeight,
            color: color,
            fontSize: fontSize,
            letterSpacing: letterSpacing,
            fontStyle: fontStyle,
            backgroundColor: backGroundColor),
      ),
    );
