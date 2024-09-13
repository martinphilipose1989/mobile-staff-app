// ignore_for_file: use_key_in_widget_constructors

import 'package:app/model/resource.dart';

import 'package:app/themes_setup.dart';
import 'package:app/utils/app_typography.dart';
import 'package:app/utils/common_widgets/app_images.dart';

import 'package:app/utils/common_widgets/common_primary_elevated_button.dart';
import 'package:app/utils/stream_builder/app_stream_builder.dart';

import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:statemanagement_riverpod/statemanagement_riverpod.dart';

import 'splash_page_model.dart';

class SplashPageView extends BasePageViewWidget<SplashViewModel> {
  SplashPageView(super.model);

  @override
  Widget build(BuildContext context, model) {
    return Container(
      width: double.maxFinite,
      height: double.maxFinite,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(AppImages.splashImage), fit: BoxFit.cover)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(),
          Text("STAFF MANAGMENT",
              style: AppTypography.h4.copyWith(color: Colors.white)),
          const Spacer(),
          AppStreamBuilder<Resource<bool>>(
              initialData: Resource.none(),
              stream: model.isLoadingSubject.stream,
              onError: (error) {},
              onData: (data) {
                if (data.status == Status.error) {
                  model.toastErrorPresenter.show(
                      data.dealSafeAppError!.throwable,
                      context,
                      "${data.dealSafeAppError?.error.message}");
                }
              },
              onDone: () {},
              dataBuilder: (context, data) {
                return CommonPrimaryElevatedButton(
                    isLoading: data?.status == Status.loading,
                    backgroundColor: Colors.white,
                    foregroundColor: AppColors.primary,
                    onPressed: () async {
                      model.login();
                    },
                    title: 'Lets Get Started',
                    titleTextStyle: AppTypography.subtitle2);
              }),
          SizedBox(height: 16.h)
        ],
      ),
    );
  }
}
