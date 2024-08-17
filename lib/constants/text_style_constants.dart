import 'package:flutter/material.dart';

class TextStyleConstant {
  static const TextStyle _basePoppins = TextStyle(
    fontFamily: 'Poppins',
  );

  static final TextStyle poppinsRegular = _basePoppins.copyWith(
    fontSize: 14,
    color: Colors.white,
  );

  static final TextStyle poppinsSemiBold = _basePoppins.copyWith(
    fontSize: 16,
    color: Colors.white,
    fontWeight: FontWeight.w600,
  );

  static final TextStyle poppinsBold = _basePoppins.copyWith(
    fontSize: 24,
    color: Colors.white,
    fontWeight: FontWeight.w700,
  );
}
