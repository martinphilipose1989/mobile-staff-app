import 'package:app/base/app_base_page.dart';
import 'package:app/di/states/viewmodels.dart';
import 'package:app/feature/gate_managment/create_edit_gate_pass/create_edit_gate_pass_page_view.dart';
import 'package:app/feature/gate_managment/create_edit_gate_pass/create_edit_gate_pass_viewmodel.dart';
import 'package:app/utils/common_widgets/common_appbar.dart';
import 'package:data/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:statemanagement_riverpod/statemanagement_riverpod.dart';

class GatePassArguments {
  final String id;
  final String type;
  final VisitorDataModel parentData;

  GatePassArguments(
      {required this.id, required this.type, required this.parentData});
}

class CreateEditGatePassPage extends BasePage<CreateEditGatePassViewModel> {
  const CreateEditGatePassPage({super.key, this.arguments});

  final GatePassArguments? arguments;

  @override
  CreateEditGatePassPageState createState() => CreateEditGatePassPageState();
}

class CreateEditGatePassPageState extends AppBasePageState<
    CreateEditGatePassViewModel, CreateEditGatePassPage> {
  @override
  Widget buildView(BuildContext context, CreateEditGatePassViewModel model) {
    return CreateEditGatePassPageView(provideBase(), widget.arguments);
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

  @override
  void onModelReady(CreateEditGatePassViewModel model) {
    if (widget.arguments != null) {
      model.populateGatePass(arguments: widget.arguments!);
    }
    model.getTypeOfVisitorList();
    model.getPurposeOfVisitList();
  }
}
