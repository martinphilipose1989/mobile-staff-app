import 'package:app/di/states/viewmodels.dart';
import 'package:app/model/resource.dart';
import 'package:app/themes_setup.dart';
import 'package:app/utils/app_typography.dart';
import 'package:app/utils/common_widgets/app_images.dart';
import 'package:app/utils/common_widgets/common_image_widget.dart';
import 'package:app/utils/common_widgets/common_primary_elevated_button.dart';
import 'package:app/utils/common_widgets/common_text_widget.dart';
import 'package:app/utils/enum/attendance_type_enum.dart';
import 'package:app/utils/stream_builder/app_stream_builder.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:statemanagement_riverpod/statemanagement_riverpod.dart';

class AddEditAttendancePopup extends StatelessWidget {
  final String header;
  final String studentName;
  final Student student;
  final AttendanceTypeEnum attendanceType;

  const AddEditAttendancePopup(
      {super.key,
      required this.header,
      required this.student,
      required this.studentName,
      required this.attendanceType});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      insetPadding: const EdgeInsets.all(16),
      child: BaseWidget(
        providerBase: busRouteDetailsPageViewModelProvider,
        builder: (context, model, _) => Container(
          width: double.infinity,
          padding: REdgeInsets.all(24),
          child: AppStreamBuilder<Resource<CreateAttendanceResponse>>(
              initialData: Resource.none(),
              stream: model!.createAttendanceResponse.stream,
              onData: (result) {
                if (result.status == Status.success) {
                  model.createAttendanceResponse.add(Resource.none());
                  Navigator.pop(context, true);
                }
              },
              dataBuilder: (context, attendance) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CommonText(text: header, style: AppTypography.h5),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: SvgPicture.asset(AppImages.closeIcon),
                        )
                      ],
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: Column(
                        children: [
                          CommonImageWidget(
                            imageUrl: "imageUrl",
                            fallbackAssetImagePath:
                                AppImages.defaultStudentAvatar,
                            imageWidth: 125.w,
                            imageHeight: 125.h,
                            clipBehavior: Clip.hardEdge,
                          ),
                          CommonText(
                              text: studentName,
                              color: AppColors.textDark,
                              style: AppTypography.h6),
                          const SizedBox(height: 4),
                          CommonText(
                              text: "Regular Student",
                              color: AppColors.textGray,
                              style: AppTypography.body2),
                        ],
                      ),
                    ),
                    const SizedBox(height: 48),
                    Row(
                      children: [
                        Expanded(
                          child: AppStreamBuilder<bool>(
                              initialData: false,
                              stream: model.absentLoadingStream,
                              dataBuilder: (context, isAbsentLoading) {
                                return CommonPrimaryElevatedButton(
                                  isLoading: isAbsentLoading ?? false,
                                  elevation: 0,
                                  title: "Absent",
                                  icon: SvgPicture.asset(
                                    AppImages.closeIcon,
                                    colorFilter: const ColorFilter.mode(
                                        AppColors.primaryOn, BlendMode.srcIn),
                                  ),
                                  backgroundColor: AppColors.failure,
                                  foregroundColor:
                                      Theme.of(context).colorScheme.onPrimary,
                                  onPressed: () {
                                    final selectedStudent = Student(
                                      id: student.id,
                                      studentId: student.studentId,
                                      studentDetails: student.studentDetails,
                                    );
                                    if (student.attendanceList != null &&
                                        (student.attendanceList?.isNotEmpty ??
                                            false)) {
                                      model.updateAttendance(
                                          attendanceRemark: "absent",
                                          attendanceType:
                                              AttendanceTypeEnum.absent,
                                          studentId: student.studentId ?? 0);
                                    } else {
                                      model.createAttendance(
                                          attendanceTypeEnum:
                                              AttendanceTypeEnum.absent,
                                          student: selectedStudent,
                                          remark: "absent");
                                    }
                                  },
                                );
                              }),
                        ),
                        SizedBox(width: 4.w),
                        Expanded(
                          child: AppStreamBuilder<bool>(
                              initialData: false,
                              stream: model.presentStream,
                              dataBuilder: (context, isPresentLoading) {
                                return CommonPrimaryElevatedButton(
                                  isLoading: isPresentLoading ?? false,
                                  elevation: 0,
                                  title: "Present",
                                  icon: SvgPicture.asset(
                                    AppImages.checkMark,
                                    colorFilter: const ColorFilter.mode(
                                        AppColors.primaryOn, BlendMode.srcIn),
                                  ),
                                  backgroundColor:
                                      Theme.of(context).colorScheme.primary,
                                  foregroundColor:
                                      Theme.of(context).colorScheme.onPrimary,
                                  onPressed: () {
                                    final selectedStudent = Student(
                                      id: student.id,
                                      studentId: student.studentId,
                                      studentDetails: student.studentDetails,
                                    );
                                    if (student.attendanceList != null &&
                                        (student.attendanceList?.isNotEmpty ??
                                            false)) {
                                      model.updateAttendance(
                                          attendanceRemark: "present",
                                          attendanceType: attendanceType,
                                          studentId: student.studentId ?? 0);
                                    } else {
                                      model.createAttendance(
                                          attendanceTypeEnum: attendanceType,
                                          student: selectedStudent,
                                          remark: "present");
                                    }
                                  },
                                );
                              }),
                        )
                      ],
                    )
                  ],
                );
              }),
        ),
      ),
    );
  }
}
