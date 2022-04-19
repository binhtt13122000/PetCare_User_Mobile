// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

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
