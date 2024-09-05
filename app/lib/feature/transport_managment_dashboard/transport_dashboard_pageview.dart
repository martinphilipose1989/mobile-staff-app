import 'package:app/feature/transport_managment_dashboard/transport_dashboard_page_viewmodel.dart';
import 'package:app/themes_setup.dart';
import 'package:app/utils/app_typography.dart';
import 'package:app/utils/common_widgets/app_images.dart';

import 'package:app/utils/common_widgets/common_card_wrapper.dart';
import 'package:app/utils/common_widgets/common_image_widget.dart';
import 'package:app/utils/common_widgets/common_primary_elevated_button.dart';
import 'package:app/utils/common_widgets/common_text_widget.dart';

import 'package:app/utils/common_widgets/toggle_option_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:statemanagement_riverpod/statemanagement_riverpod.dart';

class TransportDashboardPageView
    extends BasePageViewWidget<TransportDashboardPageViewModel> {
  // ignore: use_super_parameters
  TransportDashboardPageView(
      ProviderBase<TransportDashboardPageViewModel> model)
      : super(model);

  @override
  Widget build(BuildContext context, TransportDashboardPageViewModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: REdgeInsets.all(16.0),
          child: ToggleOptionList<String>(
              selectedValue: model.selectedTripStatus,
              options: model.tripStatusType,
              onSelect: (value) => {}),
        ),
        const UpcomingTripListTile(),
      ],
    );
  }
}

class UpcomingTripListTile extends StatelessWidget {
  const UpcomingTripListTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const CommonCardWrapper(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [TripListTileHeader()]),
    );
  }
}

class TripListTileHeader extends StatelessWidget {
  const TripListTileHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CommonImageWidget(
          imageUrl: "",
          fallbackAssetImagePath: AppImages.defaultBus,
          imageHeight: 40.h,
          imageWidth: 40.w,
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonText(
                text: "MH47-PK-9386",
                style: AppTypography.subtitle2,
                color: AppColors.textDark,
              ),
              CommonText(
                text: "Vibgyor High Malad West",
                maxLines: 1,
                overflow: TextOverflow
                    .ellipsis, // Ensures text truncates with ellipsis
                style: AppTypography.body2,
                color: AppColors.textGray,
              ),
            ],
          ),
        ),
        CommonPrimaryElevatedButton(
          title: "Start",
          titleTextStyle: AppTypography.subtitle2,
          onPressed: () {},
          icon: SvgPicture.asset(AppImages.playButton),
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.primaryOn,
        )
      ],
    );
  }
}
