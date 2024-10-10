import 'dart:convert';
import 'dart:developer';

import 'dart:typed_data';

import 'package:app/di/states/viewmodels.dart';
import 'package:app/feature/gate_management/visitor_details/visitor_details_viewmodel.dart';
import 'package:app/model/resource.dart';
import 'package:app/molecules/gate_managment/visitor_details/visitor_details_row.dart';
import 'package:app/molecules/gate_managment/visitor_details/visitor_details_shimmer.dart';
import 'package:app/molecules/gate_managment/visitor_details/visitor_info_card.dart';

import 'package:app/utils/common_widgets/common_primary_elevated_button.dart';

import 'package:app/utils/common_widgets/no_data_found_widget.dart';
import 'package:app/utils/data_status_widget.dart';
import 'package:app/utils/dateformate.dart';
import 'package:app/utils/stream_builder/app_stream_builder.dart';
import 'package:data/data.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:statemanagement_riverpod/statemanagement_riverpod.dart';

class VisitorDetailsPageView
    extends BasePageViewWidget<VisitorDetailsViewModel> {
  final String gatePassId;
  final String? visitorType;
  // ignore: use_super_parameters
  VisitorDetailsPageView(ProviderBase<VisitorDetailsViewModel> model,
      {required this.gatePassId, this.visitorType})
      : super(model);

  @override
  Widget build(BuildContext context, VisitorDetailsViewModel model) {
    return AppStreamBuilder<Resource<VisitorDataModel>>(
        stream: model.visitorDetails,
        initialData: Resource.none(),
        dataBuilder: (context, visitorData) {
          log("message ${visitorData?.data}");
          return DataStatusWidget(
              status: visitorData?.status ?? Status.none,
              loadingWidget: () => const VisitorDetailsPageShimmer(),
              errorWidget: () => Center(
                    child: NoDataFoundWidget(
                      title: visitorData?.dealSafeAppError?.error.message
                                  .contains("internet") ??
                              false
                          ? "No Internet Connection"
                          : "Something Went Wrong",
                      subtitle: visitorData?.dealSafeAppError?.error.message
                                  .contains("internet") ??
                              false
                          ? "It seems you're offline. Please check your internet connection and try again."
                          : "An unexpected error occurred. Please try again later or contact support if the issue persists.",
                      onPressed: () {
                        model.getVisitorDetails(gatePassId: gatePassId);
                      },
                    ),
                  ),
              successWidget: () {
                Uint8List qrImageBytes = Uint8List(0);
                if (visitorData != null &&
                    visitorData.data != null &&
                    visitorData.data!.qrCode!.isNotEmpty) {
                  // Remove the data URL prefix if it exists
                  String cleanBase64 =
                      visitorData.data!.qrCode.toString().split(',').last;

                  // Decode the base64 string
                  qrImageBytes = base64Decode(cleanBase64);
                }

                return Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: REdgeInsets.all(
                            16.0,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              VisitorInfoCard(
                                visitorName:
                                    "${visitorData?.data?.visitorName ?? ''}  (#${visitorData?.data?.gatePassNumber ?? "N/A"})",
                                issuedOn: '${visitorData?.data?.issuedDate}',
                                // qrImagePath: AppImages.qrImage,
                                qrImagePath: qrImageBytes,
                                avatarImagePath: visitorData
                                        ?.data?.visitorProfileImageImageUrl ??
                                    '',
                              ),
                              SizedBox(height: 16.h),
                              VisitorDetailsRow(
                                title1: "Contact Number",
                                value1: visitorData?.data?.visitorMobile ?? '',
                                title2: "Email ID",
                                value2: visitorData?.data?.visitorEmail ?? '',
                              ),
                              SizedBox(height: 16.h),
                              VisitorDetailsRow(
                                  title1: "Type of visitor",
                                  //value1: "parent",
                                  value1: visitorData?.data?.visitorType ?? '',
                                  title2: "Point Of Contact",
                                  value2:
                                      visitorData?.data?.pointOfContact ?? ''),
                              SizedBox(height: 16.h),
                              VisitorDetailsRow(
                                title1: "Purpose Of Visit",
                                value1: visitorData?.data?.purposeOfVisit ?? '',
                                title2: "Coming From",
                                value2: visitorData?.data?.comingFrom ?? '',
                              ),
                              SizedBox(height: 16.h),
                              VisitorDetailsRow(
                                title1: "Date",
                                value1:
                                    "${visitorData?.data?.issuedDate?.replaceAll('-', '/')}",
                                title2: "Time",
                                value2: visitorData
                                            ?.data?.outgoingTime?.isNotEmpty ??
                                        false
                                    ? visitorData?.data?.outgoingTime
                                            ?.formatTimeWithoutIntl() ??
                                        ""
                                    : visitorData?.data?.incomingTime
                                            ?.formatTimeWithoutIntl() ??
                                        '',
                              ),
                              SizedBox(height: 16.h),
                              VisitorDetailsRow(
                                title1: "Guest Count",
                                value1:
                                    visitorData?.data?.guestCount.toString() ??
                                        '',
                                title2: visitorData
                                            ?.data?.vehicleNumber?.isNotEmpty ??
                                        false
                                    ? "Vehicle Number"
                                    : "",
                                value2: visitorData?.data?.vehicleNumber ?? "",
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: REdgeInsets.only(
                          bottom: 16, right: 16, left: 16, top: 16),
                      child: CommonPrimaryElevatedButton(
                          title: "Close",
                          width: MediaQuery.of(context).size.width,
                          onPressed: () {
                            ProviderScope.containerOf(context)
                                .read(visitorListPageModelProvider)
                                .fetchVisitorList();
                            Navigator.pop(context, visitorType);
                          }),
                    )
                  ],
                );
              });
        });
  }
}
