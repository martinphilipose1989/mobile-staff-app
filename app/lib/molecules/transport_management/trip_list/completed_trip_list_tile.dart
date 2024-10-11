import 'package:app/themes_setup.dart';
import 'package:app/utils/common_widgets/common_card_wrapper.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'trip_list_tile_header.dart';
import 'trip_tile_detail_item.dart';

class CompletedTripListTile extends StatelessWidget {
  final TripResult trip;
  const CompletedTripListTile({super.key, required this.trip});

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
                TripTileDetailItem(
                    title: "Pickup point",
                    subtitle: trip.routeStopMapping
                            ?.firstWhere(
                              (element) => element.stop?.orderBy == 1,
                              orElse: () {
                                return TripRouteStopMapping();
                              },
                            )
                            .stop
                            ?.stopName ??
                        ""),
                SizedBox(height: 24.h),
                TripTileDetailItem(
                    title: "Students",
                    subtitle:
                        "${trip.studentStopsMappings?.length ?? 0} Students"),
              ]),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                TripTileDetailItem(
                    title: "Drop point",
                    subtitle: trip.routeStopMapping
                            ?.firstWhere(
                              (element) => element.stop?.orderBy == 7,
                              orElse: () {
                                return TripRouteStopMapping();
                              },
                            )
                            .stop
                            ?.stopName ??
                        ""),
                SizedBox(height: 24.h),
                TripTileDetailItem(
                    title: "Action",
                    subtitle: trip.routeType == "2"
                        ? "Pickup"
                        : trip.routeType == "1"
                            ? "Drop"
                            : ""),
              ]),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                TripTileDetailItem(
                    title: "Route No", subtitle: "Rno:${trip.routeCode}"),
                SizedBox(height: 24.h),
                TripTileDetailItem(
                    title: "Shift", subtitle: trip.shiftName ?? ''),
              ])
            ],
          )
        ],
      ),
    );
  }
}
