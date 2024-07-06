import 'package:flutter/material.dart';

import '../../configs/app_colors.dart';

class CustomFlatButton extends StatelessWidget {
  final Function onTap;
  final String text;
  final Widget? suffix;
  final LinearGradient? linearGradient;
  final Color? color;
  bool? loading = false;
  final double? buttonWidth;
  final double? buttonHeight;
  final double? fontSize;

  CustomFlatButton(
      {this.suffix,
      this.loading,
      this.color,
      this.linearGradient,
      required this.text,
      required this.onTap,
      this.buttonHeight,
      this.buttonWidth,
      super.key,
      this.fontSize});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        height: buttonHeight ?? 45,
        width: buttonWidth ?? 120,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
            color: color ?? buttonColor2,
            gradient: linearGradient ?? null,
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            loading ?? false
                ? SizedBox(
                    height: buttonHeight ?? 45,
                    width: (buttonHeight ?? 45) / 1.8,
                    child: CircularProgressIndicator(
                      color: secondaryColor,
                    ),
                  )
                : Text(
                    text,
                    style: TextStyle(
                      fontSize: fontSize ?? 15,
                      color: textColorLight,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
