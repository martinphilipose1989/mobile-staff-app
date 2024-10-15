import 'package:app/di/states/viewmodels.dart';
import 'package:app/feature/transport_management/my_duty/my_duty_page.dart';
import 'package:app/model/resource.dart';
import 'package:app/molecules/transport_management/arrival_info/arrival_info_tile.dart';
import 'package:app/molecules/transport_management/student_attendance/attendance_log_list_tile.dart';
import 'package:app/molecules/transport_management/student_attendance/drop_attendance_log_tile.dart';
import 'package:app/molecules/transport_management/student_attendance/drop_attendance_log_tile_first.dart';
import 'package:app/navigation/route_paths.dart';

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
        Padding(
            padding: const EdgeInsets.all(16),
            child: ArrivalInfoTile(
                vehicleNumber:
                    model.trip?.routeBusUserMapping?[0].bus?.busNumber ?? '',
                startTime: model.trip?.shiftName ?? '',
                totalStudents: model.trip?.studentStopsMappings?.length ?? 0)),
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
                text: model.trip?.schoolName ?? '',
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
                      model.getRouteStudentList(
                          routeId: int.parse(model.trip?.id ?? '1'),
                          stopId:
                              int.parse((model.stop?.id ?? '1').toString()));
                    },
                  ),
                ),
                successWidget: () => ListView.builder(
                  itemCount: studentData?.data?.length,
                  itemBuilder: (context, index) {
                    final student = studentData?.data?[index];

                    return model.trip?.routeType == '1'
                        ? (model.dropStarted ?? false)
                            ? DropAttendanceLogTile(student: student!)
                            : DropAttendanceLogTileFirst(student: student!)
                        : AttendanceLogListTile(student: student!);
                  },
                ),
              );
            },
          ),
        ),

        model.trip?.routeType == '1'
            ? (model.dropStarted ?? false)
                ? AppStreamBuilder<Resource<CreateStopLogsData>>(
                    stream: model.createStopLogsSubgject,
                    initialData: Resource.none(),
                    onData: (value) {
                      if (value.status == Status.success) {
                        Navigator.pop(context);
                      }
                    },
                    dataBuilder: (context, createStopLogsData) {
                      return AppStreamBuilder<Resource<CreateRouteLogsData>>(
                          stream: model.createRouteLogsStream,
                          initialData: Resource.none(),
                          onData: (value) {
                            if (value.status == Status.success) {
                              ProviderScope.containerOf(context)
                                  .read(myDutyPageViewModelProvider)
                                  .getMyDutyList();
                              // Navigator.pop(context);
                              // Navigator.pop(context);
                              // Navigator.pop(context);

                              Navigator.popUntil(context,
                                  ModalRoute.withName(RoutePaths.myDutyPage));
                            }
                          },
                          dataBuilder: (context, createRouteLogsdata) {
                            return createStopLogsData?.status == Status.loading
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : createRouteLogsdata?.status == Status.loading
                                    ? const Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    : Container(
                                        padding: const EdgeInsets.all(16),
                                        width: double.infinity,
                                        child: CommonPrimaryElevatedButton(
                                          title: (model.isLastIndex ?? false)
                                              ? "Complete Trip"
                                              : "Drop Students",
                                          width: double.infinity,
                                          onPressed: () {
                                            (model.isLastIndex ?? false)
                                                ? model.createRouteLogs(
                                                    int.parse(
                                                        model.trip?.id ?? ''))
                                                : model.createStopLog(
                                                    model.stop?.id ?? 0);
                                          },
                                        ),
                                      );
                          });
                    },
                  )
                : Container(
                    padding: const EdgeInsets.all(16),
                    width: double.infinity,
                    child: CommonPrimaryElevatedButton(
                      title: "Pickup All",
                      width: double.infinity,
                      onPressed: () {
                        Navigator.pushNamed(
                                context, RoutePaths.busRouteListPage,
                                arguments: true)
                            .then(
                          (value) {
                            model.reset();
                          },
                        );
                      },
                    ),
                  )
            : AppStreamBuilder<Resource<CreateStopLogsData>>(
                stream: model.createStopLogsSubgject,
                initialData: Resource.none(),
                onData: (value) {
                  if (value.status == Status.success) {
                    Navigator.pop(context);
                  }
                },
                dataBuilder: (context, createStopLogsData) {
                  return AppStreamBuilder<Resource<CreateRouteLogsData>>(
                      stream: model.createRouteLogsStream,
                      initialData: Resource.none(),
                      onData: (value) {
                        if (value.status == Status.success) {
                          ProviderScope.containerOf(context)
                              .read(myDutyPageViewModelProvider)
                              .getMyDutyList();
                          Navigator.pop(context);
                          Navigator.pop(context);
                          Navigator.pop(context);
                        }
                      },
                      dataBuilder: (context, createRouteLogsdata) {
                        return createStopLogsData?.status == Status.loading
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : createRouteLogsdata?.status == Status.loading
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : Container(
                                    padding: const EdgeInsets.all(16),
                                    width: double.infinity,
                                    child: CommonPrimaryElevatedButton(
                                      title: (model.isLastIndex ?? false)
                                          ? "Drop All Students"
                                          : "Pickup Students",
                                      width: double.infinity,
                                      onPressed: () {
                                        (model.isLastIndex ?? false)
                                            ? model.createRouteLogs(
                                                int.parse(model.trip?.id ?? ''))
                                            : model.createStopLog(
                                                model.stop?.id ?? 0);
                                      },
                                    ),
                                  );
                      });
                },
              )
      ],
    );
  }
}
