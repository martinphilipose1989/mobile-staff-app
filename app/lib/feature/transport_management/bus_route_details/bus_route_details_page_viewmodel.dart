import 'package:app/errors/flutter_toast_error_presenter.dart';
import 'package:app/model/resource.dart';
import 'package:app/utils/api_response_handler.dart';
import 'package:app/utils/dateformate.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_errors/flutter_errors.dart';
import 'package:rxdart/rxdart.dart';
import 'package:statemanagement_riverpod/statemanagement_riverpod.dart';

class BusRouteDetailsPageViewModel extends BasePageViewModel {
  final FlutterExceptionHandlerBinder exceptionHandlerBinder;
  final FlutterToastErrorPresenter flutterToastErrorPresenter;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GetStudentlistByRouteUsecase getStudentlistByRouteUsecase;
  final CreateAttendanceUsecase createAttendanceUsecase;

  final _studentListSubject =
      BehaviorSubject<Resource<List<Student>>>.seeded(Resource.none());

  Stream<Resource<List<Student>>> get studentListStream =>
      _studentListSubject.stream;

  BusRouteDetailsPageViewModel(
      {required this.exceptionHandlerBinder,
      required this.flutterToastErrorPresenter,
      required this.getStudentlistByRouteUsecase,
      required this.createAttendanceUsecase});

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
              attendanceRemark: remark,
            )
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
      onSuccess: (data) {},
      onError: (error) {},
    );
  }
}
