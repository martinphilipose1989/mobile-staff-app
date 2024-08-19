import 'dart:developer';

import 'package:app/model/resource.dart';
import 'package:app/molecules/gate_managment/filter_bottom_sheet.dart';
import 'package:app/molecules/gate_managment/search_text_field_with_filter.dart';
import 'package:app/molecules/gate_managment/visitor_list/bottom_loader.dart';
import 'package:app/molecules/gate_managment/visitor_list/visitor_shimmer_list.dart';
import 'package:app/molecules/gate_managment/visitor_list_tile.dart';
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
          },
        ),
        Divider(height: 32.h, color: AppColors.dividerColor),
        ToggleOptionList<int>(
          selectedValue: model.selectedStatus,
          options: model.statusTypeList,
          onSelect: (value) => model.onVisitStatusSelect(selectStatus: value),
        ),
        Divider(height: 32.h, color: AppColors.dividerColor),
        Expanded(
          child: AppStreamBuilder<Resource<VisitorListResponseModel>>(
            stream: model.visitorListResponse,
            initialData: Resource.none(),
            dataBuilder: (context, data) {
              return DataStatusWidget(
                status: data?.status ?? Status.none,
                loadingWidget: () => const VisitorShimmerList(),
                successWidget: () => NotificationListener<ScrollNotification>(
                  onNotification: (scrollNotification) {
                    if (scrollNotification.metrics.pixels ==
                        scrollNotification.metrics.maxScrollExtent) {
                      model.loadMoreVisitorList();
                    }
                    return false;
                  },
                  child: AppStreamBuilder<List<VisitorDataModel>>(
                    stream: model.visitorListStream,
                    initialData: const [],
                    dataBuilder: (context, visitors) {
                      final hasMorePages = model.hasMorePagesSubject.value;
                      log("$hasMorePages", name: "hasMorePages");
                      final itemCount =
                          visitors?.length ?? 0 + (hasMorePages ? 1 : 0);
                      return ListView.builder(
                        itemCount: itemCount,
                        itemBuilder: (context, index) {
                          if (index < (visitors?.length ?? 0)) {
                            return VisitorListTile(
                                visitorDataModel: visitors?[index]);
                          } else {
                            return VisitorBottomLoader(
                                loadingStream: model.loadingStream);
                          }
                        },
                      );
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ]),
    );
  }
}
