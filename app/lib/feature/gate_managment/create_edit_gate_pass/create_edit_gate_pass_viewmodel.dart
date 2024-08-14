import 'package:app/model/resource.dart';
import 'package:app/utils/request_manager.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_errors/flutter_errors.dart';
import 'package:rxdart/subjects.dart';
import 'package:statemanagement_riverpod/statemanagement_riverpod.dart';

class CreateEditGatePassViewModel extends BasePageViewModel {
  final FlutterExceptionHandlerBinder exceptionHandlerBinder;
  final ChooseFileUseCase _chooseFileUseCase;
  final GetPurposeOfVisitListUsecase _getPurposeOfVisitListUsecase;
  final GetTypeOfVisitorListUsecase _getTypeOfVisitorListUsecase;
  final UploadVisitorProfileUsecase _uploadVisitorProfileUsecase;

  final PublishSubject<Resource<UploadFile>> _pickFrontFileResponse =
      PublishSubject();

  Stream<Resource<UploadFile>> get pickFrontFileResponse =>
      _pickFrontFileResponse.stream;

  final PublishSubject<Resource<UploadFileResponseModel>>
      _uploadedFileResponse = PublishSubject();

  Stream<Resource<UploadFileResponseModel>> get uploadedFileResponse =>
      _uploadedFileResponse.stream;

  // ignore: unused_field
  final CreateGatepassUsecase _createGatepassUsecase;

  final PublishSubject<Resource<PurposeOfVisitModel>> _purposeOfVisitResponse =
      PublishSubject();

  Stream<Resource<PurposeOfVisitModel>> get purposeOfVisitResponse =>
      _purposeOfVisitResponse.stream;

  final PublishSubject<Resource<TypeOfVisitorResponseModel>>
      _typeOfVisitorResponse = PublishSubject();

  Stream<Resource<TypeOfVisitorResponseModel>> get typeOfVisitorResponse =>
      _typeOfVisitorResponse.stream;

  final TextEditingController visitorNameController = TextEditingController();
  final TextEditingController contactNumberController = TextEditingController();
  final TextEditingController emailIDController = TextEditingController();

  final TextEditingController comingFromController = TextEditingController();
  final TextEditingController visitDateTimeController = TextEditingController();

  CreateEditGatePassViewModel(
      {required this.exceptionHandlerBinder,
      required CreateGatepassUsecase createGatepassUsecase,
      required ChooseFileUseCase chooseFileUseCase,
      required GetTypeOfVisitorListUsecase getTypeOfVisitorListUsecase,
      required GetPurposeOfVisitListUsecase getPurposeOfVisitListUsecase,
      required UploadVisitorProfileUsecase uploadVisitorProfileUsecase})
      : _createGatepassUsecase = createGatepassUsecase,
        _chooseFileUseCase = chooseFileUseCase,
        _getTypeOfVisitorListUsecase = getTypeOfVisitorListUsecase,
        _getPurposeOfVisitListUsecase = getPurposeOfVisitListUsecase,
        _uploadVisitorProfileUsecase = uploadVisitorProfileUsecase;

  void pickImage(UpoladFileTypeEnum fileTypeEnum) {
    exceptionHandlerBinder.handle(block: () {
      ChooseFileUseCaseParams params =
          ChooseFileUseCaseParams(fileTypeEnum: fileTypeEnum);
      RequestManager<UploadFile>(params,
              createCall: () => _chooseFileUseCase.execute(params: params))
          .asFlow()
          .listen((result) {
        _pickFrontFileResponse.add(result);
        if (result.status == Status.success) {
          uploadVisitorProfileImage();
        }
      }).onError((error) {});
    }).execute();
  }

  void getPurposeOfVisitList() {
    GetPurposeOfVisitListUsecaseParams params =
        GetPurposeOfVisitListUsecaseParams();
    RequestManager<PurposeOfVisitModel>(params,
            createCall: () =>
                _getPurposeOfVisitListUsecase.execute(params: params))
        .asFlow()
        .listen((result) {
      _purposeOfVisitResponse.add(result);
    }).onError((error) {});
  }

  void getTypeOfVisitorList() {
    GetTypeOfVisitorListUsecaseParams params =
        GetTypeOfVisitorListUsecaseParams();
    RequestManager(
      params,
      createCall: () => _getTypeOfVisitorListUsecase.execute(params: params),
    ).asFlow().listen((result) {
      _typeOfVisitorResponse.add(result);
    }).onError((error) {});
  }

  uploadVisitorProfileImage() {
    _pickFrontFileResponse.listen((data) {
      if (data.status == Status.success) {
        final file = data.data?.file;
        if (file?.path != null) {
          UploadVisitorProfileUsecaseParams params =
              UploadVisitorProfileUsecaseParams(file: file!);
          RequestManager(params,
                  createCall: () =>
                      _uploadVisitorProfileUsecase.execute(params: params))
              .asFlow()
              .listen((result) async {
            _uploadedFileResponse.add(result);
          }).onError((error) {});
        }
      }
    });
  }
}
