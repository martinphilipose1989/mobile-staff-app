import 'package:app/themes_setup.dart';
import 'package:app/utils/app_typography.dart';
import 'package:app/utils/common_widgets/common_primary_elevated_button.dart';
import 'package:app/utils/common_widgets/common_text_widget.dart';
import 'package:flutter/material.dart';

class BasicDialog extends StatelessWidget {
  const BasicDialog(
      {super.key,
      required this.message,
      required this.header,
      required this.buttonTitle,
      required this.voidCallback});

  final String message;
  final String header;
  final String buttonTitle;
  final VoidCallback voidCallback;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      insetPadding: EdgeInsets.zero,
      title: CommonText(text: header),
      content: CommonText(
          text: message, color: AppColors.textGray, style: AppTypography.body2),
      actions: [
        CommonPrimaryElevatedButton(
            elevation: 0,
            title: buttonTitle,
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Theme.of(context).colorScheme.onPrimary,
            onPressed: voidCallback)
      ],
    );
  }
}
