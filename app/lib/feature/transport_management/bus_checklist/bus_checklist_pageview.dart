import 'package:app/model/resource.dart';
import 'package:app/molecules/transport_management/arrival_info/arrival_info_tile.dart';

import 'package:app/molecules/transport_management/trip_checklist/trip_verification_pop_up.dart';
import 'package:app/navigation/route_paths.dart';
import 'package:app/utils/app_typography.dart';
import 'package:app/utils/common_widgets/app_images.dart';
import 'package:app/utils/common_widgets/common_image_widget.dart';
import 'package:app/utils/common_widgets/common_primary_elevated_button.dart';
import 'package:app/utils/common_widgets/common_refresh_indicator.dart';
import 'package:app/utils/common_widgets/common_text_widget.dart';

import 'package:app/utils/common_widgets/dialog/view_bearer.dart';
import 'package:app/utils/common_widgets/no_data_found_widget.dart';
import 'package:app/utils/data_status_widget.dart';
import 'package:app/utils/enum/dialog_enum.dart';
import 'package:app/utils/stream_builder/app_stream_builder.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:statemanagement_riverpod/statemanagement_riverpod.dart';
import 'bus_checklist_page_viewmodel.dart';

class BusChecklistPageView
    extends BasePageViewWidget<BusChecklistPageViewModel> {
  // ignore: use_super_parameters
  BusChecklistPageView(ProviderBase<BusChecklistPageViewModel> model)
      : super(model);

  @override
  Widget build(BuildContext context, BusChecklistPageViewModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
            child: ArrivalInfoTile(
                vehicleNumber:
                    model.trip?.routeBusUserMapping?[0].bus?.busNumber ?? '',
                startTime: model.trip?.shiftName ?? '',
                totalStudents: model.trip?.studentStopsMappings?.length ?? 0)),
        Padding(
          padding: const EdgeInsets.all(16),
          child:
              CommonText(text: "Bus Checklist", style: AppTypography.subtitle2),
        ),
        Expanded(
            child: AppStreamBuilder<Resource<List<Checklist>>>(
          stream: model.checkListStream,
          initialData: Resource.none(),
          dataBuilder: (context, checkListdata) {
            return CommonRefreshIndicator(
                onRefresh: () {
                  return model.refreshMyDutyList();
                },
                child: DataStatusWidget(
                  status: checkListdata?.status ?? Status.none,
                  loadingWidget: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: () => Center(
                    child: NoDataFoundWidget(
                      title: checkListdata?.dealSafeAppError?.error.message
                                  .contains("internet") ??
                              false
                          ? "No Internet Connection"
                          : "Something Went Wrong",
                      subtitle: checkListdata?.dealSafeAppError?.error.message
                                  .contains("internet") ??
                              false
                          ? "It seems you're offline. Please check your internet connection and try again."
                          : "An unexpected error occurred. Please try again later or contact support if the issue persists.",
                      onPressed: () {
                        model.refreshMyDutyList();
                      },
                    ),
                  ),
                  successWidget: () {
                    return AppStreamBuilder<bool>(
                      stream: model.hasMorePagesStream,
                      initialData: model.hasMorePagesSubject.value,
                      dataBuilder: (context, hasMorePage) {
                        return NotificationListener<ScrollNotification>(
                          onNotification: (scrollNotification) {
                            if (scrollNotification.metrics.pixels ==
                                scrollNotification.metrics.maxScrollExtent) {
                              //model.loadMoreVisitorList();
                            }
                            return false;
                          },
                          child: AppStreamBuilder<bool>(
                            stream: model.loadingStream,
                            initialData: false,
                            dataBuilder: (context, isLoading) {
                              final itemCount =
                                  (checkListdata?.data?.length ?? 0) +
                                      (isLoading! && hasMorePage! ? 1 : 0);
                              return Visibility(
                                visible: checkListdata?.data?.isEmpty ?? false,
                                replacement: CommonRefreshIndicator(
                                  isChildScrollable: true,
                                  onRefresh: () {
                                    return model.refreshMyDutyList();
                                  },
                                  child: ListView.builder(
                                    itemCount: itemCount,
                                    itemBuilder: (context, index) {
                                      if (index <
                                          (checkListdata?.data?.length ?? 0)) {
                                        return ListTile(
                                          minVerticalPadding: 0,
                                          leading: CommonImageWidget(
                                            imageUrl: checkListdata
                                                    ?.data?[index].img ??
                                                '',
                                            clipBehavior: Clip.hardEdge,
                                            fallbackAssetImagePath:
                                                AppImages.defaultDriverAvatar,
                                            imageHeight: 40.h,
                                            imageWidth: 40.w,
                                          ),
                                          title: CommonText(
                                              text: checkListdata?.data?[index]
                                                      .checkList ??
                                                  '',
                                              style: AppTypography.subtitle2),
                                          subtitle: CommonText(
                                              text: checkListdata?.data?[index]
                                                      .description ??
                                                  '',
                                              style: AppTypography.body2),
                                          trailing: (checkListdata?.data?[index]
                                                      .isVerified ??
                                                  false)
                                              ? Container(
                                                  height: 40.h,
                                                  decoration: BoxDecoration(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .primaryContainer,
                                                      border: Border.all(
                                                          color: Theme.of(
                                                                  context)
                                                              .primaryColor),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        10,
                                                      )),
                                                  child: TextButton.icon(
                                                      onPressed: () {},
                                                      icon: SvgPicture.asset(
                                                          AppImages.checkMark),
                                                      label: CommonText(
                                                          text: "Verified",
                                                          style: AppTypography
                                                              .subtitle2)),
                                                )
                                              : TextButton.icon(
                                                  icon: SvgPicture.asset(
                                                      AppImages.checkMark),
                                                  onPressed: () {
                                                    tripVerificationPopUp(
                                                        context,
                                                        positiveCallback: () {
                                                      model.verifyData(
                                                          checkListdata?.data ??
                                                              [],
                                                          index);
                                                      Navigator.pop(context);
                                                    }, negativeCallback: () {
                                                      Navigator.pop(context);
                                                    },
                                                        header: checkListdata
                                                                ?.data?[index]
                                                                .slug ??
                                                            '',
                                                        info: "+91-9090901234",
                                                        name: checkListdata
                                                                ?.data?[index]
                                                                .checkList ??
                                                            '',
                                                        role: 'Call',
                                                        type:
                                                            DialogType.driver);
                                                  },
                                                  label: CommonText(
                                                      text: "Confirm",
                                                      style: AppTypography
                                                          .subtitle2),
                                                ),
                                        );
                                      } else if (isLoading) {
                                        return const Padding(
                                          padding: EdgeInsets.only(
                                              left: 16, right: 16, bottom: 32),
                                          child: Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                        );
                                      } else {
                                        return const SizedBox.shrink();
                                      }
                                    },
                                  ),
                                ),
                                child: const NoDataFoundWidget(
                                  title: "No Check List Found",
                                ),
                              );
                            },
                          ),
                        );
                      },
                    );
                  },
                ));
          },
        )),
        const Spacer(),
        AppStreamBuilder<Resource<List<Checklist>>>(
          stream: model.checkListStream,
          initialData: Resource.none(),
          dataBuilder: (context, data) {
            return Container(
              padding: REdgeInsets.only(left: 16, right: 16, bottom: 20),
              width: double.infinity,
              child: CommonPrimaryElevatedButton(
                title: "Continue",
                isDisabled: !(data?.data
                            ?.every((element) => element.isVerified == true) ??
                        false)
                    ? true
                    : false,
                onPressed: () {
                  Navigator.pushNamed(context, RoutePaths.busRouteListPage);
                },
              ),
            );
          },
        )
      ],
    );
  }

  Future<dynamic> tripVerificationPopUp(BuildContext context,
      {required String header,
      required String info,
      required String name,
      required String role,
      required DialogType type,
      Function()? negativeCallback,
      Function()? positiveCallback,
      String imageUrl = ''}) {
    return showDialog(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: TripVerificationPopUp(
              header: header,
              info: info,
              name: name,
              imageUrl: imageUrl,
              negativeText: role,
              negativeCallback: negativeCallback!,
              positiveCallback: positiveCallback!,
              type: type),
        );
      },
    );
  }
}
