import 'package:app/themes_setup.dart';
import 'package:app/utils/app_typography.dart';
import 'package:app/utils/common_widgets/common_outline_button.dart';
import 'package:app/utils/common_widgets/common_primary_elevated_button.dart';
import 'package:app/utils/common_widgets/toggle_option_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rxdart/subjects.dart';

class FilterBottomSheet extends StatelessWidget {
  FilterBottomSheet({
    super.key,
  });

  final selectedVisitorType = BehaviorSubject<int>.seeded(-1);
  final visitorTypeList = [
    const ToggleOption<int>(value: 0, text: "School Visit"),
    const ToggleOption<int>(value: 1, text: "Interview"),
    const ToggleOption<int>(value: 2, text: "PTM"),
    const ToggleOption<int>(value: 3, text: "Enquiry"),
  ];

  final selectedStatus = BehaviorSubject<int>.seeded(-1);
  final statusTypeList = [
    const ToggleOption<int>(value: 0, text: "IN"),
    const ToggleOption<int>(value: 1, text: "OUT")
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Filter",
                  style: AppTypography.subtitle1
                      .copyWith(color: AppColors.textDark)),
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.close))
            ],
          ),
          Divider(height: 16.h, color: AppColors.dividerColor),
          const Text("Visitor Type"),
          SizedBox(height: 16.h),
          ToggleOptionList<int>(
              selectedValue: selectedVisitorType, options: visitorTypeList),
          SizedBox(height: 16.h),
          const Text("Status"),
          SizedBox(height: 16.h),
          ToggleOptionList<int>(
              selectedValue: selectedStatus, options: statusTypeList),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(
                  child: CommonOutlineButton(
                      title: "Cancel",
                      onPressed: () {
                        Navigator.pop(context);
                      })),
              SizedBox(width: 16.w),
              Expanded(
                child: CommonPrimaryElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    title: "Apply Filter"),
              )
            ],
          )
        ],
      ),
    );
  }
}
