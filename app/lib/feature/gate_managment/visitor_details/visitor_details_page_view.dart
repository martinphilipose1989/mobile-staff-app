import 'package:app/feature/gate_managment/visitor_details/visitor_details_viewmodel.dart';
import 'package:app/molecules/gate_managment/visitor_details/visitor_details_row.dart';
import 'package:app/molecules/gate_managment/visitor_details/visitor_info_card.dart';
import 'package:app/themes_setup.dart';
import 'package:app/utils/app_typography.dart';
import 'package:app/utils/common_widgets/app_images.dart';
import 'package:app/utils/common_widgets/common_primary_elevated_button.dart';
import 'package:app/utils/common_widgets/common_text_widget.dart';
import 'package:data/data.dart';

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
    return StreamBuilder<VisitorDataModel>(
      stream: model.visitorDetails,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          VisitorDataModel visitorData = snapshot.data!;

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
                        VisitorInfoCard(
                          visitorName: visitorData.visitorName ?? '',
                          issuedOn: visitorData.issuedDate ?? '',
                          qrImagePath: AppImages.qrImage,
                          avatarImagePath: AppImages.defaultAvatar,
                          // avatarImagePath:
                          //     visitorData.visitorProfileImageImageUrl ?? '',
                        ),
                        SizedBox(height: 16.h),
                        VisitorDetailsRow(
                          title1: "Contact Number",
                          value1: visitorData.visitorMobile ?? '',
                          title2: "Email ID",
                          value2: visitorData.visitorEmail ?? '',
                        ),
                        SizedBox(height: 16.h),
                        const VisitorDetailsRow(
                          title1: "Type of visitor",
                          //value1: "parent",
                          value1: "",
                          title2: "Student Name",
                          // value2: "Khevna Shah",
                          value2: "",
                        ),
                        SizedBox(height: 16.h),
                        VisitorDetailsRow(
                          title1: "Point Of Contact",
                          value1: visitorData.pointOfContact ?? '',
                          title2: "Purpose Of Visit",
                          value2: visitorData.purposeOfVisit ?? '',
                        ),
                        SizedBox(height: 16.h),
                        VisitorDetailsRow(
                          title1: "IN Date& Time",
                          value1: visitorData.incomingTime ?? '',
                          title2: "Coming From",
                          value2: visitorData.comingFrom ?? '',
                        ),
                        SizedBox(height: 16.h),
                        const VisitorDetailsRow(
                          title1: "Guest Count",
                          // value1: "1",
                          value1: "",
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
                padding:
                    REdgeInsets.only(bottom: 16, right: 16, left: 16, top: 16),
                child: CommonPrimaryElevatedButton(
                    title: "Close",
                    width: MediaQuery.of(context).size.width,
                    onPressed: () {
                      Navigator.pop(context);
                    }),
              )
            ],
          );
        } else {
          return const Center(child: Text('No Data Found!'));
        }
      },
    );
  }
}
