import 'package:app/model/resource.dart';
import 'package:app/molecules/gate_managment/filter_bottom_sheet.dart';
import 'package:app/molecules/gate_managment/search_text_field_with_filter.dart';
import 'package:app/molecules/gate_managment/visitor_list_tile.dart';
import 'package:app/molecules/gate_managment/visitor_list_tile_shimmer.dart';
import 'package:app/themes_setup.dart';
import 'package:app/utils/common_widgets/app_bottom_sheet.dart';
import 'package:app/utils/common_widgets/toggle_option_list.dart';
import 'package:app/utils/data_status_widget.dart';
import 'package:app/utils/stream_builder/app_stream_builder.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:statemanagement_riverpod/statemanagement_riverpod.dart';
import 'visitor_list_page_viewmodel.dart';

class VisitorListPageView extends BasePageViewWidget<VisitorListPageViewModel> {
  // ignore: use_super_parameters
  VisitorListPageView(ProviderBase<VisitorListPageViewModel> model)
      : super(model);

  @override
  Widget build(BuildContext context, VisitorListPageViewModel model) {
    return Padding(
      padding: REdgeInsets.only(left: 16, right: 16, top: 18),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SearchTextFieldWithFilter(
            searchController: model.searchController,
            onChanged: (value) {},
            filterCallBack: () {
              AppBottomSheet(child: FilterBottomSheet(), context: context);
            }),
        Divider(height: 32.h, color: AppColors.dividerColor),
        ToggleOptionList<int>(
          selectedValue: model.selectedStatus,
          options: model.statusTypeList,
          onSelect: (value) {
            model.onVisitStatusSelect(selectStatus: value);
          },
        ),
        Divider(height: 32.h, color: AppColors.dividerColor),
        AppStreamBuilder<Resource<VisitorListResponseModel>>(
          stream: model.visitorListResponse,
          initialData: Resource.none(),
          dataBuilder: (context, data) {
            return DataStatusWidget(
              status: data?.status ?? Status.none,
              loadingWidget: () => Expanded(
                  child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return const VisitorListTileShimmer();
                },
              )),
              successWidget: () {
                return Expanded(
                  child: ListView.builder(
                    itemCount:
                        data?.data?.visitorListDataModel?.visitors?.length,
                    itemBuilder: (context, index) {
                      final visitorItem =
                          data?.data?.visitorListDataModel?.visitors?[index];
                      return VisitorListTile(
                        visitorDataModel: visitorItem,
                      );
                    },
                  ),
                );
              },
            );
          },
        ),
      ]),
    );
  }
}
