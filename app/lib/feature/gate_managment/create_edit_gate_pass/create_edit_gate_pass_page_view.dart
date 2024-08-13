import 'package:app/feature/gate_managment/create_edit_gate_pass/create_edit_gate_pass_viewmodel.dart';
import 'package:app/feature/gate_managment/visitor_details/visitor_details_page.dart';
import 'package:app/molecules/gate_managment/profile_picker.dart';
import 'package:app/utils/common_widgets/common_dropdown.dart';
import 'package:app/utils/common_widgets/common_outline_button.dart';
import 'package:app/utils/common_widgets/common_primary_elevated_button.dart';
import 'package:app/utils/common_widgets/common_textformfield_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:statemanagement_riverpod/statemanagement_riverpod.dart';

class CreateEditGatePassPageView
    extends BasePageViewWidget<CreateEditGatePassViewModel> {
  // ignore: use_super_parameters
  CreateEditGatePassPageView(ProviderBase<CreateEditGatePassViewModel> model)
      : super(model);

  @override
  Widget build(BuildContext context, CreateEditGatePassViewModel model) {
    return Column(
      // mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: REdgeInsets.all(16.0),
              child: Column(
                children: [
                  ProfilePicker(model: model, onProfilePick: () {}),
                  SizedBox(height: 12.h),
                  const CommonTextFormField(
                      bottomPadding: 16,
                      showAstreik: true,
                      labelText: "Visitor Name",
                      keyboardType: TextInputType.name),
                  const CommonTextFormField(
                      bottomPadding: 16,
                      showAstreik: true,
                      labelText: "Email ID",
                      keyboardType: TextInputType.emailAddress),
                  const CommonTextFormField(
                    bottomPadding: 16,
                    readOnly: true,
                    showAstreik: true,
                    labelText: "Visit Date & Time",
                  ),
                  CustomDropdownButton(
                    width: double.infinity,
                    bottomPadding: 16,
                    items: const ["1", "2", "3"],
                    isMutiSelect: false,
                    dropdownName: "Type of Visitor",
                    showAstreik: true,
                    showBorderColor: true,
                    onMultiSelect: (_) {},
                    onSingleSelect: (_) {},
                  ),
                  CustomDropdownButton(
                    width: double.infinity,
                    bottomPadding: 16,
                    items: const ["1", "2", "3"],
                    isMutiSelect: false,
                    dropdownName: "Point of Contact",
                    showAstreik: true,
                    showBorderColor: true,
                    onMultiSelect: (_) {},
                    onSingleSelect: (_) {},
                  ),
                  CustomDropdownButton(
                    width: double.infinity,
                    bottomPadding: 16,
                    items: const ["1", "2", "3"],
                    isMutiSelect: false,
                    dropdownName: "Purpose of Visit",
                    showAstreik: true,
                    showBorderColor: true,
                    onMultiSelect: (_) {},
                    onSingleSelect: (_) {},
                  ),
                  const CommonTextFormField(
                      bottomPadding: 16,
                      showAstreik: true,
                      labelText: "Coming From",
                      keyboardType: TextInputType.text),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: REdgeInsets.only(bottom: 16, right: 16, left: 16),
          child: Row(
            children: [
              Expanded(
                child: CommonOutlineButton(onPressed: () {}, title: "Cancel"),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: CommonPrimaryElevatedButton(
                    title: "Submit",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const VisitorDetailsPage(),
                        ),
                      );
                    }),
              ),
            ],
          ),
        )
      ],
    );
  }
}
