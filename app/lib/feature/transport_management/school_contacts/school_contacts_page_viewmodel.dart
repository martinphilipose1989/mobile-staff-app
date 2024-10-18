import 'package:app/errors/flutter_toast_error_presenter.dart';
import 'package:app/model/resource.dart';
import 'package:app/utils/api_response_handler.dart';
import 'package:domain/domain.dart';

import 'package:flutter_errors/flutter_errors.dart';
import 'package:rxdart/rxdart.dart';
import 'package:statemanagement_riverpod/statemanagement_riverpod.dart';

class SchoolContactsPageViewModel extends BasePageViewModel {
  final FlutterExceptionHandlerBinder exceptionHandlerBinder;
  final FlutterToastErrorPresenter flutterToastErrorPresenter;
  final GetSchoolContactListUsecase getSchoolContactListUsecase;

  final BehaviorSubject<Resource<List<SchoolResponse>>> schoolContactSubject =
      BehaviorSubject.seeded(Resource.none());

  SchoolContactsPageViewModel(
      {required this.exceptionHandlerBinder,
      required this.flutterToastErrorPresenter,
      required this.getSchoolContactListUsecase});

  void getSchoolContactList({required int schoolId}) {
    schoolContactSubject.add(Resource.loading());
    GetSchoolContactListUsecaseParams params =
        GetSchoolContactListUsecaseParams(schoolId: schoolId);

    ApiResponseHandler.apiCallHandler(
      exceptionHandlerBinder: exceptionHandlerBinder,
      flutterToastErrorPresenter: flutterToastErrorPresenter,
      params: params,
      createCall: (params) =>
          getSchoolContactListUsecase.execute(params: params),
      onSuccess: (result) {
        schoolContactSubject.add(Resource.success(data: result?.data));
      },
      onError: (error) {
        schoolContactSubject.add(Resource.error(error: error));
      },
    );
  }
}
