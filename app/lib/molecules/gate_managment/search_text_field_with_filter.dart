import 'package:app/feature/gate_managment/visitor_list/visitor_list_page_viewmodel.dart';
import 'package:app/themes_setup.dart';
import 'package:app/utils/common_widgets/app_images.dart';
import 'package:app/utils/common_widgets/common_search_text_field.dart';
import 'package:app/utils/stream_builder/app_stream_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchTextFieldWithFilter extends StatelessWidget {
  const SearchTextFieldWithFilter(
      {super.key,
      required this.model,
      this.filterCallBack,
      this.hintText,
      this.prefixIcon,
      this.onChanged});

  final VoidCallback? filterCallBack;
  final String? hintText;
  final Widget? prefixIcon;
  final void Function(String)? onChanged;
  final VisitorListPageViewModel model;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: CommonSearchTextField(
              controller: model.searchController, onChanged: onChanged),
        ),
        Container(
          height: 56.h,
          width: 1.w,
          margin: REdgeInsets.symmetric(horizontal: 16),
          decoration: const BoxDecoration(
            color: AppColors.dividerColor,
          ),
        ),
        InkWell(
          onTap: filterCallBack,
          child: Container(
            height: 40.w,
            width: 40.w,
            padding: REdgeInsets.all(8),
            child: AppStreamBuilder<bool>(
                stream: model.isFilterAppLiedStream,
                initialData: model.isFilterAppliedSubject.value,
                dataBuilder: (context, isFilterApplied) {
                  return Badge(
                    isLabelVisible: isFilterApplied!,
                    child: SvgPicture.asset(
                      AppImages.filterIcon,
                    ),
                  );
                }),
          ),
        ),
      ],
    );
  }
}
