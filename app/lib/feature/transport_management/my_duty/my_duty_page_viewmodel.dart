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
  final CreateRouteLogsUsecase createRouteLogsUsecase;

  final BehaviorSubject<String> selectedTripStatus =
      BehaviorSubject.seeded("up coming trips");

  final tripStatusType = [
    const ToggleOption<String>(
        value: "up coming trips", text: "Upcoming Trips"),
    const ToggleOption<String>(
        value: "completed trips", text: "Completed Trips")
  ];

  // GET MY DUTY
  final _loadingSubject = BehaviorSubject<bool>.seeded(false);
  final _pageSubject = BehaviorSubject<int>.seeded(1);
  final hasMorePagesSubject = BehaviorSubject<bool>.seeded(true);
  final _tripListSubject =
      BehaviorSubject<Resource<List<TripResult>>>.seeded(Resource.none());
  final _createRouteLogsSubject =
      BehaviorSubject<Resource<CreateRouteLogsData>>.seeded(Resource.none());
  Stream<Resource<CreateRouteLogsData>> get createRouteLogsStream =>
      _createRouteLogsSubject.stream;

  Stream<bool> get loadingStream => _loadingSubject.stream;
  Stream<bool> get hasMorePagesStream => hasMorePagesSubject.stream;
  Stream<Resource<List<TripResult>>> get tripListStream =>
      _tripListSubject.stream;

  final throttleDuration = const Duration(milliseconds: 300);

  MyDutyPageViewModel(
      {required this.exceptionHandlerBinder,
      required this.flutterToastErrorPresenter,
      required this.getMydutyListUsecase,
      required this.createRouteLogsUsecase}) {
    getMyDutyList();
  }

  void getMyDutyList() {
    _loadingSubject.add(true);
    if (_pageSubject.value == 1) {
      _tripListSubject.add(Resource.loading(data: null));
    }

    final GetMydutyListParams params = GetMydutyListParams(
        pageNo: _pageSubject.value, dayId: DateTime.now().weekday);

    ApiResponseHandler.apiCallHandler(
      exceptionHandlerBinder: exceptionHandlerBinder,
      flutterToastErrorPresenter: flutterToastErrorPresenter,
      params: params,
      createCall: (params) => getMydutyListUsecase.execute(params: params),
      onSuccess: (result) {
        if (!_tripListSubject.isClosed) {
          List<TripResult>? tripResult = [];

          for (var i = 0; i < (result?.data?.tripResult?.length ?? 0); i++) {
            if (selectedTripStatus.value == 'up coming trips') {
              if (result?.data?.tripResult?[i].isCompletedTrip == false) {
                tripResult.add(result!.data!.tripResult![i]);
              }
            } else {
              if (result?.data?.tripResult?[i].isCompletedTrip == true) {
                tripResult.add(result!.data!.tripResult![i]);
              }
            }
          }
          _tripListSubject.add(Resource.success(data: tripResult));
          _loadingSubject.add(false);
        }
      },
      onError: (error) {
        _tripListSubject.add(Resource.error(data: null, error: error));
        _loadingSubject.add(false);
      },
    );
  }

  void createRouteLogs(int routeId) {
    final CreateRouteLogsParams params = CreateRouteLogsParams(
        didId: null,
        driverId: 1,
        endDate: DateTime.now().toIso8601String(),
        startDate: DateTime.now().toIso8601String(),
        routeId: routeId,
        userType: 1,
        routeStatus: "Inprocess",
        teacherId: null);
    ApiResponseHandler.apiCallHandler(
      exceptionHandlerBinder: exceptionHandlerBinder,
      flutterToastErrorPresenter: flutterToastErrorPresenter,
      params: params,
      createCall: (params) => createRouteLogsUsecase.execute(params: params),
      onSuccess: (result) {
        _createRouteLogsSubject.add(Resource.success(data: result?.data));
      },
      onError: (error) {
        _createRouteLogsSubject.add(Resource.error(data: null, error: error));
      },
    );
  }

  void startRouteCall(TripResult tripResult) {
    List<TripResult> a = _tripListSubject.value.data ?? [];
    for (var value in a) {
      if (value.id == tripResult.id) {
        value.isLoading = true;
      }
    }
    _tripListSubject.add(Resource.success(data: a));
    createRouteLogs(int.parse(tripResult.id ?? ''));
  }

  void stopLoader(TripResult tripResult) {
    List<TripResult> a = _tripListSubject.value.data ?? [];
    for (var value in a) {
      if (value.id == tripResult.id) {
        value.isLoading = false;
      }
    }
    _tripListSubject.add(Resource.success(data: a));
  }

  Future<void> refreshMyDutyList() async {
    _pageSubject.add(1);
    _tripListSubject.add(Resource.success(data: []));
    _createRouteLogsSubject.add(Resource.success());
    hasMorePagesSubject.add(true);
    _loadingSubject.add(false);
    getMyDutyList();
  }

  @override
  void dispose() {
    selectedTripStatus.close();
    _loadingSubject.close();
    _pageSubject.close();
    _createRouteLogsSubject.close();
    hasMorePagesSubject.close();
    _tripListSubject.close();
    super.dispose();
  }
}
