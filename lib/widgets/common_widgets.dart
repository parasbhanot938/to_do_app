import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/constants/app_colors.dart';

Widget imageAsset({image, height, width, fit}) {
  return Image.asset(
    image,
    height: height,
    width: width,
    fit: fit,
  );
}

TextStyle textStyle =
     TextStyle(fontSize: 14.0, color: AppColors.blackColor.withOpacity(0.9));

bool isValidEmail(String email){
   bool emailValid =
  RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);
   return emailValid;
}