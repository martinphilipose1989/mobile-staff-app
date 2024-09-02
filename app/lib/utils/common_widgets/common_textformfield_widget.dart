import 'package:app/themes_setup.dart';
import 'package:app/utils/app_typography.dart';
import 'package:app/utils/common_widgets/common_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonTextFormField extends StatelessWidget {
  final String? labelText;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final String? hintText;
  final FormFieldValidator<String>? validator;
  final bool obscureText;
  final InputDecoration? decoration;
  final int? maxLines;
  final bool showSearchIcon;
  final Widget? prefix;
  final bool showAstreik;
  final double rightPadding;
  final double leftPadding;
  final double topPadding;
  final double bottomPadding;
  final bool enableInteractiveSelection;
  final bool readOnly;
  final Color? fillColor;
  final TextStyle? labelTextStyle;
  final TextInputAction textInputAction;
  final void Function(String)? onChanged;
  final BoxConstraints? prefixIconConstraints;
  final List<TextInputFormatter>? inputFormatters;

  const CommonTextFormField(
      {super.key,
      this.labelText,
      this.controller,
      this.keyboardType = TextInputType.text,
      this.hintText,
      this.validator,
      this.obscureText = false,
      this.decoration,
      this.maxLines,
      required this.showAstreik,
      this.showSearchIcon = false,
      this.prefix,
      this.topPadding = 0,
      this.bottomPadding = 0,
      this.rightPadding = 0,
      this.leftPadding = 0,
      this.enableInteractiveSelection = true,
      this.readOnly = false,
      this.fillColor,
      this.labelTextStyle,
      this.textInputAction = TextInputAction.done,
      this.onChanged,
      this.prefixIconConstraints,
      this.inputFormatters = const []});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.only(
          top: topPadding,
          bottom: bottomPadding,
          left: leftPadding,
          right: rightPadding),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          TextFormField(
            cursorColor: AppColors.primary,
            inputFormatters: inputFormatters,
            onChanged: (value) {
              if (value.isNotEmpty && value.startsWith(' ')) {
                controller?.text = value.trimLeft(); // Remove leading spaces
                controller?.selection = TextSelection.fromPosition(
                  TextPosition(offset: controller?.text.length ?? 0),
                );
              } else {
                onChanged?.call(value);
              }
            },
            textInputAction: textInputAction,
            ignorePointers: readOnly,
            readOnly: readOnly,
            enableInteractiveSelection: enableInteractiveSelection,
            controller: controller,
            cursorHeight: 20,
            style: AppTypography.body1
                .copyWith(color: readOnly ? AppColors.textLightGray : null),
            keyboardType: keyboardType,
            validator: validator,
            obscureText: obscureText,
            maxLines: maxLines ?? 1,
            decoration: decoration ??
                InputDecoration(
                    prefixIcon: prefix,
                    prefixIconConstraints: prefixIconConstraints,
                    hintText: hintText ?? '',
                    fillColor: fillColor,
                    filled: fillColor != null),
          ),
          Positioned(
            left: 6,
            top: -11,
            child: labelText != ''
                ? Container(
                    color: Colors
                        .white, // Match the background color to avoid overlap
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Row(
                      children: [
                        CommonText(
                          text: labelText ?? "",
                          style: readOnly
                              ? AppTypography.caption
                                  .copyWith(color: AppColors.textLightGray)
                              : labelTextStyle ??
                                  AppTypography.caption
                                      .copyWith(color: AppColors.textNeutral35),
                        ),
                        readOnly == false && showAstreik == true
                            ? CommonText(
                                text: ' *',
                                style: AppTypography.caption.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.failure,
                                    fontSize: 12.sp),
                              )
                            : const SizedBox.shrink(),
                      ],
                    ),
                  )
                : Container(),
          )
        ],
      ),
    );
  }
}
