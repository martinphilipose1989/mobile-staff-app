import 'dart:developer';

import 'package:app/utils/request_manager.dart';
import 'package:domain/domain.dart';
import 'package:flutter_errors/flutter_errors.dart';
import 'package:statemanagement_riverpod/statemanagement_riverpod.dart';

class VisitorDetailsViewModel extends BasePageViewModel {
 
 final FlutterExceptionHandlerBinder _exceptionHandlerBinder;
  final GetVisitorDetailsUsecase _getVisitorDetailsUsecase;
  
  VisitorDetailsViewModel(
       {required FlutterExceptionHandlerBinder exceptionHandlerBinder,
      required GetVisitorDetailsUsecase getVisitorListUsecase})
      : _exceptionHandlerBinder = exceptionHandlerBinder,
        _getVisitorDetailsUsecase = getVisitorListUsecase;


   void getVisitorDetails() {
    _exceptionHandlerBinder.handle(block: () {
      GetVisitorDetailsUsecaseParams params =
          GetVisitorDetailsUsecaseParams(gatepassId: '66bb40ea50657b25e39fd1f9');
      RequestManager<VisitorDetailsResponseModel>(
        params,
        createCall: () => _getVisitorDetailsUsecase.execute(params: params),
      ).asFlow().listen((result) {
        log("getVisitorDetails $result");
      }).onError((error) {
        log("getVisitorDetails $error");
      });
    }).execute();
  }
}
