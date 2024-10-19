import 'package:app/di/states/viewmodels.dart';
import 'package:app/molecules/transport_management/student_attendance/add_edit_attendance_popup.dart';
import 'package:app/molecules/transport_management/student_attendance/guardian_list.dart';
import 'package:app/molecules/transport_management/student_attendance/triangle_container.dart';
import 'package:app/navigation/route_paths.dart';
import 'package:app/themes_setup.dart';
import 'package:app/utils/app_typography.dart';
import 'package:app/utils/common_widgets/app_bottom_sheet.dart';
import 'package:app/utils/common_widgets/app_images.dart';
import 'package:app/utils/common_widgets/common_card_wrapper.dart';
import 'package:app/utils/common_widgets/common_image_widget.dart';
import 'package:app/utils/common_widgets/common_text_widget.dart';
import 'package:app/utils/common_widgets/dialog/add_new_bearer/add_new_bearer.dart';
import 'package:app/utils/common_widgets/dialog/basic_dialog.dart';
import 'package:app/utils/enum/attendance_type_enum.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class DropAttendanceLogTileFirst extends StatelessWidget {
  const DropAttendanceLogTileFirst({super.key, required this.student});

  final Student student;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {},
          child: CommonCardWrapper(
            left: 16,
            top: 16,
            right: 16,
            contentPadding: REdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                context, RoutePaths.studentProfilePage,
                                arguments: student.studentId);
                          },
                          child: CommonImageWidget(
                              imageUrl:
                                  student.studentDetails?.profileImage ?? "",
                              imageHeight: 40.h,
                              fallbackAssetImagePath:
                                  AppImages.defaultStudentAvatar,
                              imageWidth: 40.h,
                              clipBehavior: Clip.hardEdge),
                        ),
                        SizedBox(width: 8.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonText(
                                text:
                                    "${student.studentDetails?.firstName ?? ""} ${student.studentDetails?.lastName ?? ""}",
                                style: AppTypography.subtitle2,
                                color: AppColors.textDark),
                            CommonText(
                                text: "Regular Student",
                                style: AppTypography.body2,
                                color: AppColors.textGray),
                          ],
                        ),
                      ],
                    ),
                    TextButton.icon(
                      onPressed: () {
                        showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) {
                              return AddEditAttendancePopup(
                                attendanceType: AttendanceTypeEnum.pickup,
                                header: (student.attendanceList == null ||
                                        (student.attendanceList?.isEmpty ??
                                            false))
                                    ? "Add Attendance Log"
                                    : "Edit Attendance Log",
                                student: student,
                                studentName:
                                    "${student.studentDetails?.firstName ?? ""} ${student.studentDetails?.lastName ?? ""}",
                              );
                            }).then((value) {
                          if (value == true) {
                            String? routeId = ProviderScope.containerOf(context)
                                .read(busRouteDetailsPageViewModelProvider)
                                .trip
                                ?.id;
                            ProviderScope.containerOf(context)
                                .read(busRouteDetailsPageViewModelProvider)
                                .getRouteStudentList(
                                    routeId: int.parse(routeId ?? ''));
                          }
                        });
                      },
                      label: (student.attendanceList == null ||
                              (student.attendanceList?.isEmpty ?? false))
                          ? const Text("Add Log")
                          : const Text("Edit Log"),
                      icon: (student.attendanceList == null ||
                              (student.attendanceList?.isEmpty ?? false))
                          ? const Icon(Icons.add)
                          : SvgPicture.asset(AppImages.editIcon),
                    ),
                  ],
                ),
                if (student.isOpen) ...{
                  const Divider(color: AppColors.dividerColor),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          ProviderScope.containerOf(context)
                              .read(busRouteDetailsPageViewModelProvider)
                              .getGuardianList(studentId: student.studentId!);
                          AppBottomSheet(
                            context: context,
                            child: GuardianList(
                                busRouteDetailsPageViewModelProvider),
                          );
                        },
                        child: Column(
                          children: [
                            SvgPicture.asset(AppImages.callBgIcon),
                            CommonText(
                                text: "Call Parent",
                                style: AppTypography.smallCaption,
                                color: AppColors.textGray),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          if (student.intimationList?.isNotEmpty ?? false) {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return BasicDialog(
                                      message:
                                          "${student.intimationList?.first.intimationNote}",
                                      header: "Intimation message",
                                      buttonTitle: "Close",
                                      voidCallback: () {
                                        Navigator.pop(context);
                                      });
                                });
                          } else {
                            final model = ProviderScope.containerOf(context)
                                .read(busRouteDetailsPageViewModelProvider);
                            model.flutterToastErrorPresenter.show(
                                Exception(),
                                context,
                                "No intimation for ${student.studentDetails?.firstName ?? ""} ${student.studentDetails?.lastName ?? ""}");
                          }
                        },
                        child: Column(
                          children: [
                            SvgPicture.asset(AppImages.infoBgIcon),
                            CommonText(
                                text: "View Intimation",
                                style: AppTypography.smallCaption,
                                color: AppColors.textGray),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
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
                              final provider =
                                  ProviderScope.containerOf(context).read(
                                      busRouteDetailsPageViewModelProvider);
                              int routeId = int.parse(provider.trip?.id ?? '');
                              int? stopId =
                                  int.tryParse((provider.stop?.id).toString());

                              ProviderScope.containerOf(context)
                                  .read(busRouteDetailsPageViewModelProvider)
                                  .getRouteStudentList(
                                      routeId: routeId, stopId: stopId);
                            }
                          });
                        },
                        child: Column(
                          children: [
                            SvgPicture.asset(AppImages.addUserBgIcon),
                            CommonText(
                                text: "Add New Bearer",
                                style: AppTypography.smallCaption,
                                color: AppColors.textGray),
                          ],
                        ),
                      ),
                    ],
                  )
                }
              ],
            ),
          ),
        ),
        if (student.attendanceList?.isNotEmpty ?? false) ...{
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6.0),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        padding:
                            REdgeInsets.symmetric(vertical: 4, horizontal: 8),
                        color: student.attendanceList?.first.attendanceRemark ==
                                "present"
                            ? AppColors.success
                            : AppColors.failure,
                        child: CommonText(
                            text: student.attendanceList?.first
                                        .attendanceRemark ==
                                    "present"
                                ? "Present"
                                : " Absent",
                            color: Colors.white,
                            style: AppTypography.caption),
                      ),
                      TriangleContainer(
                          isPresent:
                              student.attendanceList?.first.attendanceRemark ==
                                  "present")
                    ],
                  ),
                  Positioned(
                    right: 10,
                    bottom: 0,
                    child: Container(
                        width: 10, height: 10, color: AppColors.listItem),
                  )
                ],
              ),
            ),
          ),
        }
      ],
    );
  }
}
