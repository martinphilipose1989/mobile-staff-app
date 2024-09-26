import 'package:app/utils/app_typography.dart';
import 'package:app/utils/common_widgets/common_card_wrapper.dart';
import 'package:app/utils/common_widgets/common_text_widget.dart';
import 'package:flutter/material.dart';

class AttendanceCountTile extends StatelessWidget {
  const AttendanceCountTile(
      {super.key,
      required this.count,
      required this.countType,
      required this.textColor});

  final int count;
  final String countType;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: CommonCardWrapper(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: Column(
          children: [
            CommonText(
                text: "$count",
                style: AppTypography.subtitle2,
                color: textColor),
            CommonText(
                text: countType,
                style: AppTypography.caption,
                color: textColor),
          ],
        ),
      ),
    );
  }
}
