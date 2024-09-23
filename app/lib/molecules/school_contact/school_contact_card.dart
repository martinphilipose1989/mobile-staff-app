import 'package:app/themes_setup.dart';
import 'package:app/utils/app_typography.dart';
import 'package:app/utils/common_widgets/app_images.dart';
import 'package:app/utils/common_widgets/common_card_wrapper.dart';
import 'package:app/utils/common_widgets/common_image_widget.dart';
import 'package:app/utils/common_widgets/common_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SchoolContactCard extends StatelessWidget {
  const SchoolContactCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CommonCardWrapper(
      contentPadding: EdgeInsets.zero,
      left: 16,
      right: 16,
      bottom: 16,
      top: 16,
      child: ListTile(
        minVerticalPadding: 16,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        tileColor: AppColors.listItem,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        leading: const CommonImageWidget(
            clipBehavior: Clip.hardEdge,
            imageUrl: "",
            imageWidth: 40,
            imageHeight: 40,
            fallbackAssetImagePath: AppImages.pageViewImages),
        title: CommonText(
            text: "Principal",
            style: AppTypography.subtitle2,
            color: AppColors.textDark),
        subtitle: CommonText(
            text: "+91-8754979784",
            color: AppColors.textGray,
            style: AppTypography.body2),
        trailing: IconButton(
            onPressed: () {}, icon: SvgPicture.asset(AppImages.callIcon)),
      ),
    );
  }
}
