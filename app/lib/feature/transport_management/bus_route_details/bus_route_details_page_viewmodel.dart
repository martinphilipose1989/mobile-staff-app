import 'package:app/errors/flutter_toast_error_presenter.dart';
import 'package:app/model/resource.dart';
import 'package:app/utils/api_response_handler.dart';
import 'package:app/utils/dateformate.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_errors/flutter_errors.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';
import 'package:statemanagement_riverpod/statemanagement_riverpod.dart';

class BusRouteDetailsPageViewModel extends BasePageViewModel {
  final FlutterExceptionHandlerBinder exceptionHandlerBinder;
  final FlutterToastErrorPresenter flutterToastErrorPresenter;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GetStudentlistByRouteUsecase getStudentlistByRouteUsecase;
  final CreateAttendanceUsecase createAttendanceUsecase;
  final GetGuardianlistUsecase getGuardianlistUsecase;
  final GetStudentProfileUsecase getStudentProfileUsecase;
  final CreateStopsLogsUsecase createStopsLogsUsecase;

  final _studentListSubject =
      BehaviorSubject<Resource<List<Student>>>.seeded(Resource.none());

  Stream<Resource<List<Student>>> get studentListStream =>
      _studentListSubject.stream;

  // Guardian List
  final _guardianListSubject =
      BehaviorSubject<Resource<List<GuardiansDetail>>>.seeded(Resource.none());

  Stream<Resource<List<GuardiansDetail>>> get guardianListStream =>
      _guardianListSubject.stream;

  final _createRouteLogSubject =
      BehaviorSubject<Resource<CreateStopLogsData>>.seeded(Resource.none());

  Stream<Resource<CreateStopLogsData>> get createRouteLogstream =>
      _createRouteLogSubject.stream;

  TripResult? trip;
  StopModel? stop;

  BusRouteDetailsPageViewModel(
      {required this.getGuardianlistUsecase,
      required this.getStudentProfileUsecase,
      required this.exceptionHandlerBinder,
      required this.flutterToastErrorPresenter,
      required this.getStudentlistByRouteUsecase,
      required this.createAttendanceUsecase,
      required this.createStopsLogsUsecase});

  void getRouteStudentList({required int routeId, required int stopId}) {
    _studentListSubject.add(Resource.loading(data: null));
    final GetStudentlistByRouteUsecaseParams params =
        GetStudentlistByRouteUsecaseParams(routeId: routeId, stopId: stopId);
    ApiResponseHandler.apiCallHandler(
        exceptionHandlerBinder: exceptionHandlerBinder,
        flutterToastErrorPresenter: flutterToastErrorPresenter,
        params: params,
        createCall: (params) =>
            getStudentlistByRouteUsecase.execute(params: params),
        onSuccess: (data) {
          _studentListSubject.add(Resource.success(data: data?.data));
        },
        onError: (error) {
          _studentListSubject.add(Resource.error(data: null, error: error));
        });
  }

  void createAttendance({required Student student, required String remark}) {
    final CreateAttendanceUsecaseParams params = CreateAttendanceUsecaseParams(
      createAttendance: CreateAttendance(
          attendanceDate: DateTime.now().dateFormatToyyyMMdd(),
          attendanceDetails: [
            AttendanceDetail(
                attendanceRemark: remark, globalStudentId: student.studentId)
          ],
          boardId: student.studentDetails?.crtBoardId,
          brandId: student.studentDetails?.crtBrandId,
          gradeId: student.studentDetails?.crtGradeId,
          shiftId: student.studentDetails?.crtShiftId,
          schoolId: student.studentDetails?.crtSchoolId),
    );
    ApiResponseHandler.apiCallHandler(
      exceptionHandlerBinder: exceptionHandlerBinder,
      flutterToastErrorPresenter: flutterToastErrorPresenter,
      params: params,
      createCall: (params) => createAttendanceUsecase.execute(params: params),
      onSuccess: (data) {
        getRouteStudentList(routeId: 1, stopId: 1);
      },
      onError: (error) {},
    );
  }

  void getGuardianList({required int studentId}) {
    _guardianListSubject.add(Resource.loading(data: null));
    final GetGuardianlistUsecaseParams params =
        GetGuardianlistUsecaseParams(studentId: studentId);
    ApiResponseHandler.apiCallHandler<GetGuardianlistUsecaseParams,
        GetGuardianListResponse, NetworkError>(
      exceptionHandlerBinder: exceptionHandlerBinder,
      flutterToastErrorPresenter: flutterToastErrorPresenter,
      params: params,
      createCall: (params) => getGuardianlistUsecase.execute(params: params),
      onSuccess: (result) {
        _guardianListSubject.add(Resource.success(data: result?.data));
      },
      onError: (error) {
        _guardianListSubject.add(Resource.error(error: error));
      },
    );
  }

  void createStopLog(int stopId) {
    _createRouteLogSubject.add(Resource.loading(data: null));
    final CreateStopsLogsParams params = CreateStopsLogsParams(
        routeId: int.parse(trip?.id ?? ''),
        stopId: stopId,
        stopStatus: 'At Stop',
        time: DateFormat.jm().format(DateTime.now()));
    ApiResponseHandler.apiCallHandler<CreateStopsLogsParams,
        CreateStopLogsModel, NetworkError>(
      exceptionHandlerBinder: exceptionHandlerBinder,
      flutterToastErrorPresenter: flutterToastErrorPresenter,
      params: params,
      createCall: (params) => createStopsLogsUsecase.execute(params: params),
      onSuccess: (result) {
        _createRouteLogSubject.add(Resource.success(data: result?.data));
      },
      onError: (error) {
        _createRouteLogSubject.add(Resource.error(error: error));
      },
    );
  }
}
