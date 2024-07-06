import 'package:flutter/material.dart';

import '../../configs/app_colors.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 80,
        width: 80,
        decoration: BoxDecoration(
            color: primaryColor.withOpacity(.6),
            borderRadius: BorderRadius.circular(15)),
        child: Center(
            child: CircularProgressIndicator(
          color: containerColor,
        )),
      ),
    );
  }
}
