import 'package:app/themes_setup.dart';
import 'package:app/utils/app_typography.dart';
import 'package:app/utils/common_widgets/common_text_widget.dart';
import 'package:app/utils/stream_builder/app_stream_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rxdart/subjects.dart';

class VistsStatusToggleWidget extends StatelessWidget {
  const VistsStatusToggleWidget(
      {super.key,
      required this.selectedValue,
      required this.onSelectedValueChanged});

  final BehaviorSubject<int> selectedValue;
  final VoidCallback onSelectedValueChanged;

  @override
  Widget build(BuildContext context) {
    return AppStreamBuilder<int>(
        stream: selectedValue,
        initialData: selectedValue.value,
        dataBuilder: (context, data) {
          return Row(
            children: [
              InkWell(
                onTap: () {
                  selectedValue.add(0);
                  onSelectedValueChanged.call();
                },
                child: Container(
                  padding: REdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    color: data == 0 ? AppColors.primaryLighter : Colors.white,
                    border: Border.all(
                        width: 1,
                        color: data == 0
                            ? AppColors.primary
                            : AppColors.textLightGray),
                  ),
                  child: CommonText(
                    text: "In",
                    style: AppTypography.overline.copyWith(
                      color: data == 0 ? AppColors.primary : AppColors.textGray,
                      fontSize: 14.sp,
                      letterSpacing: 0,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16.w),
              InkWell(
                onTap: () {
                  selectedValue.add(1);
                  onSelectedValueChanged.call();
                },
                child: Container(
                  padding: REdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    color: data == 1 ? AppColors.primaryLighter : Colors.white,
                    border: Border.all(
                        width: 1,
                        color: data == 1
                            ? AppColors.primary
                            : AppColors.textLightGray),
                  ),
                  child: CommonText(
                    text: "Out",
                    style: AppTypography.overline.copyWith(
                      color: data == 1 ? AppColors.primary : AppColors.textGray,
                      fontSize: 14.sp,
                      letterSpacing: 0,
                    ),
                  ),
                ),
              ),
            ],
          );
        });
  }
}
