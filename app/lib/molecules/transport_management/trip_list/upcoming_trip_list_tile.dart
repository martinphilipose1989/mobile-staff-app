import 'package:app/themes_setup.dart';
import 'package:app/utils/app_typography.dart';
import 'package:app/utils/common_widgets/app_images.dart';
import 'package:app/utils/common_widgets/common_card_wrapper.dart';
import 'package:app/utils/common_widgets/common_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'trip_list_tile_header.dart';
import 'trip_tile_detail_item.dart';

class UpcomingTripListTile extends StatelessWidget {
  const UpcomingTripListTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CommonCardWrapper(
      bottom: 16,
      right: 16,
      left: 16,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TripListTileHeader(),
          const Divider(color: AppColors.textPalerGray),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            TripTileDetailItem(
                title: "Prabhadevi",
                subtitle: "PBD",
                subtitleTextStyle: AppTypography.h6),
            Stack(
              alignment: Alignment.bottomCenter,
              clipBehavior: Clip.none,
              children: [
                Image.asset(AppImages.routeImage, height: 48.h, width: 144.w),
                CommonText(
                    text: "Rno: XYZ1213",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    color: AppColors.textGray,
                    style: AppTypography.smallCaption)
              ],
            ),
            TripTileDetailItem(
                title: "Malad",
                subtitle: "MLD",
                subtitleTextStyle: AppTypography.h6),
          ]),
          const SizedBox(height: 16),
          Row(children: [
            const TripTileDetailItem(
                title: "Students", subtitle: "15 Students"),
            SizedBox(width: 32.w),
            const TripTileDetailItem(title: "Action", subtitle: "Pickup"),
            SizedBox(width: 32.w),
            const TripTileDetailItem(title: "Shift", subtitle: "Morning"),
          ]),
        ],
      ),
    );
  }
}
