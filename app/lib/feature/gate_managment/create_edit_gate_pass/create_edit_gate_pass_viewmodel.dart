import 'dart:developer';

import 'package:app/model/resource.dart';
import 'package:app/utils/request_manager.dart';
import 'package:domain/domain.dart';
import 'package:flutter_errors/flutter_errors.dart';
import 'package:rxdart/subjects.dart';
import 'package:statemanagement_riverpod/statemanagement_riverpod.dart';

class CreateEditGatePassViewModel extends BasePageViewModel {
  final FlutterExceptionHandlerBinder exceptionHandlerBinder;
  final ChooseFileUseCase _chooseFileUseCase;
  final PublishSubject<Resource<UploadFile>> _pickFrontFileResponse =
      PublishSubject();
  final CreateGatepassUsecase _createGatepassUsecase;

  CreateEditGatePassViewModel(
      {required this.exceptionHandlerBinder,
      required CreateGatepassUsecase createGatepassUsecase,
      required ChooseFileUseCase chooseFileUseCase})
      : _createGatepassUsecase = createGatepassUsecase,
        _chooseFileUseCase = chooseFileUseCase;

  void pickImage(UpoladFileTypeEnum fileTypeEnum) {
    exceptionHandlerBinder.handle(block: () {
      ChooseFileUseCaseParams params =
          ChooseFileUseCaseParams(fileTypeEnum: fileTypeEnum);
      RequestManager<UploadFile>(params,
              createCall: () => _chooseFileUseCase.execute(params: params))
          .asFlow()
          .listen((result) {
        log("RESULT $result");
        _pickFrontFileResponse.add(result);
      }).onError((error) {
        log("ERROR $error");

        /// hide==> showing Local error
        //  exceptionHandlerBinder.showError(error!);
      });
    }).execute();
  }

  void createGatePass() {}
}
