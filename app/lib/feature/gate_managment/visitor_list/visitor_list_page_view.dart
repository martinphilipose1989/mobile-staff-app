import 'package:app/molecules/gate_managment/search_text_field_with_filter.dart';
import 'package:app/molecules/gate_managment/visit_status_toggle.dart';

import 'package:app/molecules/gate_managment/visitor_list_tile.dart';
import 'package:app/themes_setup.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:statemanagement_riverpod/statemanagement_riverpod.dart';

import 'visitor_list_page_viewmodel.dart';

class VisitorListPageView extends BasePageViewWidget<VisitorListPageViewModel> {
  // ignore: use_super_parameters
  VisitorListPageView(ProviderBase<VisitorListPageViewModel> model)
      : super(model);

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context, VisitorListPageViewModel model) {
    return Padding(
      padding: REdgeInsets.only(left: 16, right: 16, top: 18),
      child: Column(children: [
        SearchTextFieldWithFilter(
            searchController: searchController, filterCallBack: () {}),
        Divider(height: 32.h, color: AppColors.dividerColor),
        VistsStatusToggleWidget(
            selectedValue: model.selectValue,
            onSelectedValueChanged: () {
              model.onToggleSelect();
            }),
        Divider(height: 32.h, color: AppColors.dividerColor),
        Expanded(
          child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return VisitorListTile(
                  visitStatus: index % 2 == 0 ? "IN" : "OUT");
            },
          ),
        )
      ]),
    );
  }
}
