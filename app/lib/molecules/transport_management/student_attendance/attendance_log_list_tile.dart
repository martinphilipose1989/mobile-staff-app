import 'package:app/themes_setup.dart';
import 'package:app/utils/app_typography.dart';
import 'package:app/utils/common_widgets/app_images.dart';
import 'package:app/utils/common_widgets/common_card_wrapper.dart';
import 'package:app/utils/common_widgets/common_image_widget.dart';
import 'package:app/utils/common_widgets/common_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'add_edit_attendance_popup.dart';

class AttendanceLogListTile extends StatelessWidget {
  const AttendanceLogListTile(
      {super.key, this.isEdit = false, this.isPresent = false});

  final bool isEdit;
  final bool isPresent;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CommonCardWrapper(
          left: 16,
          top: 16,
          right: 16,
          contentPadding: REdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CommonImageWidget(
                      imageUrl: "imageUrl",
                      imageHeight: 40.h,
                      imageWidth: 40.h,
                      clipBehavior: Clip.hardEdge),
                  SizedBox(width: 8.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonText(
                          text: "Khevna Shah",
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
                            onAbsentPresentCallback: () {},
                            onStudentPresentCallback: () {},
                            studentName: "Khevna Shah",
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
                            onAbsentPresentCallback: () {},
                            onStudentPresentCallback: () {},
                            studentName: "Khevna Shah",
                          );
                        });
                  },
                  label: const Text("Edit Log"),
                  icon: SvgPicture.asset(AppImages.editIcon),
                ),
              ),
            ],
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