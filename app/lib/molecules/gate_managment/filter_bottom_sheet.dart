import 'package:app/feature/gate_managment/visitor_list/visitor_list_page_viewmodel.dart';
import 'package:app/model/resource.dart';
import 'package:app/themes_setup.dart';
import 'package:app/utils/app_typography.dart';
import 'package:app/utils/common_widgets/common_outline_button.dart';
import 'package:app/utils/common_widgets/common_primary_elevated_button.dart';
import 'package:app/utils/common_widgets/toggle_option_list.dart';
import 'package:app/utils/stream_builder/app_stream_builder.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FilterBottomSheet extends StatelessWidget {
  const FilterBottomSheet({super.key, required this.model});

  final VisitorListPageViewModel model;

  // final selectedVisitorType = BehaviorSubject<int>.seeded(-1);
  // final visitorTypeList = [
  //   const ToggleOption<int>(value: 0, text: "School Visit"),
  //   const ToggleOption<int>(value: 1, text: "Interview"),
  //   const ToggleOption<int>(value: 2, text: "PTM"),
  //   const ToggleOption<int>(value: 3, text: "Enquiry"),
  // ];

  // final selectedStatus = BehaviorSubject<String>.seeded("");
  // final statusTypeList = [
  //   const ToggleOption<String>(value: "In", text: "IN"),
  //   const ToggleOption<String>(value: "Out", text: "OUT")
  // ];

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
          AppStreamBuilder<Resource<List<TypeOfVisitorDataModel>>>(
              stream: model.typeOfVisitorListStream,
              initialData: Resource.none(),
              dataBuilder: (context, data) {
                return ToggleOptionList<String>(
                    selectedValue: model.selectedTypeOfVisitor,
                    options: data?.data
                            ?.map((e) => ToggleOption(
                                value: "${e.id}", text: "${e.name}"))
                            .toList() ??
                        []);
              }),
          SizedBox(height: 16.h),
          const Text("Status"),
          SizedBox(height: 16.h),
          ToggleOptionList<String>(
              selectedValue: model.selectedStatus,
              options: model.statusTypeList),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(
                  child: CommonOutlineButton(
                      title: "Reset",
                      onPressed: () {
                        model.selectedStatus.add("");
                        model.selectedTypeOfVisitor.add("");
                        model.isFilterAppliedSubject.add(false);
                        Navigator.pop(context);
                      })),
              SizedBox(width: 16.w),
              Expanded(
                child: AppStreamBuilder<bool>(
                    stream: model.isFilterAppLiedStream,
                    initialData: false,
                    dataBuilder: (context, isFilterApplied) {
                      return CommonPrimaryElevatedButton(
                          isDisabled: isFilterApplied!,
                          onPressed: () {
                            model.refreshVisitorList();
                            Navigator.pop(context);
                          },
                          title: "Apply Filter");
                    }),
              )
            ],
          )
        ],
      ),
    );
  }
}
