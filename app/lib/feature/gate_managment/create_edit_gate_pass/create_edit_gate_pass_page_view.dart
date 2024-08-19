import 'package:app/feature/gate_managment/create_edit_gate_pass/create_edit_gate_pass_viewmodel.dart';

import 'package:app/model/resource.dart';
import 'package:app/molecules/gate_managment/profile_picker.dart';

import 'package:app/utils/common_widgets/common_dropdown.dart';
import 'package:app/utils/common_widgets/common_outline_button.dart';
import 'package:app/utils/common_widgets/common_primary_elevated_button.dart';
import 'package:app/utils/common_widgets/common_textformfield_widget.dart';
import 'package:app/utils/common_widgets/country_picker_phone_text_field.dart';
import 'package:app/utils/data_status_widget.dart';
import 'package:app/utils/stream_builder/app_stream_builder.dart';

import 'package:domain/domain.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
    return Builder(builder: (context) {
      return Form(
        key: model.formKey,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: REdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      ProfilePicker(
                          model: model,
                          onProfilePick: () {
                            model.pickImage(UpoladFileTypeEnum.camera);
                          }),
                      SizedBox(height: 12.h),
                      CommonTextFormField(
                        bottomPadding: 16,
                        showAstreik: true,
                        labelText: "Visitor Name",
                        controller: model.visitorNameController,
                        keyboardType: TextInputType.name,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^[a-zA-Z\s]+$'))
                        ],
                        validator: (value) {
                          if (Validator.isEmpty(value!)) {
                            return "Visitor Name cannot be empty";
                          }
                          return null;
                        },
                      ),
                      CountryPickerPhoneTextField(
                        controller: model.contactNumberController,
                        onCountryChanged: (country) {
                          model.countryDialCode = country.dialCode!;
                        },
                        validator: (value) {
                          if (Validator.isEmpty(value!)) {
                            return "Contact number cannot be empty";
                          }
                          return null;
                        },
                      ),
                      CommonTextFormField(
                        bottomPadding: 16,
                        showAstreik: true,
                        labelText: "Email ID",
                        controller: model.emailIDController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (Validator.isEmpty(value!)) {
                            return "Email cannot be empty";
                          } else if (!Validator.validateEmail(value)) {
                            return "Email is not valid";
                          }
                          return null;
                        },
                      ),
                      CommonTextFormField(
                        bottomPadding: 16,
                        readOnly: true,
                        showAstreik: true,
                        labelText: "Visit Date & Time",
                        controller: model.visitDateTimeController,
                      ),
                      AppStreamBuilder<Resource<TypeOfVisitorResponseModel>>(
                        stream: model.typeOfVisitorResponse,
                        initialData: Resource.none(),
                        dataBuilder: (context, data) {
                          return DataStatusWidget(
                            status: data?.status ?? Status.none,
                            loadingWidget: () => const SizedBox.shrink(),
                            successWidget: () => CustomDropdownButton(
                              width: double.infinity,
                              bottomPadding: 16,
                              items: data?.data?.data
                                      ?.map((e) => e.name)
                                      .toList() ??
                                  [],
                              isMutiSelect: false,
                              dropdownName: "Type Of Visitor",
                              showAstreik: true,
                              showBorderColor: true,
                              onMultiSelect: (_) {},
                              onSingleSelect: (value) {
                                model.setTypeOfVisitorId(value);
                              },
                            ),
                          );
                        },
                      ),
                      CommonTextFormField(
                          bottomPadding: 16,
                          showAstreik: true,
                          labelText: "Point Of Contact",
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r'^[a-zA-Z\s]+$')),
                          ],
                          validator: (value) {
                            if (Validator.isEmpty(value!)) {
                              return "Point of contact cannot be empty";
                            }
                            return null;
                          },
                          controller: model.pointOfContactController),
                      AppStreamBuilder<Resource<PurposeOfVisitModel>>(
                        stream: model.purposeOfVisitResponse,
                        initialData: Resource.none(),
                        dataBuilder: (context, data) {
                          return DataStatusWidget(
                            status: data?.status ?? Status.none,
                            loadingWidget: () => const SizedBox.shrink(),
                            successWidget: () => CustomDropdownButton(
                              width: double.infinity,
                              bottomPadding: 16,
                              items: data?.data?.data
                                      ?.map((e) => e.name)
                                      .toList() ??
                                  [],
                              isMutiSelect: false,
                              dropdownName: "Purpose Of Visit",
                              showAstreik: true,
                              showBorderColor: true,
                              onMultiSelect: (_) {},
                              onSingleSelect: (value) {
                                model.setPurposeOfVisitId(value);
                              },
                            ),
                          );
                        },
                      ),
                      CommonTextFormField(
                        bottomPadding: 16,
                        showAstreik: true,
                        labelText: "Coming From",
                        controller: model.comingFromController,
                        keyboardType: TextInputType.text,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^[a-zA-Z\s]+$'))
                        ],
                        validator: (value) {
                          if (Validator.isEmpty(value!)) {
                            return "Coming from cannot be empty";
                          }
                          return null;
                        },
                      ),
                      CommonTextFormField(
                          bottomPadding: 16,
                          showAstreik: true,
                          labelText: "Guest Count",
                          controller: model.guestCountController,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          keyboardType: TextInputType.number)
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
                    child: CommonOutlineButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        title: "Cancel"),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child:
                        AppStreamBuilder<Resource<CreateGatepassResponseModel>>(
                            stream: model.createGatePassResponse,
                            initialData: Resource.none(),
                            dataBuilder: (context, data) {
                              return CommonPrimaryElevatedButton(
                                isLoading: data?.status == Status.loading,
                                title: "Submit",
                                onPressed: () {
                                  if (model.formKey.currentState!.validate()) {
                                    model.createGatePass();
                                  }
                                },
                              );
                            }),
                  ),
                ],
              ),
            )
          ],
        ),
      );
    });
  }
}


