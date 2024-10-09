// ignore_for_file: use_key_in_widget_constructors

import 'package:app/feature/transport_management/bus_route_details/bus_route_details_page_viewmodel.dart';
import 'package:app/model/resource.dart';
import 'package:app/themes_setup.dart';
import 'package:app/utils/app_typography.dart';
import 'package:app/utils/common_widgets/app_images.dart';
import 'package:app/utils/common_widgets/common_text_widget.dart';
import 'package:app/utils/data_status_widget.dart';
import 'package:app/utils/stream_builder/app_stream_builder.dart';
import 'package:app/utils/string_formatter.dart';
import 'package:app/utils/url_launcher.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:statemanagement_riverpod/statemanagement_riverpod.dart';

class GuardianList extends BasePageViewWidget<BusRouteDetailsPageViewModel> {
  GuardianList(super.providerBase);

  @override
  Widget build(BuildContext context, BusRouteDetailsPageViewModel model) {
    return AppStreamBuilder<Resource<List<GuardiansDetail>>>(
      stream: model.guardianListStream,
      initialData: Resource.none(),
      dataBuilder: (context, data) {
        return Container(
          height: 0.5.sh,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Guardian",
                      style: AppTypography.subtitle1
                          .copyWith(color: AppColors.textDark)),
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.close))
                ],
              ),
              Divider(height: 16.h, color: AppColors.dividerColor),
              Expanded(
                child: DataStatusWidget(
                  status: data?.status ?? Status.none,
                  loadingWidget: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  successWidget: () => ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: data?.data?.length,
                      itemBuilder: (context, index) {
                        final guardian = data?.data?[index];
                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          minVerticalPadding: 32,
                          leading: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: const BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                            ),
                            child: CommonText(
                              text:
                                  "${guardian?.firstName ?? ""} ${guardian?.lastName ?? ""}"
                                      .getInitials(),
                              color: Colors.white,
                              style: AppTypography.subtitle2,
                            ),
                          ),
                          title: CommonText(
                              text:
                                  "${guardian?.firstName?.capitalizeFirst() ?? ""} ${guardian?.lastName?.capitalizeFirst() ?? ""}"),
                          trailing: IconButton(
                            onPressed: () {
                              UrlLauncher.launchPhone("${guardian?.mobileNo}");
                            },
                            icon: SvgPicture.asset(AppImages.callIcon),
                          ),
                        );
                      }),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
