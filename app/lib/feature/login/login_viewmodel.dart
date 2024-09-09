import 'package:app/errors/flutter_toast_error_presenter.dart';
import 'package:app/model/resource.dart';
import 'package:app/myapp.dart';
import 'package:app/navigation/route_paths.dart';
import 'package:app/utils/request_manager.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_errors/flutter_errors.dart';
import 'package:rxdart/rxdart.dart';
import 'package:statemanagement_riverpod/statemanagement_riverpod.dart';

class LoginPageViewModel extends BasePageViewModel {
  final FlutterExceptionHandlerBinder exceptionHandlerBinder;
  final LoginUseCase _loginUseCase;
  final FlutterToastErrorPresenter _flutterToastErrorPresenter;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final BehaviorSubject<bool> _loadingSubject = BehaviorSubject.seeded(false);

  Stream<bool> get loadingStream => _loadingSubject.stream;

  LoginPageViewModel(
      {required this.exceptionHandlerBinder,
      required FlutterToastErrorPresenter flutterToastErrorPresenter,
      required LoginUseCase loginUsecase})
      : _loginUseCase = loginUsecase,
        _flutterToastErrorPresenter = flutterToastErrorPresenter;

  void login() {
    _loadingSubject.add(true);
    final LoginUseCaseParams params = LoginUseCaseParams(
        emailOrPhone: emailController.text, password: passwordController.text);

    RequestManager(params,
            createCall: () => _loginUseCase.execute(params: params))
        .asFlow()
        .listen((data) {
      if (data.status == Status.success) {
        _loadingSubject.add(false);
        navigatorKey.currentState
            ?.pushNamedAndRemoveUntil(RoutePaths.dashboard, (route) => false);
      }
      if (data.status == Status.error) {
        _loadingSubject.add(false);
        _flutterToastErrorPresenter.show(
            data.dealSafeAppError!,
            navigatorKey.currentContext!,
            "${data.dealSafeAppError?.error.message}");
      }
    }).onError((error) {
      _loadingSubject.add(false);
    });
  }
}
