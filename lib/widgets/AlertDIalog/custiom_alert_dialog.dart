import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../configs/app_colors.dart';

showAlert({String? submit, String? cancel, required String content, required VoidCallback onPressed, required BuildContext context}) {
  return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(24.0))),
      contentPadding:
          const EdgeInsets.only(top: 34, left: 20, right: 20, bottom: 0),
      actionsPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 16),
      backgroundColor: lightBackgroundColor,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            textAlign: TextAlign.center,
            content,
            style: TextStyle(color: textColor, fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ],
      ),
      actions: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
                width: double.infinity,
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 68, right: 68, bottom: 0),
                  child: GestureDetector(
                    onTap: () {
                      onPressed();
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 24),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                      color: buttonColor),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            submit ?? "Sign Out",
                            style: TextStyle(
                                color: textColorLight,
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                  ),
                )),
          ],
        )
      ]);
}
showAlertSingleAction({String? submit, required String content, required VoidCallback onPressed}) {
  return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(24.0))),
      contentPadding:
      const EdgeInsets.only(top: 34, left: 20, right: 20, bottom: 0),
      actionsPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 16),
      backgroundColor: lightBackgroundColor,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            textAlign: TextAlign.center,
            content,
            style: TextStyle(color: textColor, fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ],
      ),
      actions: [
        SizedBox(
            width: double.infinity,
            child: Padding(
              padding:
              const EdgeInsets.only(left: 68, right: 68, bottom: 0),
              child: GestureDetector(
                onTap: () {
                  onPressed();
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 18, vertical: 24),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: buttonColor),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        submit ?? "Okay",
                        style: TextStyle(
                            color: textColorLight,
                            fontSize: 15,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
              ),
            )),
      ]);
}
