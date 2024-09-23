import 'package:app/themes_setup.dart';
import 'package:app/utils/common_widgets/common_card_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'trip_list_tile_header.dart';
import 'trip_tile_detail_item.dart';

class CompletedTripListTile extends StatelessWidget {
  const CompletedTripListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonCardWrapper(
      bottom: 16,
      left: 16,
      right: 16,
      isPrimary: false,
      child: Column(
        children: [
          const TripListTileHeader(tripStatus: "Completed"),
          const Divider(color: AppColors.textPalerGray),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const TripTileDetailItem(
                    title: "Pickup point", subtitle: "Prabhadevi"),
                SizedBox(height: 24.h),
                const TripTileDetailItem(
                    title: "Students", subtitle: "15 Students"),
              ]),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const TripTileDetailItem(
                    title: "Drop point", subtitle: "Malad"),
                SizedBox(height: 24.h),
                const TripTileDetailItem(title: "Action", subtitle: "Pickup"),
              ]),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const TripTileDetailItem(
                    title: "Route No", subtitle: "Rno: XYZ1213"),
                SizedBox(height: 24.h),
                const TripTileDetailItem(title: "Shift", subtitle: "Morning"),
              ])
            ],
          )
        ],
      ),
    );
  }
}
