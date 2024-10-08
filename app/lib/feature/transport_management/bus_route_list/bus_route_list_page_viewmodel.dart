import 'package:app/errors/flutter_toast_error_presenter.dart';
import 'package:app/model/resource.dart';
import 'package:app/utils/api_response_handler.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_errors/flutter_errors.dart';
import 'package:rxdart/subjects.dart';
import 'package:statemanagement_riverpod/statemanagement_riverpod.dart';

class BusRouteListPageViewModel extends BasePageViewModel {
  final FlutterExceptionHandlerBinder exceptionHandlerBinder;
  final FlutterToastErrorPresenter flutterToastErrorPresenter;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GetAllBusStopsUsecase getAllBusStopsUsecase;

  BusRouteListPageViewModel(
      {required this.exceptionHandlerBinder,
      required this.flutterToastErrorPresenter,
      required this.getAllBusStopsUsecase}) {
    getBusStopsList();
  }
  TripResult? trip;

  final _loadingSubject = BehaviorSubject<bool>.seeded(false);
  final _pageSubject = BehaviorSubject<int>.seeded(1);
  final _busStopsListSubject =
      BehaviorSubject<Resource<List<RouteStopMappingModel>>>.seeded(
          Resource.none());

  final hasMorePagesSubject = BehaviorSubject<bool>.seeded(true);

  Stream<bool> get loadingStream => _loadingSubject.stream;
  Stream<bool> get hasMorePagesStream => hasMorePagesSubject.stream;
  Stream<Resource<List<RouteStopMappingModel>>> get busStopsListStream =>
      _busStopsListSubject.stream;

  void getBusStopsList() {
    _loadingSubject.add(true);
    if (_pageSubject.value == 1) {
      _busStopsListSubject.add(Resource.loading(data: null));
    }

    final GetAllBusStopsParams params = GetAllBusStopsParams(
        routeId: trip?.id ?? '', dayId: DateTime.now().weekday);

    ApiResponseHandler.apiCallHandler(
      exceptionHandlerBinder: exceptionHandlerBinder,
      flutterToastErrorPresenter: flutterToastErrorPresenter,
      params: params,
      createCall: (params) => getAllBusStopsUsecase.execute(params: params),
      onSuccess: (result) {
        _busStopsListSubject.add(
            Resource.success(data: result?.data?.results?.routeStopMapping));
        _loadingSubject.add(false);
      },
      onError: (error) {
        _busStopsListSubject.add(Resource.error(data: null, error: error));
        _loadingSubject.add(false);
      },
    );
  }

  String convertTo12HourFormat(String time) {
    // Split the input string to extract hours, minutes, and seconds
    List<String> timeParts = time.split(':');
    int hour = int.parse(timeParts[0]);
    int minute = int.parse(timeParts[1]);

    // Determine if it's AM or PM
    String period = hour >= 12 ? 'PM' : 'AM';

    // Convert hour to 12-hour format
    int hourIn12HourFormat = hour % 12 == 0 ? 12 : hour % 12;

    // Format the time as required (without seconds)
    return "$hourIn12HourFormat:${minute.toString().padLeft(2, '0')} $period";
  }

  Future<void> refreshMyDutyList() async {
    _pageSubject.add(1);
    _busStopsListSubject.add(Resource.success(data: []));
    hasMorePagesSubject.add(true);
    _loadingSubject.add(false);
    getBusStopsList();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _loadingSubject.close();
    _pageSubject.close();
    hasMorePagesSubject.close();
    _busStopsListSubject.close();
    super.dispose();
  }
}
