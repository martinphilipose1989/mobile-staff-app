import 'package:app/base/app_base_page.dart';
import 'package:app/di/states/viewmodels.dart';
import 'package:app/utils/common_widgets/common_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:statemanagement_riverpod/statemanagement_riverpod.dart';
import 'visitor_list_page_viewmodel.dart';
import 'visitor_list_page_view.dart';

class VisitorListPage extends BasePage<VisitorListPageViewModel> {
  const VisitorListPage({super.key});

  @override
  VisitorListPageState createState() => VisitorListPageState();
}

class VisitorListPageState
    extends AppBasePageState<VisitorListPageViewModel, VisitorListPage> {
  @override
  Widget buildView(BuildContext context, VisitorListPageViewModel model) {
    return VisitorListPageView(provideBase());
  }

  @override
  ProviderBase<VisitorListPageViewModel> provideBase() {
    return visitorListPageModelProvider;
  }

  @override
  PreferredSizeWidget? buildAppbar(VisitorListPageViewModel model) {
    return const CommonAppBar(
        appbarTitle: "Type Of Visitors", showBackButton: false);
  }

  @override
  Color scaffoldBackgroundColor() => Colors.white;

  @override
  void onModelReady(VisitorListPageViewModel model) {}
}
