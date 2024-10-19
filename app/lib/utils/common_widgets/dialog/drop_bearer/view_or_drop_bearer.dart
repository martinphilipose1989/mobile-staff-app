import 'package:app/di/states/viewmodels.dart';
import 'package:app/model/resource.dart';
import 'package:app/themes_setup.dart';
import 'package:app/utils/app_typography.dart';
import 'package:app/utils/common_widgets/app_images.dart';
import 'package:app/utils/common_widgets/common_image_widget.dart';
import 'package:app/utils/common_widgets/common_primary_elevated_button.dart';
import 'package:app/utils/common_widgets/common_text_widget.dart';
import 'package:app/utils/common_widgets/dialog/add_new_bearer/add_new_bearer.dart';
import 'package:app/utils/common_widgets/no_data_found_widget.dart';
import 'package:app/utils/data_status_widget.dart';
import 'package:app/utils/enum/attendance_type_enum.dart';

import 'package:app/utils/stream_builder/app_stream_builder.dart';
import 'package:app/utils/url_launcher.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:statemanagement_riverpod/statemanagement_riverpod.dart';

class ViewOrDropBearer extends StatelessWidget {
  const ViewOrDropBearer({super.key, required this.student});

  final Student student;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      insetPadding: const EdgeInsets.all(16),
      child: BaseWidget(
        providerBase: viewOrDropBearerViewmodel(student.studentId!),
        builder: (context, model, _) {
          return Container(
            width: double.infinity,
            padding: REdgeInsets.all(24),
            child: AppStreamBuilder<Resource<List<BearerResponse>>>(
                initialData: Resource.none(),
                stream: model!.bearerResponse.stream,
                dataBuilder: (context, bearer) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CommonText(
                              text: "Drop Student", style: AppTypography.h5),
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: SvgPicture.asset(AppImages.closeIcon),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          const SizedBox(height: 16),
                          DataStatusWidget(
                            status: bearer?.status ?? Status.none,
                            loadingWidget: () => const Center(
                                child: CircularProgressIndicator()),
                            errorWidget: () => const NoDataFoundWidget(
                                title: "No Bearers Found"),
                            successWidget: () => Container(
                              width: double.infinity,
                              padding: EdgeInsets.zero,
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        model.pageController.previousPage(
                                            duration: const Duration(
                                                milliseconds: 300),
                                            curve: Curves.linear);
                                      },
                                      icon:
                                          SvgPicture.asset(AppImages.backArrow),
                                    ),
                                    SizedBox(
                                      width: 125.w,
                                      height: 125.h,
                                      child: PageView.builder(
                                          itemCount: bearer?.data?.length,
                                          controller: model.pageController,
                                          onPageChanged: (index) {
                                            model.selectIndex.value = index;
                                          },
                                          itemBuilder: (context, index) {
                                            return CommonImageWidget(
                                                imageHeight: 125.h,
                                                imageWidth: 125.w,
                                                imageUrl: "imageUrl",
                                                clipBehavior: Clip.hardEdge);
                                          }),
                                    ),
                                    RotatedBox(
                                      quarterTurns: 2,
                                      child: IconButton(
                                        onPressed: () {
                                          model.pageController.nextPage(
                                              duration: const Duration(
                                                  milliseconds: 300),
                                              curve: Curves.linear);
                                        },
                                        icon: SvgPicture.asset(
                                            AppImages.backArrow),
                                      ),
                                    )
                                  ]),
                            ),
                          ),
                          const SizedBox(height: 16),
                          if (bearer?.data?.isNotEmpty ?? false)
                            AppStreamBuilder<int>(
                                stream: model.selectIndex.stream,
                                initialData: 0,
                                dataBuilder: (context, selectedIndex) {
                                  return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            CommonText(
                                              text:
                                                  "${bearer?.data?[selectedIndex ?? 0].firstName} ${bearer?.data?[selectedIndex ?? 0].lastName}",
                                              style: AppTypography.h5.copyWith(
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            if (bearer
                                                    ?.data?[selectedIndex ?? 0]
                                                    .mobileNo !=
                                                null) {
                                              UrlLauncher.launchPhone(
                                                  "${bearer?.data?[selectedIndex ?? 0].mobileNo}");
                                            } else {
                                              model.flutterToastErrorPresenter.show(
                                                  Exception(),
                                                  context,
                                                  "No Phone Number added for this bearer");
                                            }
                                          },
                                          iconSize: 40,
                                          icon: SvgPicture.asset(
                                            AppImages.call,
                                            height: 40.w,
                                            width: 40.w,
                                          ),
                                        )
                                      ]);
                                }),
                          const SizedBox(height: 24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Expanded(
                                child: CommonPrimaryElevatedButton(
                                  elevation: 0,
                                  title: "Add Bearer",
                                  onPressed: () {
                                    Navigator.pop(context);
                                    showDialog(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (context) {
                                          return AddNewBearer(
                                              studentId: student.studentId!,
                                              cancelCallback: () {
                                                Navigator.pop(context);
                                              },
                                              addNewBearerCallback: () {});
                                        }).then((value) {
                                      if (value == true) {
                                        final provider = ProviderScope
                                                .containerOf(context)
                                            .read(
                                                busRouteDetailsPageViewModelProvider);
                                        int routeId =
                                            int.parse(provider.trip?.id ?? '1');
                                        int stopId = int.parse(
                                            (provider.stop?.id ?? '1')
                                                .toString());

                                        ProviderScope.containerOf(context)
                                            .read(
                                                busRouteDetailsPageViewModelProvider)
                                            .getRouteStudentList(
                                                routeId: routeId,
                                                stopId: stopId);
                                      }
                                    });
                                  },
                                  backgroundColor: AppColors.textPalerGray,
                                  foregroundColor: AppColors.textGray,
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Expanded(
                                child: AppStreamBuilder<
                                        Resource<CreateAttendanceResponse>>(
                                    onData: (value) {
                                      if (value.status == Status.success) {
                                        Navigator.pop(context, true);
                                      }
                                    },
                                    stream:
                                        model.createAttendanceResponse.stream,
                                    initialData: Resource.none(),
                                    dataBuilder: (context, attendance) {
                                      return CommonPrimaryElevatedButton(
                                        isLoading: attendance?.status ==
                                            Status.loading,
                                        elevation: 0,
                                        backgroundColor: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        foregroundColor: Theme.of(context)
                                            .colorScheme
                                            .onPrimary,
                                        title: "Drop",
                                        onPressed: () {
                                          if (student.attendanceList?.first
                                                  .attendanceType ==
                                              AttendanceTypeEnum.absent) {
                                            model.flutterToastErrorPresenter.show(
                                                Exception(),
                                                context,
                                                "Cannot mark drop because student is absent");
                                          } else {
                                            model.updateAttendance(
                                                attendanceRemark: 'present',
                                                attendanceType:
                                                    AttendanceTypeEnum.drop,
                                                studentId:
                                                    student.studentId ?? 0);
                                          }
                                        },
                                      );
                                    }),
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  );
                }),
          );
        },
      ),
    );
  }
}
