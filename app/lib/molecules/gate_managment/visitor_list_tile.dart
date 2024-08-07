import 'package:app/themes_setup.dart';
import 'package:app/utils/app_typography.dart';
import 'package:app/utils/common_widgets/common_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VisitorListTile extends StatelessWidget {
  const VisitorListTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: REdgeInsets.only(bottom: 16),
      shadowColor: const Color(0xFF4C4E64).withOpacity(0.22),
      surfaceTintColor: AppColors.listItem,
      color: AppColors.listItem,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
      child: Container(
        padding: REdgeInsets.all(16),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 32.r,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 28.r,
                        backgroundImage:
                            const AssetImage('assets/images/Banner.png'),
                      ),
                    ),
                    SizedBox(width: 5.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: "Rohan Takale\t",
                                style: AppTypography.caption.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.textDark,
                                    fontSize: 12.sp),
                              ),
                              TextSpan(
                                text: "(Visitor: ID#1234)",
                                style: AppTypography.overline.copyWith(
                                    fontSize: 10.sp,
                                    color: AppColors.textGray,
                                    letterSpacing: 0.25),
                              )
                            ],
                          ),
                        ),
                        CommonText(
                          text: "Parent | Student: Khevna Shah",
                          style: AppTypography.overline.copyWith(
                              color: AppColors.textGray,
                              fontSize: 10.sp,
                              letterSpacing: 0.25),
                        ),
                        CommonText(
                          text: "Rohanthale22@gmail.com",
                          style: AppTypography.overline.copyWith(
                              color: AppColors.textGray,
                              fontSize: 10.sp,
                              letterSpacing: 0.25),
                        ),
                        CommonText(
                          text: "9876543212",
                          style: AppTypography.overline.copyWith(
                              color: AppColors.textGray, letterSpacing: 0.25),
                        ),
                      ],
                    )
                  ],
                ),
                Container(
                  height: 36.h,
                  width: 92.w,
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    color: AppColors.primaryLighter,
                  ),
                  child: CommonText(
                      text: "IN",
                      style: AppTypography.overline.copyWith(
                          color: AppColors.primary,
                          fontSize: 14.sp,
                          letterSpacing: 0)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
