import 'package:app/feature/gate_managment/visitor_details/visitor_details_viewmodel.dart';
import 'package:app/molecules/gate_managment/visitor_details/visitor_details_row.dart';
import 'package:app/molecules/gate_managment/visitor_details/visitor_info_card.dart';
import 'package:app/themes_setup.dart';
import 'package:app/utils/app_typography.dart';
import 'package:app/utils/common_widgets/app_images.dart';
import 'package:app/utils/common_widgets/common_primary_elevated_button.dart';
import 'package:app/utils/common_widgets/common_text_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:statemanagement_riverpod/statemanagement_riverpod.dart';

class VisitorDetailsPageView
    extends BasePageViewWidget<VisitorDetailsViewModel> {
  // ignore: use_super_parameters
  VisitorDetailsPageView(
    ProviderBase<VisitorDetailsViewModel> model,
  ) : super(model);

  @override
  Widget build(
    BuildContext context,
    VisitorDetailsViewModel model,
  ) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: REdgeInsets.all(
                16.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const VisitorInfoCard(
                    visitorName: "Vipul Patel ( #1234 )",
                    issuedOn: "16-05-2024",
                    qrImagePath: AppImages.qrImage,
                    avatarImagePath: AppImages.defaultAvatar,
                  ),
                  SizedBox(height: 16.h),
                  const VisitorDetailsRow(
                    title1: "Contact Number",
                    value1: "+91-9628365637",
                    title2: "Email ID",
                    value2: "xys@gmail.com",
                  ),
                  SizedBox(height: 16.h),
                  const VisitorDetailsRow(
                    title1: "Type of visitor",
                    value1: "parent",
                    title2: "Student Name",
                    value2: "Khevna Shah",
                  ),
                  SizedBox(height: 16.h),
                  const VisitorDetailsRow(
                    title1: "Point Of Contact",
                    value1: "Rohan Thale",
                    title2: "Purpose Of Visit",
                    value2: "Meeting",
                  ),
                  SizedBox(height: 16.h),
                  const VisitorDetailsRow(
                    title1: "IN Date& Time",
                    value1: "15 Jul 2024 10:00AM",
                    title2: "Coming From",
                    value2: "Virar",
                  ),
                  SizedBox(height: 16.h),
                  const VisitorDetailsRow(
                    title1: "Guest Count",
                    value1: "1",
                  ),
                  Divider(
                    height: 32.h,
                    color: AppColors.dividerColor,
                  ),
                  CommonText(
                    text: "QR Details",
                    style: AppTypography.subtitle1.copyWith(
                      color: AppColors.textGray,
                      fontSize: 16.sp,
                      height: 1.1,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  SvgPicture.asset(
                    AppImages.qrImage,
                    height: 120.w,
                    width: 120.w,
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: REdgeInsets.only(
            bottom: 16,
            right: 16,
            left: 16,
          ),
          child: CommonPrimaryElevatedButton(
              title: "Close",
              width: MediaQuery.of(context).size.width,
              onPressed: () {
                Navigator.pop(context);
              }),
        )
      ],
    );
  }
}
