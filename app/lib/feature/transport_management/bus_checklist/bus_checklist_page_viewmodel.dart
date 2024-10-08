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

  BusChecklistPageViewModel(
      {required this.exceptionHandlerBinder,
      required this.flutterToastErrorPresenter,
      required this.getAllChecklistUsecase}) {
    getBusCheckList();
  }

  TripResult? trip;
  final _loadingSubject = BehaviorSubject<bool>.seeded(false);
  final _pageSubject = BehaviorSubject<int>.seeded(1);
  final _checkListSubject =
      BehaviorSubject<Resource<List<Checklist>>>.seeded(Resource.none());

  final hasMorePagesSubject = BehaviorSubject<bool>.seeded(true);

  Stream<bool> get loadingStream => _loadingSubject.stream;
  Stream<bool> get hasMorePagesStream => hasMorePagesSubject.stream;
  Stream<Resource<List<Checklist>>> get checkListStream =>
      _checkListSubject.stream;

  void getBusCheckList() {
    _loadingSubject.add(true);
    if (_pageSubject.value == 1) {
      _checkListSubject.add(Resource.loading(data: null));
    }

    final GetAllChecklistParams params = GetAllChecklistParams(
        pageNo: _pageSubject.value, dayId: DateTime.now().weekday);

    ApiResponseHandler.apiCallHandler(
      exceptionHandlerBinder: exceptionHandlerBinder,
      flutterToastErrorPresenter: flutterToastErrorPresenter,
      params: params,
      createCall: (params) => getAllChecklistUsecase.execute(params: params),
      onSuccess: (result) {
        _checkListSubject.add(Resource.success(data: result?.data?.results));
        _loadingSubject.add(false);
      },
      onError: (error) {
        _checkListSubject.add(Resource.error(data: null, error: error));
        _loadingSubject.add(false);
      },
    );
  }

  void verifyData(List<Checklist> checkListdata, int index) {
    checkListdata[index].isVerified = true;
    _checkListSubject.add(Resource.success(data: checkListdata));
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
