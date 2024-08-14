import 'package:app/molecules/gate_managment/visit_status_widget.dart';
import 'package:app/themes_setup.dart';
import 'package:app/utils/app_typography.dart';
import 'package:app/utils/common_widgets/app_images.dart';
import 'package:app/utils/common_widgets/common_text_widget.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VisitorListTile extends StatelessWidget {
  const VisitorListTile({super.key, required this.visitorDataModel});

  final VisitorDataModel? visitorDataModel;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: REdgeInsets.only(bottom: 16),
      shadowColor: AppColors.shadowColor,
      surfaceTintColor: AppColors.listItem,
      color: visitorDataModel?.visitStatus?.toLowerCase() == "in"
          ? AppColors.listItem
          : AppColors.listItemDisabled,
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
                        backgroundImage: visitorDataModel?.visitorProfileImage
                                    ?.contains("http") ??
                                false
                            ? NetworkImage(
                                "${visitorDataModel?.visitorProfileImage}")
                            : const AssetImage(AppImages.defaultAvatar)
                                as ImageProvider<Object>?,
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
                                text: "${visitorDataModel?.visitorName}\t",
                                style: AppTypography.caption.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.textDark,
                                    fontSize: 12.sp),
                              ),
                              TextSpan(
                                text:
                                    "(Visitor: ID#${visitorDataModel?.visitorId})",
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
                          text: "${visitorDataModel?.visitorEmail}",
                          style: AppTypography.overline.copyWith(
                              color: AppColors.textGray,
                              fontSize: 10.sp,
                              letterSpacing: 0.25),
                        ),
                        CommonText(
                          text: "${visitorDataModel?.visitorMobile}",
                          style: AppTypography.overline.copyWith(
                              color: AppColors.textGray, letterSpacing: 0.25),
                        ),
                      ],
                    )
                  ],
                ),
                VisitStatusWidget(
                    visitStatus:
                        visitorDataModel?.visitStatus?.toLowerCase() ?? "")
              ],
            ),
            Divider(height: 12.h, color: AppColors.dividerColor),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: "Point Of Contact:",
                      style: AppTypography.smallCaption
                          .copyWith(letterSpacing: 0.25),
                    ),
                    TextSpan(
                      text: "${visitorDataModel?.pointOfContact}",
                      style: AppTypography.caption.copyWith(
                          fontSize: 10.sp,
                          color: visitorDataModel?.visitStatus?.toLowerCase() ==
                                  "in"
                              ? AppColors.textDark
                              : AppColors.textGray,
                          letterSpacing: 0.25),
                    )
                  ],
                ),
              ),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: "IN:",
                      style: AppTypography.smallCaption
                          .copyWith(letterSpacing: 0.25),
                    ),
                    TextSpan(
                      text: "15 Jul 2024 10:00 AM",
                      style: AppTypography.caption.copyWith(
                          fontSize: 10.sp,
                          color: visitorDataModel?.visitStatus?.toLowerCase() ==
                                  "in"
                              ? AppColors.textDark
                              : AppColors.textGray,
                          letterSpacing: 0.25),
                    )
                  ],
                ),
              ),
            ]),
            SizedBox(height: 12.h),
            Container(
              alignment: Alignment.center,
              width: double.infinity,
              padding: REdgeInsets.symmetric(vertical: 6, horizontal: 16),
              decoration: BoxDecoration(
                  color: visitorDataModel?.visitStatus?.toLowerCase() == "in"
                      ? AppColors.primaryLighter
                      : AppColors.dividerColor,
                  borderRadius: BorderRadius.circular(6.r)),
              child: Text(
                  "Purpose Of Visit:${visitorDataModel?.purposeOfVisit}",
                  style: AppTypography.caption.copyWith(
                      color:
                          visitorDataModel?.visitStatus?.toLowerCase() == "in"
                              ? AppColors.primary
                              : AppColors.textGray)),
            )
          ],
        ),
      ),
    );
  }
}
