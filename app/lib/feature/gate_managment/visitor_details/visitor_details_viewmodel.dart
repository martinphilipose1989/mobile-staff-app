import 'dart:developer';

import 'package:app/utils/request_manager.dart';
import 'package:domain/domain.dart';
import 'package:flutter_errors/flutter_errors.dart';
import 'package:rxdart/rxdart.dart';
import 'package:statemanagement_riverpod/statemanagement_riverpod.dart';

class VisitorDetailsViewModel extends BasePageViewModel {
  final FlutterExceptionHandlerBinder _exceptionHandlerBinder;
  final GetVisitorDetailsUsecase _getVisitorDetailsUsecase;

  BehaviorSubject<VisitorDataModel>? visitorDetails =
      BehaviorSubject<VisitorDataModel>.seeded(VisitorDataModel());

  VisitorDetailsViewModel(
      {required FlutterExceptionHandlerBinder exceptionHandlerBinder,
      required GetVisitorDetailsUsecase getVisitorDetailsUsecase})
      : _exceptionHandlerBinder = exceptionHandlerBinder,
        _getVisitorDetailsUsecase = getVisitorDetailsUsecase;

  void getVisitorDetails({required gatePassId}) {
    _exceptionHandlerBinder.handle(block: () {
      GetVisitorDetailsUsecaseParams params =
          GetVisitorDetailsUsecaseParams(gatepassId: gatePassId);
      RequestManager<VisitorDetailsResponseModel>(
        params,
        createCall: () => _getVisitorDetailsUsecase.execute(params: params),
      ).asFlow().listen((result) {
        visitorDetails?.add(result.data?.data ?? VisitorDataModel());
        log("getVisitorDetails $result");
      }).onError((error) {
        log("getVisitorDetails $error");
      });
    }).execute();
  }
}
