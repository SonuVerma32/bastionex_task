import 'package:flutter/material.dart';

import '../configs/app_colors.dart';

Widget CustomTextWidget(
    {required String text,
    Color? color,
    double? fontSize,
    int? maxLine,
    bool? isMandatory,
    TextAlign? textAlign,
    FontWeight? fontWeight,
    BuildContext? context}) {
  return Wrap(
    // mainAxisAlignment: MainAxisAlignment.start,
    // crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text(text,
          maxLines: maxLine ?? 10,
          textAlign: textAlign ?? TextAlign.start,
          style: TextStyle(
              color: color ?? textColor,
              fontSize: fontSize ?? 18,
              fontWeight: fontWeight ?? FontWeight.w500)),
      isMandatory == true
          ? Text('*',
              style: TextStyle(
                  fontWeight: FontWeight.w400, color: Colors.red, fontSize: fontSize ?? 18))
          : Text(''),
    ],
  );
}

Text getTextRegularHeadingWidget(String text,
    {TextAlign textAlign = TextAlign.start}) {
  return Text(
    text,
    textAlign: textAlign,
    style: TextStyle(
        color: textColor,
        fontSize: 14,
        fontWeight: FontWeight.w500
    ),
  );
}
