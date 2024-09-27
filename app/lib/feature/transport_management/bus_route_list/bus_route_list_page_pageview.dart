import 'package:app/molecules/transport_management/arrival_info/arrival_info_tile.dart';
import 'package:app/themes_setup.dart';
import 'package:app/utils/app_typography.dart';
import 'package:app/utils/common_widgets/app_images.dart';
import 'package:app/utils/common_widgets/common_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:statemanagement_riverpod/statemanagement_riverpod.dart';
import 'bus_route_list_page_viewmodel.dart';

class BusRouteListPageView
    extends BasePageViewWidget<BusRouteListPageViewModel> {
  // ignore: use_super_parameters
  BusRouteListPageView(ProviderBase<BusRouteListPageViewModel> model)
      : super(model);

  @override
  Widget build(BuildContext context, BusRouteListPageViewModel model) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(16),
          child: ArrivalInfoTile(
              vehicleNumber: "MH47-PK-9386",
              startTime: "7:00 AM",
              totalStudents: 10),
        ),
        Expanded(
          child: ListView.separated(
              itemCount: 10,
              separatorBuilder: (context, index) {
                return SizedBox(height: 8.h);
              },
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TimelineTile(
                    index: index,
                    isActive: true,
                    lineWidth: 3.w,
                    circleColor: AppColors.primary,
                    leadingChild: Column(
                      children: [
                        CommonText(
                            text: "7:00 Am",
                            style: AppTypography.caption,
                            color: AppColors.textGray),
                        CommonText(
                            text: "7:00 Am",
                            style: AppTypography.caption,
                            color: index == 0
                                ? AppColors.success
                                : AppColors.failure),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonText(
                            text: "Vibgyor Kids and High - Malad West",
                            color: index == 0
                                ? AppColors.primary
                                : AppColors.textLightGray,
                            style: AppTypography.subtitle2),
                        Row(
                          children: [
                            SvgPicture.asset(AppImages.userOutlineIcon),
                            CommonText(
                                text: "5 Students (3 Present,2 Absent)",
                                color: AppColors.textGray,
                                style: AppTypography.caption),
                          ],
                        ),
                        if (index == 0)
                          Expanded(child: Container(height: 100.h))
                      ],
                    ),
                  ),
                );
              }),
        ),

        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
        //   child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // Column(
        //   children: [
        //     CommonText(
        //         text: "7:00 Am",
        //         style: AppTypography.caption,
        //         color: AppColors.textGray),
        //     CommonText(
        //         text: "7:00 Am",
        //         style: AppTypography.caption,
        //         color: AppColors.success),
        //   ],
        // ),
        //     SizedBox(width: 12.w),
        // Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        //   const Icon(Icons.check_circle, color: AppColors.primary),
        //   Container(
        //     width: 3.w,
        //     height: 32.h,
        //     color: AppColors.primary,
        //   ),
        // ])
        // SizedBox(height: 24.h),
        // Image.asset(AppImages.yellowBus, height: 70.h),
        //       ],
        //     ),
        //     SizedBox(width: 12.w),
        //     Expanded(
        //       child:
        // Column(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: [
        // const CommonText(text: "Vibgyor Kids and High - Malad West"),
        // const CommonText(text: "5 Students (3 Present,2 Absent)"),
        //           SizedBox(height: 48.h),
        //           Row(
        //             children: [
        // Container(
        //   decoration: BoxDecoration(
        //     color: AppColors.primaryLighter,
        //     borderRadius: BorderRadius.circular(4),
        //   ),
        //   padding: const EdgeInsets.symmetric(
        //       vertical: 6, horizontal: 10),
        //   child: const CommonText(
        //       text:
        //           "Currently at Prabhadevi \n(Updated 1 mins ago)"),
        // ),
        //             ],
        //           )
        //         ],
        //       ),
        //     )
        //   ]),
        // )
      ],
    );
  }
}

class TimelineTile extends StatelessWidget {
  const TimelineTile({
    super.key,
    this.lineWidth = 1.3,
    this.circleSize,
    this.lineColor,
    this.circleColor,
    this.leadingChild,
    this.isActive = false,
    required this.index,
    required this.child,
  });

  final double? lineWidth;
  final double? circleSize;
  final Color? lineColor;
  final Color? circleColor;
  final Widget? child;
  final Widget? leadingChild;
  final int index;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.centerLeft,
          children: [
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 3.w,
                  ),
                  if (leadingChild != null) leadingChild ?? Container(),
                  SizedBox(
                    width: 3.w,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Visibility(
                              visible: index == 0,
                              replacement: Container(
                                alignment: Alignment.bottomCenter,
                                padding: const EdgeInsets.all(4),
                                margin: EdgeInsets.only(bottom: 2.h),
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.textLightGray),
                                child: CommonText(
                                    text: "${index + 1}",
                                    style: AppTypography.caption,
                                    color: Colors.white),
                              ),
                              child: Container(
                                alignment: Alignment.bottomCenter,
                                padding: const EdgeInsets.all(4),
                                margin: EdgeInsets.only(bottom: 2.h),
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.primary),
                                child: const Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            )
                          ],
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Container(
                                  color: index == 0
                                      ? AppColors.primary
                                      : AppColors.textLightGray,
                                  width: lineWidth,
                                  child: Column(
                                    children: [
                                      for (int i = 0; i < 10; i++)
                                        Column(
                                          children: [
                                            Container(
                                              color: index == 0
                                                  ? AppColors.primary
                                                  : AppColors.textLightGray,
                                              height: 5.h,
                                              width: lineWidth,
                                            ),
                                          ],
                                        )
                                    ],
                                  ),
                                ),
                              ),
                              if (index == 0) ...{
                                SizedBox(height: 24.h),
                                Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    Image.asset(AppImages.yellowBus,
                                        height: 70.h),
                                    Positioned(
                                      left: 60.w,
                                      top: 8,
                                      child: Stack(
                                        alignment: Alignment.centerLeft,
                                        clipBehavior: Clip.none,
                                        children: [
                                          Positioned(
                                            left: -2,
                                            top: 13,
                                            bottom: 0,
                                            child: RotatedBox(
                                              quarterTurns: 3,
                                              child: SizedBox(
                                                width: 20,
                                                height: 20,
                                                child: Transform(
                                                  alignment: Alignment.center,
                                                  transform: Matrix4.identity()
                                                    ..rotateZ(-3.14 /
                                                        4), // Rotate to create the triangle effect
                                                  child: ClipPath(
                                                    clipper: TriangleClipper(),
                                                    child: Container(
                                                      color: AppColors
                                                          .primaryLighter,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              color: AppColors.primaryLighter,
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                            ),
                                            margin: EdgeInsets.zero,
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 6, horizontal: 10),
                                            child: const CommonText(
                                                text:
                                                    "Currently at Prabhadevi \n(Updated 1 mins ago)"),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              },
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: child ??
                        Container(
                          height: 10.h,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class TriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(size.width, size.height); // Bottom right
    path.lineTo(size.width, 0); // Top right
    path.close(); // Close to the starting point
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false; // No need to reclip
  }
}
