import 'package:app/molecules/transport_management/arrival_info/arrival_info_tile.dart';
import 'package:app/utils/app_typography.dart';
import 'package:app/utils/common_widgets/app_images.dart';
import 'package:app/utils/common_widgets/common_image_widget.dart';
import 'package:app/utils/common_widgets/common_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:statemanagement_riverpod/statemanagement_riverpod.dart';
import 'bus_checklist_page_viewmodel.dart';

class BusChecklistPageView
    extends BasePageViewWidget<BusChecklistPageViewModel> {
  // ignore: use_super_parameters
  BusChecklistPageView(ProviderBase<BusChecklistPageViewModel> model)
      : super(model);

  @override
  Widget build(BuildContext context, BusChecklistPageViewModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
            padding: EdgeInsets.only(left: 16, right: 16, top: 16),
            child: ArrivalInfoTile(
                vehicleNumber: "MH47-PK-9386",
                startTime: "7:00 AM",
                totalStudents: 10)),
        Padding(
          padding: const EdgeInsets.all(16),
          child:
              CommonText(text: "Bus Checklist", style: AppTypography.subtitle2),
        ),
        ListTile(
          minVerticalPadding: 0,
          leading: CommonImageWidget(
            imageUrl: "imageUrl",
            clipBehavior: Clip.hardEdge,
            fallbackAssetImagePath: AppImages.defaultDriverAvatar,
            imageHeight: 40.h,
            imageWidth: 40.w,
          ),
          title:
              CommonText(text: "Ramesh Singh", style: AppTypography.subtitle2),
          subtitle: CommonText(text: "Driver", style: AppTypography.body2),
          trailing: TextButton.icon(
            icon: SvgPicture.asset(AppImages.checkMark),
            onPressed: () {},
            label: CommonText(text: "Confirm", style: AppTypography.subtitle2),
          ),
        ),
        ListTile(
          leading: CommonImageWidget(
            imageUrl: "imageUrl",
            clipBehavior: Clip.hardEdge,
            fallbackAssetImagePath: AppImages.defaultTeacherAvatar,
            imageHeight: 40.h,
            imageWidth: 40.w,
          ),
          title:
              CommonText(text: "Lily Santoz", style: AppTypography.subtitle2),
          subtitle:
              CommonText(text: "School Teacher", style: AppTypography.body2),
          trailing: TextButton.icon(
            icon: SvgPicture.asset(AppImages.checkMark),
            onPressed: () {},
            label: CommonText(text: "Confirm", style: AppTypography.subtitle2),
          ),
        )
      ],
    );
  }
}
