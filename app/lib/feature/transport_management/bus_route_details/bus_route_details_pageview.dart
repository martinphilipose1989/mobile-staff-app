import 'package:app/molecules/transport_management/arrival_info/arrival_info_tile.dart';
import 'package:app/molecules/transport_management/student_attendance/attendance_count_tile.dart';
import 'package:app/molecules/transport_management/student_attendance/attendance_log_list_tile.dart';
import 'package:app/themes_setup.dart';
import 'package:app/utils/app_typography.dart';

import 'package:app/utils/common_widgets/common_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:statemanagement_riverpod/statemanagement_riverpod.dart';
import 'bus_route_details_page_viewmodel.dart';

class BusRouteDetailsPageView
    extends BasePageViewWidget<BusRouteDetailsPageViewModel> {
  // ignore: use_super_parameters
  BusRouteDetailsPageView(ProviderBase<BusRouteDetailsPageViewModel> model)
      : super(model);

  @override
  Widget build(BuildContext context, BusRouteDetailsPageViewModel model) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: ArrivalInfoTile(
              vehicleNumber: "MH47-PK-9386",
              startTime: "Morning 7 AM",
              totalStudents: 15),
        ),
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Divider(color: AppColors.dividerColor),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonText(
                text: "Vibgyor Kids & high malad West",
                style: AppTypography.subtitle1,
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AttendanceCountTile(
                  count: 15, countType: "Total", textColor: AppColors.primary),
              AttendanceCountTile(
                  count: 10,
                  countType: "Picked Up",
                  textColor: Color(0xff5C3535)),
              AttendanceCountTile(
                  count: 10,
                  countType: "Present",
                  textColor: AppColors.success),
              AttendanceCountTile(
                  count: 5, countType: "Absent", textColor: AppColors.failure),
            ],
          ),
        ),
        const AttendanceLogListTile(),
        const AttendanceLogListTile(isEdit: true, isPresent: true),
        const AttendanceLogListTile(),
      ],
    );
  }
}
