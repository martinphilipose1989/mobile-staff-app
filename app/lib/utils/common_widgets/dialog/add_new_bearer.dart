import 'package:app/themes_setup.dart';
import 'package:app/utils/app_typography.dart';
import 'package:app/utils/common_widgets/common_dropdown.dart';
import 'package:app/utils/common_widgets/common_primary_elevated_button.dart';
import 'package:app/utils/common_widgets/common_text_widget.dart';
import 'package:app/utils/common_widgets/common_textformfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
            const CommonTextFormField(
                topPadding: 16, showAstreik: false, labelText: "Bearer Name"),
            const CustomDropdownButton(
                items: ["Male", "Female"],
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
                    foregroundColor: AppColors.textGray),
                SizedBox(width: 8.w),
                CommonPrimaryElevatedButton(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                    title: "Add Bearer",
                    onPressed: () {}),
              ],
            )
          ],
        ),
      ),
    );
  }
}
