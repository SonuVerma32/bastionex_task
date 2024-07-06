import '../../configs/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../common-widgets.dart';


class CustomTextFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final bool readOnly;
  final String hintText;
  Function()? onTab;
  final String? Function(String?)? validator;
  final int fieldType;
  double? radius;
  final int maxline;
  final String title;
  final bool mandatory;

  CustomTextFieldWidget(
      {required this.controller,
      this.readOnly = false,
      required this.hintText,
      this.onTab,
      this.radius,
      required this.validator,
      this.fieldType = 0,
      this.maxline = 1,
      required this.title,
      this.mandatory = false});

  @override
  State<CustomTextFieldWidget> createState() => _CustomTextFieldWidgetState();
}

class _CustomTextFieldWidgetState extends State<CustomTextFieldWidget> {
  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        widget.title!.isEmpty
            ? SizedBox()
            : CustomTextWidget(
                context: context,
                text: widget.title,
                isMandatory: widget.mandatory,
                color: textColor,
                fontSize: 15,
                fontWeight: FontWeight.w400),
        TextFormField(
          onTap: widget.onTab,
          maxLines: widget.maxline,
          obscureText: widget.fieldType == 0 ? !_passwordVisible : false,
          keyboardType: widget.fieldType == 1
              ? TextInputType.number
              : widget.fieldType == 3
                  ? TextInputType.emailAddress
                  : TextInputType.text,
          inputFormatters: widget.fieldType == 1
              ? [
                  FilteringTextInputFormatter.digitsOnly,
                  // ThousandsSeparatorInputFormatter()
                ]
              : widget.fieldType == 2
                  ? [FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]"))]
                  : widget.fieldType == 3
                      ? null
                      : [],
          readOnly: widget.readOnly,
          //  textAlignVertical: TextAlignVertical.center,
          controller: widget.controller,
          style: theme.textTheme.displaySmall!.copyWith(
              color: textColor, fontWeight: FontWeight.w400, fontSize: 15),
          decoration: InputDecoration(
            filled: true,
            suffixIcon: widget.fieldType == 0
                ? IconButton(
                    icon: Icon(
                      // Based on passwordVisible state choose the icon
                      _passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: theme.colorScheme.onBackground,
                    ),
                    onPressed: () {
                      // Update the state i.e. toogle the state of passwordVisible variable
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  )
                : Icon(
                    Icons.text_decrease,
                    color: Colors.transparent,
                  ),
            prefix: Padding(padding: EdgeInsets.only(left: 16.0)),
            fillColor: inputFieldFillColor,
            errorMaxLines: 4,
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.radius ?? 10),
                borderSide: BorderSide(color: lightBorderColor)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.radius ?? 10),
                borderSide: BorderSide(color: lightBorderColor)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.radius ?? 10),
                borderSide: BorderSide(color: lightBorderColor)),
            contentPadding: EdgeInsets.fromLTRB(0, 14, 16, 14),
            isDense: true,
            hintText: widget.hintText,
            hintStyle: theme.textTheme.displaySmall!.copyWith(
                color: textColor, fontWeight: FontWeight.w400, fontSize: 15),
          ),
          validator: widget.validator,
        ),
      ],
    );
  }
}
