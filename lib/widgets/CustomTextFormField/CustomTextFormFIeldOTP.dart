import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

import '../../configs/app_colors.dart';

class CustomTextFieldWidgetOTP extends StatefulWidget {
  final TextEditingController controller;
  final bool readOnly;
  final String hintText;
  Function()? onTab;
  final String? Function(String?)? validator;
  final String title;
  final bool mandatory;

  CustomTextFieldWidgetOTP(
      {required this.controller,
      this.readOnly = false,
      required this.hintText,
      this.onTab,
      required this.validator,
      required this.title,
      this.mandatory = false});

  @override
  State<CustomTextFieldWidgetOTP> createState() =>
      _CustomTextFieldWidgetOTPState();
}

class _CustomTextFieldWidgetOTPState extends State<CustomTextFieldWidgetOTP> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                      text: widget.title,
                      style: Theme.of(context).textTheme.headline1?.copyWith(
                          color: textColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w400)),
                  widget.mandatory == true
                      ? TextSpan(
                          text: '*',
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.red,
                              fontSize: 14))
                      : TextSpan(),
                ],
              ),
            )
          ],
        ),
        widget.title!.isEmpty
            ? SizedBox()
            : SizedBox(
                height: 10,
              ),
        Pinput(
          length: 6,
          controller: widget.controller,
          defaultPinTheme: PinTheme(
            width: MediaQuery.of(context).size.width * .15,
            height: 50,
            textStyle: TextStyle(
                fontSize: 14, color: textColor, fontWeight: FontWeight.w400),
            decoration: BoxDecoration(
              color: inputFieldFillColor,
              border: Border.all(color: lightBorderColor),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          validator: (s) {
            // controller.otpValid.value =
            // s!.length == 6 ? true : false;
            return s!.length == 6 ? null : 'Please enter valid OTP';
          },
          pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
          showCursor: true,
        ),
      ],
    );
  }
}

class CustomTextFieldWidgetOTP4 extends StatefulWidget {
  final TextEditingController controller;
  final bool readOnly;
  final String hintText;
  Function()? onTab;
  final String? Function(String?)? validator;
  final String title;
  final bool mandatory;

  CustomTextFieldWidgetOTP4(
      {required this.controller,
      this.readOnly = false,
      required this.hintText,
      this.onTab,
      required this.validator,
      required this.title,
      this.mandatory = false});

  @override
  State<CustomTextFieldWidgetOTP4> createState() =>
      _CustomTextFieldWidgetOTP4State();
}

class _CustomTextFieldWidgetOTP4State extends State<CustomTextFieldWidgetOTP4> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                      text: widget.title,
                      style: Theme.of(context).textTheme.headline1?.copyWith(
                          color: textColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w400)),
                  widget.mandatory == true
                      ? TextSpan(
                          text: '*',
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.red,
                              fontSize: 14))
                      : TextSpan(),
                ],
              ),
            )
          ],
        ),
        widget.title.isEmpty
            ? SizedBox()
            : SizedBox(
                height: 10,
              ),
        Pinput(
          length: 6,
          controller: widget.controller,
          defaultPinTheme: PinTheme(
            width: MediaQuery.of(context).size.width * .15,
            height: 50,
            textStyle: TextStyle(
                fontSize: 14, color: textColor, fontWeight: FontWeight.w400),
            decoration: BoxDecoration(
              color: inputFieldFillColor,
              border: Border.all(color: lightBorderColor),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          validator: (s) {
            // controller.otpValid.value =
            // s!.length == 6 ? true : false;
            return s!.length == 6 ? null : 'Please enter valid OTP';
          },
          pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
          showCursor: true,
        ),
      ],
    );
  }
}
