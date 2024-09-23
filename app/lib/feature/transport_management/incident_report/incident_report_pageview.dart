import 'package:app/themes_setup.dart';
import 'package:app/utils/app_typography.dart';
import 'package:app/utils/common_widgets/app_images.dart';
import 'package:app/utils/common_widgets/common_card_wrapper.dart';
import 'package:app/utils/common_widgets/common_dropdown.dart';
import 'package:app/utils/common_widgets/common_image_widget.dart';
import 'package:app/utils/common_widgets/common_primary_elevated_button.dart';
import 'package:app/utils/common_widgets/common_text_widget.dart';
import 'package:app/utils/common_widgets/common_textformfield_widget.dart';
import 'package:data/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

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
        CommonCardWrapper(
          contentPadding: EdgeInsets.zero,
          left: 16,
          right: 16,
          bottom: 16,
          top: 16,
          child: ListTile(
            minVerticalPadding: 16,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            tileColor: AppColors.listItem,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            leading: const CommonImageWidget(
                clipBehavior: Clip.hardEdge,
                imageUrl: "",
                imageWidth: 40,
                imageHeight: 40,
                fallbackAssetImagePath: AppImages.pageViewImages),
            title: CommonText(
                text: "Principal",
                style: AppTypography.subtitle2,
                color: AppColors.textDark),
            subtitle: CommonText(
                text: "+91-8754979784",
                color: AppColors.textGray,
                style: AppTypography.body2),
            trailing: IconButton(
                onPressed: () {}, icon: SvgPicture.asset(AppImages.callIcon)),
          ),
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
