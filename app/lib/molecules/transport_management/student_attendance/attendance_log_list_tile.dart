import 'dart:developer';

import 'package:app/di/states/viewmodels.dart';
import 'package:app/molecules/transport_management/student_attendance/guardian_list.dart';
import 'package:app/themes_setup.dart';
import 'package:app/utils/app_typography.dart';
import 'package:app/utils/common_widgets/app_bottom_sheet.dart';
import 'package:app/utils/common_widgets/app_images.dart';
import 'package:app/utils/common_widgets/common_card_wrapper.dart';
import 'package:app/utils/common_widgets/common_image_widget.dart';
import 'package:app/utils/common_widgets/common_text_widget.dart';
import 'package:app/utils/common_widgets/dialog/basic_dialog.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'add_edit_attendance_popup.dart';

class AttendanceLogListTile extends StatelessWidget {
  const AttendanceLogListTile(
      {super.key,
      this.isEdit = false,
      this.isPresent = false,
      required this.student});

  final bool isEdit;
  final bool isPresent;
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
                        CommonImageWidget(
                            imageUrl:
                                student.studentDetails?.profileImage ?? "",
                            imageHeight: 40.h,
                            fallbackAssetImagePath:
                                AppImages.defaultStudentAvatar,
                            imageWidth: 40.h,
                            clipBehavior: Clip.hardEdge),
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
                    Visibility(
                      visible: isEdit,
                      replacement: TextButton.icon(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AddEditAttendancePopup(
                                  header: "Add Attendance Log",
                                  onAbsentPresentCallback: () {
                                    final selectedStudent = Student(
                                      id: student.id,
                                      studentId: student.studentId,
                                      studentDetails: student.studentDetails,
                                    );
                                    ProviderScope.containerOf(context)
                                        .read(
                                            busRouteDetailsPageViewModelProvider)
                                        .createAttendance(
                                          student: selectedStudent,
                                          remark: "absent",
                                        );
                                  },
                                  onStudentPresentCallback: () {
                                    final selectedStudent = Student(
                                      id: student.id,
                                      studentId: student.studentId,
                                      studentDetails: student.studentDetails,
                                    );
                                    ProviderScope.containerOf(context)
                                        .read(
                                            busRouteDetailsPageViewModelProvider)
                                        .createAttendance(
                                          student: selectedStudent,
                                          remark: "present",
                                        );
                                  },
                                  studentName:
                                      "${student.studentDetails?.firstName ?? ""} ${student.studentDetails?.lastName ?? ""}",
                                );
                              });
                        },
                        label: const Text("Add Log"),
                        icon: const Icon(Icons.add),
                      ),
                      child: TextButton.icon(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AddEditAttendancePopup(
                                  header: "Edit Attendance Log",
                                  onAbsentPresentCallback: () {
                                    final selectedStudent = Student(
                                      id: student.id,
                                      studentId: student.studentId,
                                      studentDetails: student.studentDetails,
                                    );
                                    ProviderScope.containerOf(context)
                                        .read(
                                            busRouteDetailsPageViewModelProvider)
                                        .createAttendance(
                                          student: selectedStudent,
                                          remark: "absent",
                                        );
                                  },
                                  onStudentPresentCallback: () {
                                    final selectedStudent = Student(
                                      id: student.id,
                                      studentId: student.studentId,
                                      studentDetails: student.studentDetails,
                                    );
                                    ProviderScope.containerOf(context)
                                        .read(
                                            busRouteDetailsPageViewModelProvider)
                                        .createAttendance(
                                          student: selectedStudent,
                                          remark: "present",
                                        );
                                  },
                                  studentName:
                                      "${student.studentDetails?.firstName ?? ""} ${student.studentDetails?.lastName ?? ""}",
                                );
                              });
                        },
                        label: const Text("Edit Log"),
                        icon: SvgPicture.asset(AppImages.editIcon),
                      ),
                    ),
                  ],
                ),
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
                        log("message ${student.intimationList}");
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
                      onTap: () {},
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
              ],
            ),
          ),
        ),
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
                      color: isPresent ? AppColors.success : AppColors.failure,
                      child: CommonText(
                          text: isPresent ? "Present" : " Absent",
                          color: Colors.white,
                          style: AppTypography.caption),
                    ),
                    TriangleContainer(isPresent: isPresent)
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
      ],
    );
  }
}

class TriangleContainer extends StatelessWidget {
  const TriangleContainer({super.key, required this.isPresent});

  final bool isPresent;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 0, // No width for the triangle
      height: 10, // No height for the triangle
      margin: const EdgeInsets.symmetric(horizontal: 14.0),
      decoration: BoxDecoration(
        border: Border(
          left: const BorderSide(width: 12.0, color: Colors.transparent),
          bottom: BorderSide(
              width: 10.0,
              color: isPresent ? AppColors.success : AppColors.failure),
        ),
      ),
    );
  }
}
