import 'package:app/utils/common_widgets/common_dropdown.dart';

import 'package:app/utils/common_widgets/common_primary_elevated_button.dart';

import 'package:app/utils/common_widgets/common_textformfield_widget.dart';
import 'package:data/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:statemanagement_riverpod/statemanagement_riverpod.dart';

import 'incident_report_page_viewmodel.dart';

class IncidentReportPageView
    extends BasePageViewWidget<IncidentReportPageViewModel> {
  // ignore: use_super_parameters
  IncidentReportPageView(ProviderBase<IncidentReportPageViewModel> model)
      : super(model);

  @override
  Widget build(BuildContext context, IncidentReportPageViewModel model) {
    return Form(
      key: model.formKey,
      child: Column(children: [
        CommonTextFormField(
          showAstreik: true,
          labelText: "Student Name",
          topPadding: 16,
          leftPadding: 16,
          rightPadding: 16,
          bottomPadding: 16,
          keyboardType: TextInputType.name,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^[a-zA-Z\s]+$'))
          ],
          validator: (value) {
            if (Validator.isEmpty(value!)) {
              return "Student name cannot be empty";
            }
            return null;
          },
        ),
        CustomDropdownButton(
          isMutiSelect: false,
          showAstreik: true,
          showBorderColor: true,
          leftPadding: 16,
          rightPadding: 16,
          onMultiSelect: (_) {},
          onSingleSelect: (value) {},
          dropdownName: "Incident Type",
          items: const ["Fight in Bus"],
          validator: (value) {
            if (value == null || Validator.isEmpty(value)) {
              return "Incident Type cannot be empty";
            }
            return null;
          },
        ),
        const Spacer(),
        Container(
          width: double.infinity,
          padding: REdgeInsets.all(16),
          child: CommonPrimaryElevatedButton(
            title: "Submit",
            onPressed: () {
              if (model.formKey.currentState!.validate()) {}
            },
          ),
        )
      ]),
    );
  }
}
