import 'package:app/errors/flutter_toast_error_presenter.dart';
import 'package:app/model/resource.dart';
import 'package:app/utils/api_response_handler.dart';
import 'package:app/utils/dateformate.dart';
import 'package:app/utils/enum/attendance_type_enum.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_errors/flutter_errors.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';
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
  final CreateRouteLogsUsecase createRouteLogsUsecase;
  final UpdateAttendanceUsecase updateAttendanceUsecase;

  final _studentListSubject =
      BehaviorSubject<Resource<List<Student>>>.seeded(Resource.none());

  Stream<Resource<List<Student>>> get studentListStream =>
      _studentListSubject.stream;

  // Guardian List
  final _guardianListSubject =
      BehaviorSubject<Resource<List<GuardiansDetail>>>.seeded(Resource.none());

  Stream<Resource<List<GuardiansDetail>>> get guardianListStream =>
      _guardianListSubject.stream;

  final _createStopLogsSubgject =
      BehaviorSubject<Resource<CreateStopLogsData>>.seeded(Resource.none());

  Stream<Resource<CreateStopLogsData>> get createStopLogsSubgject =>
      _createStopLogsSubgject.stream;

  TripResult? trip;
  StopModel? stop;
  bool? isLastIndex;
  bool? dropStarted;

  final BehaviorSubject<bool> _presentLoadingSubject =
      BehaviorSubject.seeded(false);
  Stream<bool> get presentStream => _presentLoadingSubject.stream;
  final BehaviorSubject<bool> _absentLoadingSubject =
      BehaviorSubject.seeded(false);
  Stream<bool> get absentLoadingStream => _absentLoadingSubject.stream;

  // Helper methods to check if buttons should be disabled
  bool isPresentLoading() => _presentLoadingSubject.value;
  bool isAbsentLoading() => _absentLoadingSubject.value;

  BehaviorSubject<Resource<CreateAttendanceResponse>> createAttendanceResponse =
      BehaviorSubject.seeded(Resource.none());

  final _createRouteLogsSubject =
      BehaviorSubject<Resource<CreateRouteLogsData>>.seeded(Resource.none());
  Stream<Resource<CreateRouteLogsData>> get createRouteLogsStream =>
      _createRouteLogsSubject.stream;

  final pickAllLoadingSubject =
      BehaviorSubject<Resource<bool>>.seeded(Resource.none());

  Stream<Resource<bool>> get pickAllLoadingStream =>
      pickAllLoadingSubject.stream;

  BehaviorSubject<int> totalStudent = BehaviorSubject<int>.seeded(0);
  BehaviorSubject<int> presentStudent = BehaviorSubject<int>.seeded(0);
  BehaviorSubject<int> absentStudent = BehaviorSubject<int>.seeded(0);

  BusRouteDetailsPageViewModel(
      {required this.getGuardianlistUsecase,
      required this.getStudentProfileUsecase,
      required this.exceptionHandlerBinder,
      required this.flutterToastErrorPresenter,
      required this.getStudentlistByRouteUsecase,
      required this.createAttendanceUsecase,
      required this.createStopsLogsUsecase,
      required this.createRouteLogsUsecase,
      required this.updateAttendanceUsecase});

  void getRouteStudentList({required int routeId, int? stopId}) {
    _studentListSubject.add(Resource.loading(data: null));
    totalStudent.add(0);
    presentStudent.add(0);
    absentStudent.add(0);
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
          totalStudent.add(data?.data?.length ?? 0);

          data?.data?.forEach((student) {
            if (student.attendanceList?.isNotEmpty == true) {
              final remark =
                  student.attendanceList?.first.attendanceRemark?.toLowerCase();

              if (remark == "present") {
                presentStudent.value += 1;
                presentStudent.add(presentStudent.value);
              } else if (remark == "absent") {
                absentStudent.value += 1;
                absentStudent.add(absentStudent.value);
              }
            }
          });
        },
        onError: (error) {
          _studentListSubject.add(Resource.error(data: null, error: error));
        });
  }

  void createAttendance({
    required Student student,
    required String remark,
    AttendanceTypeEnum? attendanceTypeEnum,
  }) {
    if (remark.toLowerCase() == "present") {
      _presentLoadingSubject.add(true);
      _absentLoadingSubject.add(false);
    } else {
      _absentLoadingSubject.add(true);
      _presentLoadingSubject.add(false);
    }
    final CreateAttendanceUsecaseParams params = CreateAttendanceUsecaseParams(
      createAttendance: CreateAttendance(
          attendanceDate: DateTime.now().dateFormatToyyyMMdd(),
          attendanceDetails: [
            AttendanceDetail(
                attendanceType: remark.toLowerCase() == "present"
                    ? attendanceTypeEnum?.value
                    : AttendanceTypeEnum.absent.value,
                attendanceRemark: remark.toLowerCase(),
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
        _presentLoadingSubject.add(false);
        _absentLoadingSubject.add(false);
        createAttendanceResponse.add(Resource.success(data: data));

        getRouteStudentList(
            routeId: int.parse(trip?.id ?? ''), stopId: stop?.id);
      },
      onError: (error) {
        _presentLoadingSubject.add(false);
        _absentLoadingSubject.add(false);
      },
    );
  }

  void reset() {
    dropStarted = false;
    List<Student> tempList = _studentListSubject.value.data ?? [];
    _studentListSubject.add(Resource.success(data: tempList));
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
    _createStopLogsSubgject.add(Resource.loading(data: null));
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
        _createStopLogsSubgject.add(Resource.success(data: result?.data));
        _createStopLogsSubgject.add(Resource.none());
      },
      onError: (error) {
        _createStopLogsSubgject.add(Resource.error(error: error));
      },
    );
  }

  void createRouteLogs(int routeId,
      {AttendanceTypeEnum? attendanceTypeEnum,
      TripRouteStatus status = TripRouteStatus.inProcess}) {
    _createRouteLogsSubject.add(Resource.loading(data: null));
    final studentList = _studentListSubject.value.data
        ?.where((student) =>
            student.attendanceList?.isNotEmpty == true &&
            student.attendanceList?.first.attendanceRemark?.toLowerCase() ==
                "present")
        .map(
            (student) => student.studentId) // Assuming 'studentId' is the field
        .toList();
    final studentListFiltered =
        studentList?.where((id) => id != null).cast<int>().toList();

    final CreateRouteLogsParams params = CreateRouteLogsParams(
      didId: null,
      driverId: 1,
      endDate: DateTime.now().toIso8601String(),
      startDate: DateTime.now().toIso8601String(),
      routeId: routeId,
      userType: 1,
      routeStatus: status.status,
      teacherId: null,
      attendanceType: attendanceTypeEnum?.value,
      studentIdList: studentListFiltered, // Use the filtered list
    );

    if (studentList != null) {
      pickAllLoadingSubject.add(Resource.loading());
    }

    ApiResponseHandler.apiCallHandler(
      exceptionHandlerBinder: exceptionHandlerBinder,
      flutterToastErrorPresenter: flutterToastErrorPresenter,
      params: params,
      createCall: (params) => createRouteLogsUsecase.execute(params: params),
      onSuccess: (result) {
        _createRouteLogsSubject.add(Resource.success(data: result?.data));
        if (studentListFiltered != null) {
          _createRouteLogsSubject.add(Resource.none());
          pickAllLoadingSubject.add(Resource.success(data: false));
        }
      },
      onError: (error) {
        _createRouteLogsSubject.add(Resource.error(data: null, error: error));
        if (studentListFiltered != null) {
          pickAllLoadingSubject.add(Resource.error(data: false));
        }
      },
    );
  }

  void updateAttendance(
      {required String attendanceRemark,
      required AttendanceTypeEnum attendanceType,
      required int studentId}) {
    if (attendanceRemark.toLowerCase() == "present") {
      _presentLoadingSubject.add(true);
      _absentLoadingSubject.add(false);
    } else {
      _absentLoadingSubject.add(true);
      _presentLoadingSubject.add(false);
    }
    UpdateAttendanceUsecaseParams params = UpdateAttendanceUsecaseParams(
      request: UpdateAttendanceRequest(
        attendanceUpdates: [
          AttendanceUpdate(
            attendanceDate: [DateTime.now().dateFormatToyyyMMdd()],
            attendanceRemark: attendanceRemark.toLowerCase(),
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
        _presentLoadingSubject.add(false);
        _absentLoadingSubject.add(false);
        createAttendanceResponse.add(Resource.success());
      },
      onError: (error) {
        _presentLoadingSubject.add(false);
        _absentLoadingSubject.add(false);
      },
    );
  }
}
