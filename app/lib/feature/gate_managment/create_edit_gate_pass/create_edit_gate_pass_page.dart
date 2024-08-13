import 'package:app/base/app_base_page.dart';
import 'package:app/di/states/viewmodels.dart';
import 'package:app/feature/gate_managment/create_edit_gate_pass/create_edit_gate_pass_page_view.dart';
import 'package:app/feature/gate_managment/create_edit_gate_pass/create_edit_gate_pass_viewmodel.dart';
import 'package:app/utils/common_widgets/common_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:statemanagement_riverpod/statemanagement_riverpod.dart';

class CreateEditGatePassPage extends BasePage<CreateEditGatePassViewModel> {
  const CreateEditGatePassPage({super.key});

  @override
  CreateEditGatePassPageState createState() => CreateEditGatePassPageState();
}

class CreateEditGatePassPageState extends AppBasePageState<
    CreateEditGatePassViewModel, CreateEditGatePassPage> {
  @override
  Widget buildView(BuildContext context, CreateEditGatePassViewModel model) {
    return CreateEditGatePassPageView(provideBase());
  }

  @override
  Color scaffoldBackgroundColor() => Colors.white;

  @override
  ProviderBase<CreateEditGatePassViewModel> provideBase() {
    return createEditGatePassViewModelProvider;
  }

  @override
  PreferredSizeWidget? buildAppbar(CreateEditGatePassViewModel model) {
    return const CommonAppBar(
      appbarTitle: "Create Gate-Pass",
      showBackButton: true,
      notShowNotificationAndUserBatch: true,
    );
  }
}
