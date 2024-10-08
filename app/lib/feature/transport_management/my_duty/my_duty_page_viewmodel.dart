// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app/errors/flutter_toast_error_presenter.dart';
import 'package:app/model/resource.dart';
import 'package:app/utils/api_response_handler.dart';
import 'package:app/utils/common_widgets/toggle_option_list.dart';

import 'package:domain/domain.dart';
import 'package:flutter_errors/flutter_errors.dart';
import 'package:rxdart/subjects.dart';
import 'package:statemanagement_riverpod/statemanagement_riverpod.dart';

class MyDutyPageViewModel extends BasePageViewModel {
  final FlutterExceptionHandlerBinder exceptionHandlerBinder;
  final FlutterToastErrorPresenter flutterToastErrorPresenter;
  final GetMydutyListUsecase getMydutyListUsecase;

  final BehaviorSubject<String> selectedTripStatus = BehaviorSubject.seeded("");

  final tripStatusType = [
    const ToggleOption<String>(
        value: "up coming trips", text: "Upcoming Trips"),
    const ToggleOption<String>(
        value: "completed trips", text: "Incompleted Trips")
  ];

  // GET MY DUTY
  final _loadingSubject = BehaviorSubject<bool>.seeded(false);
  final _pageSubject = BehaviorSubject<int>.seeded(1);
  final hasMorePagesSubject = BehaviorSubject<bool>.seeded(true);
  final _tripListSubject =
      BehaviorSubject<Resource<List<TripResult>>>.seeded(Resource.none());

  Stream<bool> get loadingStream => _loadingSubject.stream;
  Stream<bool> get hasMorePagesStream => hasMorePagesSubject.stream;
  Stream<Resource<List<TripResult>>> get tripListStream =>
      _tripListSubject.stream;

  final throttleDuration = const Duration(milliseconds: 300);

  MyDutyPageViewModel(
      {required this.exceptionHandlerBinder,
      required this.flutterToastErrorPresenter,
      required this.getMydutyListUsecase}) {
    getMyDutyList();
  }

  void getMyDutyList() {
    _loadingSubject.add(true);
    if (_pageSubject.value == 1) {
      _tripListSubject.add(Resource.loading(data: null));
    }

    final GetMydutyListParams params =
        GetMydutyListParams(pageNo: _pageSubject.value);

    ApiResponseHandler.apiCallHandler(
      exceptionHandlerBinder: exceptionHandlerBinder,
      flutterToastErrorPresenter: flutterToastErrorPresenter,
      params: params,
      createCall: (params) => getMydutyListUsecase.execute(params: params),
      onSuccess: (result) {
        _tripListSubject.add(Resource.success(data: result?.data?.tripResult));
        _loadingSubject.add(false);
      },
      onError: (error) {
        _tripListSubject.add(Resource.error(data: null, error: error));
        _loadingSubject.add(false);
      },
    );
  }

  Future<void> refreshMyDutyList() async {
    _pageSubject.add(1);
    _tripListSubject.add(Resource.success(data: []));
    hasMorePagesSubject.add(true);
    _loadingSubject.add(false);
    getMyDutyList();
  }

  @override
  void dispose() {
    selectedTripStatus.close();
    _loadingSubject.close();
    _pageSubject.close();
    hasMorePagesSubject.close();
    _tripListSubject.close();
    super.dispose();
  }
}
