import 'package:app/model/resource.dart';
import 'package:app/molecules/transport_management/arrival_info/arrival_info_tile.dart';
import 'package:app/molecules/transport_management/student_attendance/attendance_count_tile.dart';
import 'package:app/molecules/transport_management/student_attendance/attendance_log_list_tile.dart';
import 'package:app/themes_setup.dart';
import 'package:app/utils/app_typography.dart';

import 'package:app/utils/common_widgets/common_primary_elevated_button.dart';

import 'package:app/utils/common_widgets/common_text_widget.dart';
import 'package:app/utils/common_widgets/no_data_found_widget.dart';
import 'package:app/utils/data_status_widget.dart';
import 'package:app/utils/stream_builder/app_stream_builder.dart';
import 'package:domain/domain.dart';
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
        // const Padding(
        //   padding: EdgeInsets.symmetric(horizontal: 16),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        //       AttendanceCountTile(
        //           count: 15, countType: "Total", textColor: AppColors.primary),
        //       AttendanceCountTile(
        //           count: 10,
        //           countType: "Picked Up",
        //           textColor: Color(0xff5C3535)),
        //       AttendanceCountTile(
        //           count: 10,
        //           countType: "Present",
        //           textColor: AppColors.success),
        //       AttendanceCountTile(
        //           count: 5, countType: "Absent", textColor: AppColors.failure),
        //     ],
        //   ),
        // ),
        Expanded(
          child: AppStreamBuilder<Resource<List<Student>>>(
            stream: model.studentListStream,
            initialData: Resource.none(),
            dataBuilder: (context, studentData) {
              return DataStatusWidget(
                status: studentData?.status ?? Status.none,
                loadingWidget: () => const Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: () => Center(
                  child: NoDataFoundWidget(
                    title: studentData?.dealSafeAppError?.error.message
                                .contains("internet") ??
                            false
                        ? "No Internet Connection"
                        : "Something Went Wrong",
                    subtitle: studentData?.dealSafeAppError?.error.message
                                .contains("internet") ??
                            false
                        ? "It seems you're offline. Please check your internet connection and try again."
                        : "An unexpected error occurred. Please try again later or contact support if the issue persists.",
                    onPressed: () {
                      model.getRouteStudentList(routeId: 1, stopId: 1);
                    },
                  ),
                ),
                successWidget: () => ListView.builder(
                  itemCount: studentData?.data?.length,
                  itemBuilder: (context, index) {
                    final student = studentData?.data?[index];
                    return AttendanceLogListTile(student: student!);
                  },
                ),
              );
            },
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          width: double.infinity,
          child: CommonPrimaryElevatedButton(
            title: "Pickup Students",
            width: double.infinity,
            onPressed: () {},
          ),
        )
      ],
    );
  }
}
