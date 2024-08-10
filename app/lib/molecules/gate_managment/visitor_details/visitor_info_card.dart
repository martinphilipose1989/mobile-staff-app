import 'package:app/themes_setup.dart';
import 'package:app/utils/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class VisitorInfoCard extends StatelessWidget {
  final String visitorName;
  final String issuedOn;
  final String qrImagePath;
  final String avatarImagePath;

  const VisitorInfoCard({
    super.key,
    required this.visitorName,
    required this.issuedOn,
    required this.qrImagePath,
    required this.avatarImagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(
            top: 67,
          ),
          padding: const EdgeInsets.only(
            top: 67 + 24,
            left: 16,
            right: 16,
            bottom: 24,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.all(
              Radius.circular(10.r),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.max,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    visitorName,
                    style: AppTypography.h6.copyWith(
                      color: AppColors.textDark,
                    ),
                  ),
                  Text(
                    "Issued On: $issuedOn",
                    style: AppTypography.body2.copyWith(
                      color: AppColors.textGray,
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
              SvgPicture.asset(
                qrImagePath,
                height: 45.w,
                width: 45.w,
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Material(
            shadowColor: AppColors.shadowColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                70.r,
              ),
            ),
            child: CircleAvatar(
              radius: 66.r,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 58.r,
                backgroundImage: AssetImage(
                  avatarImagePath,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
