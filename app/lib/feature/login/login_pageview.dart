import 'package:app/feature/login/login_viewmodel.dart';
import 'package:app/themes_setup.dart';
import 'package:app/utils/app_typography.dart';
import 'package:app/utils/common_widgets/app_images.dart';
import 'package:app/utils/common_widgets/common_primary_elevated_button.dart';
import 'package:app/utils/common_widgets/common_sizedbox.dart';
import 'package:app/utils/common_widgets/common_text_widget.dart';
import 'package:app/utils/common_widgets/common_textformfield_widget.dart';
import 'package:app/utils/stream_builder/app_stream_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:statemanagement_riverpod/statemanagement_riverpod.dart';

class LoginPageView extends BasePageViewWidget<LoginPageViewModel> {
  // ignore: use_super_parameters
  LoginPageView(ProviderBase<LoginPageViewModel> model) : super(model);

  @override
  Widget build(BuildContext context, LoginPageViewModel model) {
    return SingleChildScrollView(
      child: SizedBox(
        height: 1.sh,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox.shrink(),
            SvgPicture.asset(AppImages.appLogoBlue),
            SvgPicture.asset(AppImages.otpCenterImage),
            Container(
              padding: REdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      blurRadius: 2,
                      spreadRadius: 2,
                      color: AppColors.disableNeutral80)
                ],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonText(
                      text: 'Login into your account',
                      style: AppTypography.subtitle1,
                    ),
                    CommonSizedBox.sizedBox(height: 16, width: 10),
                    CommonText(
                        text:
                            'Welcome! please enter your credentials to Continue Your Journey',
                        style: AppTypography.caption),
                    CommonSizedBox.sizedBox(height: 16, width: 10),
                    CommonTextFormField(
                      showAstreik: true,
                      labelText: "Enter Email ID",
                      controller: model.emailController,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    CommonTextFormField(
                      showAstreik: true,
                      controller: model.passwordController,
                      labelText: "Enter Password",
                      keyboardType: TextInputType.text,
                      obscureText: false,
                    ),
                    CommonSizedBox.sizedBox(height: 10, width: 10),
                    Align(
                      alignment: Alignment.center,
                      child: CommonText(
                          textAlign: TextAlign.left,
                          style: AppTypography.caption,
                          text:
                              'By Authenticating You Agree To Terms & Conditions Of This Platform'),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: AppStreamBuilder<bool>(
                          stream: model.loadingStream,
                          initialData: false,
                          dataBuilder: (context, data) {
                            return CommonPrimaryElevatedButton(
                              isLoading: data ?? false,
                              title: "Login",
                              onPressed: () {
                                //  model.login();
                              },
                              titleTextStyle: AppTypography.subtitle2.copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onPrimaryContainer),
                              backgroundColor:
                                  Theme.of(context).colorScheme.primary,
                              foregroundColor:
                                  Theme.of(context).colorScheme.onPrimary,
                            );
                          }),
                    )
                  ]),
            )
          ],
        ),
      ),
    );
  }
}
