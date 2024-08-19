import 'dart:developer';

import 'package:app/model/resource.dart';
import 'package:app/utils/request_manager.dart';
import 'package:domain/domain.dart';
import 'package:flutter_errors/flutter_errors.dart';
import 'package:rxdart/rxdart.dart';
import 'package:statemanagement_riverpod/statemanagement_riverpod.dart';

class VisitorDetailsViewModel extends BasePageViewModel {
  final FlutterExceptionHandlerBinder _exceptionHandlerBinder;
  final GetVisitorDetailsUsecase _getVisitorDetailsUsecase;

  final PublishSubject<Resource<VisitorDataModel>> _visitorDetailsResponse =
      PublishSubject();

  Stream<Resource<VisitorDataModel>> get visitorDetails =>
      _visitorDetailsResponse.stream;

  final _loadingSubject = BehaviorSubject<bool>.seeded(false);

  VisitorDetailsViewModel(
      {required FlutterExceptionHandlerBinder exceptionHandlerBinder,
      required GetVisitorDetailsUsecase getVisitorDetailsUsecase})
      : _exceptionHandlerBinder = exceptionHandlerBinder,
        _getVisitorDetailsUsecase = getVisitorDetailsUsecase;

  void getVisitorDetails({required gatePassId}) {
    if (_loadingSubject.value) return;

    _loadingSubject.add(true);

    _exceptionHandlerBinder.handle(block: () {
      GetVisitorDetailsUsecaseParams params =
          GetVisitorDetailsUsecaseParams(gatepassId: gatePassId);
      RequestManager<VisitorDetailsResponseModel>(
        params,
        createCall: () => _getVisitorDetailsUsecase.execute(params: params),
      ).asFlow().listen((result) {
        if (Status.success == result.status) {
          _visitorDetailsResponse.add(
            Resource.success(
              data: result.data?.data,
            ),
          );
          log("getVisitorDetails $result");
        }
      }).onError((error) {
        log("getVisitorDetails $error");
      });
    }).execute();
  }
}
