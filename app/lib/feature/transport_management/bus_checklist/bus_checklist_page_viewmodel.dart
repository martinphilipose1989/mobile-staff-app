import 'package:app/errors/flutter_toast_error_presenter.dart';
import 'package:app/model/resource.dart';
import 'package:app/utils/api_response_handler.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_errors/flutter_errors.dart';
import 'package:rxdart/subjects.dart';
import 'package:statemanagement_riverpod/statemanagement_riverpod.dart';

class BusChecklistPageViewModel extends BasePageViewModel {
  final FlutterExceptionHandlerBinder exceptionHandlerBinder;
  final FlutterToastErrorPresenter flutterToastErrorPresenter;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GetAllChecklistUsecase getAllChecklistUsecase;
  final GetChecklistConfirmationUsecase getChecklistConfirmationUsecase;

  BusChecklistPageViewModel(
      {required this.exceptionHandlerBinder,
      required this.flutterToastErrorPresenter,
      required this.getAllChecklistUsecase,
      required this.getChecklistConfirmationUsecase});

  TripResult? trip;
  final _loadingSubject = BehaviorSubject<bool>.seeded(false);
  final _pageSubject = BehaviorSubject<int>.seeded(1);
  final _checkListSubject =
      BehaviorSubject<Resource<List<CheckListDatum>>>.seeded(Resource.none());
  final _getConfirmationSubject =
      BehaviorSubject<Resource<GetChecklistConfirmationData>>.seeded(
          Resource.none());

  final hasMorePagesSubject = BehaviorSubject<bool>.seeded(true);

  Stream<bool> get loadingStream => _loadingSubject.stream;
  Stream<bool> get hasMorePagesStream => hasMorePagesSubject.stream;
  Stream<Resource<List<CheckListDatum>>> get checkListStream =>
      _checkListSubject.stream;
  Stream<Resource<GetChecklistConfirmationData>> get getConfirmationStream =>
      _getConfirmationSubject.stream;

  int? selectedIndex;

  void getBusCheckList() {
    _loadingSubject.add(true);
    if (_pageSubject.value == 1) {
      _checkListSubject.add(Resource.loading(data: null));
    }

    final GetAllChecklistParams params = GetAllChecklistParams(
        userId: 1,
        routeId: int.parse(trip?.id ?? ''),
        busId: int.parse(trip?.routeBusUserMapping?[0].bus?.id ?? ''));

    ApiResponseHandler.apiCallHandler(
      exceptionHandlerBinder: exceptionHandlerBinder,
      flutterToastErrorPresenter: flutterToastErrorPresenter,
      params: params,
      createCall: (params) => getAllChecklistUsecase.execute(params: params),
      onSuccess: (result) {
        _checkListSubject.add(Resource.success(data: result?.data));
        _loadingSubject.add(false);
      },
      onError: (error) {
        _checkListSubject.add(Resource.error(data: null, error: error));
        _loadingSubject.add(false);
      },
    );
  }

  String getRole(String value) {
    switch (value) {
      case "1":
        return "didi";
      case "2":
        return "driver";
      case "3":
        return "teacher";
      default:
        return "unknown";
    }
  }

  void getChecklistConfirmation(
      String userType, List<CheckListDatum> checkListdata, int index) {
    final GetChecklistConfirmationParams params =
        GetChecklistConfirmationParams(
            userId: 1, routeId: int.parse(trip?.id ?? ''), userType: 1);
    _getConfirmationSubject.add(Resource.loading(data: null));
    ApiResponseHandler.apiCallHandler(
      exceptionHandlerBinder: exceptionHandlerBinder,
      flutterToastErrorPresenter: flutterToastErrorPresenter,
      params: params,
      createCall: (params) =>
          getChecklistConfirmationUsecase.execute(params: params),
      onSuccess: (result) {
        _getConfirmationSubject.add(Resource.success(data: result?.data));
        checkListdata[index].isVerified = true;
        _checkListSubject.add(Resource.success(data: checkListdata));
      },
      onError: (error) {
        _getConfirmationSubject.add(Resource.error(data: null, error: error));
      },
    );
  }

  Future<void> refreshMyDutyList() async {
    _pageSubject.add(1);
    _checkListSubject.add(Resource.success(data: []));
    hasMorePagesSubject.add(true);
    _loadingSubject.add(false);
    getBusCheckList();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _loadingSubject.close();
    _pageSubject.close();
    hasMorePagesSubject.close();
    _checkListSubject.close();
    super.dispose();
  }
}
