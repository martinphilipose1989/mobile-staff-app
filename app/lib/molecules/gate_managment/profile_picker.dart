import 'package:app/feature/gate_managment/create_edit_gate_pass/create_edit_gate_pass_viewmodel.dart';
import 'package:app/themes_setup.dart';
import 'package:app/utils/common_widgets/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ProfilePicker extends StatelessWidget {
  const ProfilePicker(
      {super.key, required this.model, required this.onProfilePick});

  final CreateEditGatePassViewModel model;
  final VoidCallback onProfilePick;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Stack(
        children: [
          Card(
            shadowColor: AppColors.shadowColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(80.r),
              //set border radius more than 50% of height and width to make circle
            ),
            child: CircleAvatar(
              radius: 70.r,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 60.r,
                backgroundImage: const AssetImage(AppImages.defaultAvatar),
              ),
            ),
          ),
          Positioned(
            bottom: 20.h,
            right: 0,
            child: InkWell(
              customBorder: const CircleBorder(),
              onTap: onProfilePick,
              child: Container(
                height: 40.w,
                width: 40.w,
                padding: REdgeInsets.all(8),
                decoration: const BoxDecoration(
                    color: AppColors.primary, shape: BoxShape.circle),
                child: SvgPicture.asset(AppImages.camera,
                    height: 24.w, width: 24.w),
              ),
            ),
          )
        ],
      ),
    );
  }
}
