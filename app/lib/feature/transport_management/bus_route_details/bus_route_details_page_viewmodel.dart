import 'package:app/errors/flutter_toast_error_presenter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_errors/flutter_errors.dart';
import 'package:statemanagement_riverpod/statemanagement_riverpod.dart';

class BusRouteDetailsPageViewModel extends BasePageViewModel {
  final FlutterExceptionHandlerBinder exceptionHandlerBinder;
  final FlutterToastErrorPresenter flutterToastErrorPresenter;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  BusRouteDetailsPageViewModel(
      {required this.exceptionHandlerBinder,
      required this.flutterToastErrorPresenter});
}
