import 'dart:developer';

import 'package:app/model/resource.dart';
import 'package:app/utils/common_widgets/toggle_option_list.dart';
import 'package:app/utils/request_manager.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_errors/flutter_errors.dart';
import 'package:rxdart/rxdart.dart';
import 'package:statemanagement_riverpod/statemanagement_riverpod.dart';

class VisitorListPageViewModel extends BasePageViewModel {
  final FlutterExceptionHandlerBinder _exceptionHandlerBinder;
  final GetVisitorListUsecase _getVisitorListUsecase;
  final PublishSubject<Resource<VisitorListResponseModel>>
      _visitorListResponse = PublishSubject();

  Stream<Resource<VisitorListResponseModel>> get visitorListResponse =>
      _visitorListResponse.stream;
  final selectedStatus = BehaviorSubject<int>.seeded(-1);
  final statusTypeList = [
    const ToggleOption<int>(value: 0, text: "IN"),
    const ToggleOption<int>(value: 1, text: "OUT")
  ];

  final TextEditingController searchController = TextEditingController();

  VisitorListPageViewModel(
      {required FlutterExceptionHandlerBinder exceptionHandlerBinder,
      required GetVisitorListUsecase getVisitorListUsecase})
      : _exceptionHandlerBinder = exceptionHandlerBinder,
        _getVisitorListUsecase = getVisitorListUsecase;

  void onVisitStatusSelect({required int selectStatus}) {
    log("message");
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void getVisitorList() {
    _exceptionHandlerBinder.handle(block: () {
      GetVisitorListUsecaseParams params =
          GetVisitorListUsecaseParams(pageNumber: 1);
      RequestManager<VisitorListResponseModel>(
        params,
        createCall: () => _getVisitorListUsecase.execute(params: params),
      ).asFlow().listen((result) {
        _visitorListResponse.add(result);
      }).onError((error) {
        log("getVisitorList $error");
      });
    }).execute();
  }
}
