// ignore_for_file: unused_field

import 'package:app/errors/flutter_toast_error_presenter.dart';

import 'package:flutter/material.dart';
import 'package:flutter_errors/flutter_errors.dart';
import 'package:rxdart/rxdart.dart';
import 'package:statemanagement_riverpod/statemanagement_riverpod.dart';

class LoginPageViewModel extends BasePageViewModel {
  final FlutterExceptionHandlerBinder exceptionHandlerBinder;

  final FlutterToastErrorPresenter _flutterToastErrorPresenter;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final BehaviorSubject<bool> _loadingSubject = BehaviorSubject.seeded(false);

  Stream<bool> get loadingStream => _loadingSubject.stream;

  LoginPageViewModel({
    required this.exceptionHandlerBinder,
    required FlutterToastErrorPresenter flutterToastErrorPresenter,
  }) : _flutterToastErrorPresenter = flutterToastErrorPresenter;
}
