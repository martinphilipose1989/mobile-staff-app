import 'package:app/errors/flutter_toast_error_presenter.dart';
import 'package:app/model/resource.dart';
import 'package:app/myapp.dart';
import 'package:app/utils/request_manager.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_errors/flutter_errors.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/subjects.dart';
import 'package:statemanagement_riverpod/statemanagement_riverpod.dart';

class CreateEditGatePassViewModel extends BasePageViewModel {
  // Dependencies
  final FlutterExceptionHandlerBinder exceptionHandlerBinder;
  final ChooseFileUseCase _chooseFileUseCase;
  final GetPurposeOfVisitListUsecase _getPurposeOfVisitListUsecase;
  final GetTypeOfVisitorListUsecase _getTypeOfVisitorListUsecase;
  final UploadVisitorProfileUsecase _uploadVisitorProfileUsecase;
  final CreateGatepassUsecase _createGatepassUsecase;
  final FlutterToastErrorPresenter _flutterToastErrorPresenter;

  // Stream for picking front file
  final PublishSubject<Resource<UploadFile>> _pickFrontFileResponse =
      PublishSubject();
  Stream<Resource<UploadFile>> get pickFrontFileResponse =>
      _pickFrontFileResponse.stream;

  void pickImage(UpoladFileTypeEnum fileTypeEnum) {
    exceptionHandlerBinder.handle(block: () {
      final params = ChooseFileUseCaseParams(fileTypeEnum: fileTypeEnum);
      RequestManager<UploadFile>(params,
              createCall: () => _chooseFileUseCase.execute(params: params))
          .asFlow()
          .listen((result) {
        _pickFrontFileResponse.add(result);
        if (result.status == Status.success) {
          uploadVisitorProfileImage(uploadedFile: result.data);
        }
      }).onError((error) {});
    }).execute();
  }

  // Stream for uploading file response
  final BehaviorSubject<Resource<UploadFileResponseModel>>
      _uploadedFileResponse = BehaviorSubject();
  Stream<Resource<UploadFileResponseModel>> get uploadedFileResponse =>
      _uploadedFileResponse.stream;

  void uploadVisitorProfileImage({UploadFile? uploadedFile}) {
    final params = UploadVisitorProfileUsecaseParams(file: uploadedFile!.file!);
    RequestManager(params,
            createCall: () =>
                _uploadVisitorProfileUsecase.execute(params: params))
        .asFlow()
        .listen((result) {
      _uploadedFileResponse.add(result);
    }).onError((error) {});
  }

  // Stream for purpose of visit response
  final BehaviorSubject<Resource<PurposeOfVisitModel>> _purposeOfVisitResponse =
      BehaviorSubject();
  Stream<Resource<PurposeOfVisitModel>> get purposeOfVisitResponse =>
      _purposeOfVisitResponse.stream;

  String? purposOfVisitId;

  void getPurposeOfVisitList() {
    final params = GetPurposeOfVisitListUsecaseParams();
    RequestManager<PurposeOfVisitModel>(params,
            createCall: () =>
                _getPurposeOfVisitListUsecase.execute(params: params))
        .asFlow()
        .listen((result) {
      purposOfVisitId = null;
      _purposeOfVisitResponse.add(result);
    }).onError((error) {});
  }

  void setPurposeOfVisitId(String value) {
    final result = _purposeOfVisitResponse.valueOrNull;
    purposOfVisitId = result?.data?.data
        ?.firstWhere((e) => e.name?.toLowerCase() == value.toLowerCase(),
            orElse: () => PurposeOfVisitDataModel())
        .id;
  }

  // Stream for type of visitor response
  final BehaviorSubject<Resource<TypeOfVisitorResponseModel>>
      _typeOfVisitorResponse = BehaviorSubject();
  Stream<Resource<TypeOfVisitorResponseModel>> get typeOfVisitorResponse =>
      _typeOfVisitorResponse.stream;

  String? typeOfVisitorId;

  void getTypeOfVisitorList() {
    final params = GetTypeOfVisitorListUsecaseParams();
    RequestManager(params,
            createCall: () =>
                _getTypeOfVisitorListUsecase.execute(params: params))
        .asFlow()
        .listen((result) {
      typeOfVisitorId = null;
      _typeOfVisitorResponse.add(result);
    }).onError((error) {});
  }

  void setTypeOfVisitorId(String value) {
    final result = _typeOfVisitorResponse.valueOrNull;
    typeOfVisitorId = result?.data?.data
        ?.firstWhere((e) => e.name?.toLowerCase() == value.toLowerCase(),
            orElse: () => TypeOfVisitorDataModel())
        .id;
  }

  // Stream for creating gate pass response
  final PublishSubject<Resource<CreateGatepassResponseModel>>
      _createGatePassResponse = PublishSubject();
  Stream<Resource<CreateGatepassResponseModel>> get createGatePassResponse =>
      _createGatePassResponse.stream;

  final TextEditingController visitorNameController = TextEditingController();
  final TextEditingController contactNumberController = TextEditingController();
  final TextEditingController emailIDController = TextEditingController();
  final TextEditingController comingFromController = TextEditingController();
  final TextEditingController pointOfContactController =
      TextEditingController();
  final TextEditingController guestCountController =
      TextEditingController(text: '0');
  final TextEditingController visitDateTimeController = TextEditingController(
    text: DateFormat('dd/MM/yyyy - hh:mma').format(DateTime.now()),
  );

  String countryDialCode = "+91";
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  void createGatePass() async {
    final params = CreateGatepassUsecaseParams(
      requestModel: CreateGatePassModel(
        name: visitorNameController.text,
        mobile: "$countryDialCode${contactNumberController.text}",
        email: emailIDController.text,
        visitorTypeId: typeOfVisitorId,
        purposeOfVisitId: purposOfVisitId,
        comingFrom: comingFromController.text,
        pointOfContact: pointOfContactController.text,
        companyName: 'Neo',
        profileImage: _uploadedFileResponse.valueOrNull?.data?.data?.url,
        guestCount: guestCountController.text,
      ),
    );

    RequestManager(params,
            createCall: () => _createGatepassUsecase.execute(params: params))
        .asFlow()
        .listen((data) {
      _createGatePassResponse.add(data);
      if (data.status == Status.error) {
        _flutterToastErrorPresenter.show(
            data.dealSafeAppError!,
            navigatorKey.currentContext!,
            "${data.dealSafeAppError?.error.message}");
      }
    }).onError((error) {});
  }

  // Constructor
  CreateEditGatePassViewModel(
      {required this.exceptionHandlerBinder,
      required CreateGatepassUsecase createGatepassUsecase,
      required ChooseFileUseCase chooseFileUseCase,
      required GetTypeOfVisitorListUsecase getTypeOfVisitorListUsecase,
      required GetPurposeOfVisitListUsecase getPurposeOfVisitListUsecase,
      required UploadVisitorProfileUsecase uploadVisitorProfileUsecase,
      required FlutterToastErrorPresenter flutterToastErrorPresenter})
      : _createGatepassUsecase = createGatepassUsecase,
        _chooseFileUseCase = chooseFileUseCase,
        _getTypeOfVisitorListUsecase = getTypeOfVisitorListUsecase,
        _getPurposeOfVisitListUsecase = getPurposeOfVisitListUsecase,
        _uploadVisitorProfileUsecase = uploadVisitorProfileUsecase,
        _flutterToastErrorPresenter = flutterToastErrorPresenter;
}
