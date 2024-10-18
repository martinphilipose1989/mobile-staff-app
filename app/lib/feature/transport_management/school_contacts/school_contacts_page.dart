import 'package:app/base/app_base_page.dart';
import 'package:app/di/states/viewmodels.dart';

import 'package:app/utils/common_widgets/common_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:statemanagement_riverpod/statemanagement_riverpod.dart';

import 'school_contacts_page_viewmodel.dart';
import 'school_contacts_pageview.dart';

class SchoolContactsPage extends BasePage<SchoolContactsPageViewModel> {
  const SchoolContactsPage({super.key, required this.schoolId});

  final int schoolId;

  @override
  SchoolContactsPageState createState() => SchoolContactsPageState();
}

class SchoolContactsPageState
    extends AppBasePageState<SchoolContactsPageViewModel, SchoolContactsPage> {
  @override
  Widget buildView(BuildContext context, SchoolContactsPageViewModel model) {
    return SchoolContactsPageView(provideBase());
  }

  @override
  ProviderBase<SchoolContactsPageViewModel> provideBase() {
    return schoolContactsPageViewModelProvider;
  }

  @override
  Color scaffoldBackgroundColor() {
    return Colors.white;
  }

  @override
  void onModelReady(SchoolContactsPageViewModel model) {
    model.exceptionHandlerBinder.bind(context, super.stateObserver);
    getViewModel().getSchoolContactList(schoolId: widget.schoolId);
    super.onModelReady(model);
  }

  @override
  PreferredSizeWidget? buildAppbar(SchoolContactsPageViewModel model) {
    return const CommonAppBar(appbarTitle: "School Contacts");
  }
}
