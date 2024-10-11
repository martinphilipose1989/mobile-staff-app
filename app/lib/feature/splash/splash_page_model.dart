import 'dart:async';

import 'package:app/errors/flutter_toast_error_presenter.dart';

import 'package:app/model/resource.dart';

import 'package:app/utils/request_manager.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_errors/flutter_errors.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:statemanagement_riverpod/statemanagement_riverpod.dart';

@injectable
class SplashViewModel extends BasePageViewModel {
  final String myBaseUrl;
  final StreamController<bool> _navigateToDashboardController =
      StreamController();
  final FlutterExceptionHandlerBinder exceptionHandlerBinder;
  final FlutterToastErrorPresenter toastErrorPresenter;
  late Timer future;

  final AuthUsecase authUsecase;

  SplashViewModel(
    @factoryParam this.myBaseUrl,
    this.exceptionHandlerBinder,
    this.authUsecase,
    this.toastErrorPresenter,
  ) {
    future = Timer(const Duration(seconds: 2), () async {
      _navigateToDashboardController.sink.add(true);
      _navigateToDashboardController.close();
    });
  }

  Stream<bool> navigateToDashboard() => _navigateToDashboardController.stream;

  BehaviorSubject<Resource<bool>> isLoadingSubject =
      BehaviorSubject.seeded(Resource.none());

  void login() {
    isLoadingSubject.add(Resource.loading());
    final AuthUsecaseParams params = AuthUsecaseParams();
    exceptionHandlerBinder.handle(block: () {
      RequestManager(params,
              createCall: () => authUsecase.execute(params: params))
          .asFlow()
          .listen((data) {
        if (data.status == Status.success) {
          // Navigator.of(navigatorKey.currentContext!)
          //     .pushReplacementNamed(RoutePaths.dashboard);
        } else if (data.status == Status.error) {
          isLoadingSubject.add(Resource.none());
        }
      }).onError((error) {
        isLoadingSubject.add(Resource.none());
      });
    }).execute();
  }

  void test() {
    exceptionHandlerBinder.handle(block: () {
      debugPrint("exceptionHandlerBinder start");
      throw const FormatException("Something is wrong");
      /* throw NetworkError(
          httpError: 1,
          message: "message Testing another error",
          cause: Exception("Testing another error"));*/
      /*var name = await Future.delayed(
        const Duration(seconds: 2),
        () => //"my name",
            throw const FormatException("sad"),
      );*/
      //print("name >> $name");
    }).execute();

/*
    exceptionHandlerBinder.handle(block: () {
      // serverRequest(); // Some dangerous code that can throw an exception
    }).finallyIt(block: () {
      // Optional finally block
      // Some code
    }).execute();
*/

    /* exceptionHandlerBinder.handle(block: () {
      // serverRequest(); // Some dangerous code that can throw an exception
    }).catchIt<FormatException>((e) {
      // Optional finally block
      // Some code
      return false;
    }).execute();*/
  }

  @override
  void dispose() {
    future.cancel();
    _navigateToDashboardController.close();
    super.dispose();
  }
}
