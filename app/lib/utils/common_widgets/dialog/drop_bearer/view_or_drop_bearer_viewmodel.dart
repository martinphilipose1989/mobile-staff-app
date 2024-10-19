import 'dart:developer';

import 'package:app/errors/flutter_toast_error_presenter.dart';
import 'package:app/model/resource.dart';
import 'package:app/utils/api_response_handler.dart';
import 'package:app/utils/dateformate.dart';
import 'package:app/utils/enum/attendance_type_enum.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_errors/flutter_errors.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

import 'package:statemanagement_riverpod/statemanagement_riverpod.dart';

class ViewOrDropBearerViewmodel extends BasePageViewModel {
  final FlutterToastErrorPresenter flutterToastErrorPresenter;
  final FlutterExceptionHandlerBinder exceptionHandlerBinder;
  final GetBearerListUsecase getBearerListUsecase;
  final CreateAttendanceUsecase createAttendanceUsecase;
  final BehaviorSubject<Resource<CreateAttendanceResponse>>
      createAttendanceResponse = BehaviorSubject.seeded(Resource.none());

  final BehaviorSubject<Resource<List<BearerResponse>>> bearerResponse =
      BehaviorSubject.seeded(Resource.none());

  PageController pageController = PageController();

  BehaviorSubject<int> selectIndex = BehaviorSubject.seeded(0);

  final UpdateAttendanceUsecase updateAttendanceUsecase;

  ViewOrDropBearerViewmodel(
      {required this.flutterToastErrorPresenter,
      required this.exceptionHandlerBinder,
      required this.getBearerListUsecase,
      required this.createAttendanceUsecase,
      required this.updateAttendanceUsecase});

  void getBearerList({required int studentId}) {
    bearerResponse.add(Resource.loading());
    final GetBearerListUsecaseParams params =
        GetBearerListUsecaseParams(studentId: studentId);

    ApiResponseHandler.apiCallHandler(
      exceptionHandlerBinder: exceptionHandlerBinder,
      flutterToastErrorPresenter: flutterToastErrorPresenter,
      params: params,
      createCall: (params) => getBearerListUsecase.execute(params: params),
      onSuccess: (result) {
        log("GET BEARER LIST ${result?.data?.first.firstName}");
        bearerResponse.add(Resource.success(data: result?.data));
      },
      onError: (error) {
        bearerResponse.add(Resource.error(error: error));
      },
    );
  }

  void createAttendance({required Student student}) {
    createAttendanceResponse.add(Resource.loading());

    final CreateAttendanceUsecaseParams params = CreateAttendanceUsecaseParams(
      createAttendance: CreateAttendance(
          attendanceDate: DateTime.now().dateFormatToyyyMMdd(),
          attendanceDetails: [
            AttendanceDetail(
                attendanceType: AttendanceTypeEnum.drop.value,
                globalStudentId: student.studentId)
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
        createAttendanceResponse.add(Resource.success(data: data));
      },
      onError: (error) {
        createAttendanceResponse.add(Resource.error());
      },
    );
  }

  void updateAttendance(
      {required String attendanceRemark,
      required AttendanceTypeEnum attendanceType,
      required int studentId}) {
    createAttendanceResponse.add(Resource.loading());
    UpdateAttendanceUsecaseParams params = UpdateAttendanceUsecaseParams(
      request: UpdateAttendanceRequest(
        attendanceUpdates: [
          AttendanceUpdate(
            attendanceDate: [DateTime.now().dateFormatToyyyMMdd()],
            attendanceRemark: attendanceRemark,
            attendanceType: attendanceType.value,
            studentId: [studentId],
          ),
        ],
      ),
    );

    ApiResponseHandler.apiCallHandler(
      exceptionHandlerBinder: exceptionHandlerBinder,
      flutterToastErrorPresenter: flutterToastErrorPresenter,
      params: params,
      createCall: (params) => updateAttendanceUsecase.execute(params: params),
      onSuccess: (result) {
        createAttendanceResponse.add(Resource.success());
      },
      onError: (error) {
        createAttendanceResponse.add(Resource.error(error: error));
      },
    );
  }
}
