import 'package:app/feature/gate_management/create_edit_gate_pass/create_edit_gate_pass_page.dart';
import 'package:app/feature/gate_management/create_edit_gate_pass/create_edit_gate_pass_viewmodel.dart';

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
  final GatePassArguments? arguments;
  // ignore: use_super_parameters
  CreateEditGatePassPageView(
      ProviderBase<CreateEditGatePassViewModel> model, this.arguments)
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
                        labelText:
                            arguments?.parentData.visitorName?.isNotEmpty ??
                                    false
                                ? "Parent Name"
                                : "Visitor Name",
                        readOnly:
                            arguments?.parentData.visitorName?.isNotEmpty ??
                                false,
                        controller: model.visitorNameController,
                        keyboardType: TextInputType.name,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^[a-zA-Z\s]+$'))
                        ],
                        validator: (value) {
                          if (Validator.isEmpty(value!)) {
                            return "${arguments?.parentData.visitorName?.isNotEmpty ?? false ? "Parent Name" : "Visitor Name"} cannot be empty";
                          }
                          return null;
                        },
                      ),
                      AppStreamBuilder<String>(
                          stream: model.countryDialCode.stream,
                          initialData: model.countryDialCode.value,
                          dataBuilder: (context, countryDialCode) {
                            return CountryPickerPhoneTextField(
                              initialSelection: countryDialCode!,
                              controller: model.contactNumberController,
                              onChanged: (value) {
                                if (value.length == 10) {
                                  model.populateVisitorData();
                                }
                              },
                              onCountryChanged: (country) {
                                model.countryDialCode.add(country.dialCode!);
                              },
                              validator: (value) {
                                if (Validator.isEmpty(value!)) {
                                  return "Contact number cannot be empty";
                                } else if (value.length < 10) {
                                  return "Contact number cannot be less than 10 digits";
                                }
                                return null;
                              },
                            );
                          }),
                      CommonTextFormField(
                        bottomPadding: 16,
                        showAstreik: true,
                        labelText: "Email ID",
                        readOnly:
                            arguments?.parentData.visitorEmail?.isNotEmpty ??
                                false,
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
                      AppStreamBuilder<Resource<MdmCoReasonResponseModel>>(
                        stream: model.typeOfVisitorResponse,
                        initialData: Resource.none(),
                        dataBuilder: (context, data) {
                          return DataStatusWidget(
                            status: data?.status ?? Status.none,
                            loadingWidget: () => const SizedBox.shrink(),
                            successWidget: () => AppStreamBuilder<String?>(
                                stream: model.intialTypeOfVisitor!.stream,
                                initialData: model.intialTypeOfVisitor?.value,
                                dataBuilder: (context, visitorType) {
                                  return CustomDropdownButton(
                                    bottomPadding: 32,
                                    intialValue: visitorType,
                                    items: arguments?.parentData.visitorName
                                                ?.isEmpty ??
                                            true
                                        ? data?.data?.data
                                                ?.map((e) => e.attributes?.name)
                                                .toList() ??
                                            <String>[]
                                        : data?.data?.data
                                                ?.map((e) => e.attributes?.name)
                                                .toList()
                                                .where((e) =>
                                                    e?.toLowerCase() ==
                                                    "parent")
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
                                    validator: (value) {
                                      if (value == null ||
                                          Validator.isEmpty(value)) {
                                        return "Type of visitor cannot be empty";
                                      }
                                      return null;
                                    },
                                  );
                                }),
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
                      AppStreamBuilder<Resource<MdmCoReasonResponseModel>>(
                        stream: model.purposeOfVisitResponse,
                        initialData: Resource.none(),
                        dataBuilder: (context, data) {
                          return DataStatusWidget(
                            status: data?.status ?? Status.none,
                            loadingWidget: () => const SizedBox.shrink(),
                            successWidget: () => CustomDropdownButton(
                              bottomPadding: 32,
                              items: data?.data?.data
                                      ?.map((e) => e.attributes?.name)
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
                              validator: (value) {
                                if (value == null || Validator.isEmpty(value)) {
                                  return "Purpose of visit cannot be empty";
                                }
                                return null;
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
                          validator: (value) {
                            if (Validator.isEmpty(value!)) {
                              return "Guest count cannot be empty";
                            }

                            return null;
                          },
                          inputFormatters: [
                            FilteringTextInputFormatter.deny(RegExp(r'^0+')),
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          keyboardType: TextInputType.number),
                      CommonTextFormField(
                          bottomPadding: 16,
                          showAstreik: false,
                          labelText: "Vehicle Number",
                          keyboardType: TextInputType.text,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r'^[a-zA-Z0-9\s]+$')),
                          ],
                          controller: model.vehicleController),
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
                    child: AppStreamBuilder<Resource<bool>>(
                        stream: model.loadingSubject.stream,
                        initialData: Resource.none(),
                        dataBuilder: (context, data) {
                          return CommonPrimaryElevatedButton(
                            isLoading: data?.data ?? false,
                            title: "Submit",
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              if (model.formKey.currentState!.validate()) {
                                model.creatOrUpdateGatePass();
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
