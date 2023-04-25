import 'package:flutter/material.dart';

class Dimensions {
  Dimensions._();
  static Size responsiveSize = const Size(1, 1);
  static Orientation getOrientation(context) {
    return MediaQuery.of(context).orientation;
  }
}