import 'package:app/themes_setup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonCardWrapper extends StatelessWidget {
  const CommonCardWrapper(
      {super.key,
      required this.child,
      this.isPrimary = true,
      this.primaryColor = AppColors.listItem,
      this.secondaryColor = AppColors.listItemDisabled});

  final Widget child;
  final Color primaryColor;
  final Color secondaryColor;
  final bool isPrimary;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: REdgeInsets.only(left: 16, right: 16, bottom: 16),
      padding: REdgeInsets.all(16),
      decoration: BoxDecoration(
          color: isPrimary ? primaryColor : secondaryColor,
          borderRadius: BorderRadius.circular(8.r),
          boxShadow: [
            BoxShadow(
                color: AppColors.shadowColor.withOpacity(0.22),
                blurRadius: 10,
                offset: const Offset(0, 2))
          ]),
      child: child,
    );
  }
}
