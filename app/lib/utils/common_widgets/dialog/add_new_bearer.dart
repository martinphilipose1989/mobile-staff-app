import 'package:app/themes_setup.dart';
import 'package:app/utils/app_typography.dart';
import 'package:app/utils/common_widgets/app_images.dart';
import 'package:app/utils/common_widgets/common_dropdown.dart';
import 'package:app/utils/common_widgets/common_image_widget.dart';
import 'package:app/utils/common_widgets/common_primary_elevated_button.dart';
import 'package:app/utils/common_widgets/common_text_widget.dart';
import 'package:app/utils/common_widgets/common_textformfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddNewBearer extends StatelessWidget {
  const AddNewBearer(
      {super.key,
      required this.cancelCallback,
      required this.addNewBearerCallback});

  final VoidCallback cancelCallback;
  final VoidCallback addNewBearerCallback;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      insetPadding: const EdgeInsets.all(16),
      child: Container(
        width: double.infinity,
        padding: REdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonText(text: "Add New Bearer", style: AppTypography.h5),
            const SizedBox(height: 16),
            CommonText(text: "Add Profile Photo", style: AppTypography.caption),
            AddBearerImagePicker(onProfilePick: () {}),
            const CommonTextFormField(
                topPadding: 16, showAstreik: false, labelText: "Bearer Name"),
            CustomDropdownButton(
                items: const ["Male", "Female"],
                onSingleSelect: (value) {},
                dropdownName: "Gender",
                showAstreik: false),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CommonPrimaryElevatedButton(
                  title: "Cancel",
                  onPressed: () {},
                  backgroundColor: AppColors.textPalerGray,
                  foregroundColor: AppColors.textGray,
                ),
                SizedBox(width: 8.w),
                CommonPrimaryElevatedButton(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  title: "Add Bearer",
                  onPressed: () {},
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class AddBearerImagePicker extends StatelessWidget {
  const AddBearerImagePicker({super.key, required this.onProfilePick});

  // final CreateEditGatePassViewModel model;
  final VoidCallback onProfilePick;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Stack(
        children: [
          Card(
              shadowColor: AppColors.shadowColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(80.r),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Visibility(
                    visible: false,
                    replacement: ClipOval(
                      child: CommonImageWidget(
                        imageUrl: "", //"${data?.data?.data?.url}",
                        imageHeight: 100.w,
                        imageWidth: 100.w,
                      ),
                    ),
                    child: const Center(
                      child:
                          CircularProgressIndicator(), // Progress indicator while loading
                    ),
                  ),
                ],
              )),
          Positioned(
            bottom: 10.h,
            right: 0,
            child: InkWell(
              customBorder: const CircleBorder(),
              onTap: onProfilePick,
              child: Container(
                height: 35.w,
                width: 35.w,
                padding: REdgeInsets.all(8),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    // data?.status == Status.loading
                    //     ? AppColors.textGray
                    //     : AppColors.primary,
                    shape: BoxShape.circle),
                child: SvgPicture.asset(AppImages.editIcon,
                    height: 24.w, width: 24.w),
              ),
            ),
          )
        ],
      ),
    );
  }
}
