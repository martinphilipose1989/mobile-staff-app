import 'dart:developer';

import 'package:app/errors/flutter_toast_error_presenter.dart';
import 'package:app/model/phone_number_details.dart';
import 'package:app/model/resource.dart';
import 'package:app/myapp.dart';
import 'package:app/navigation/route_paths.dart';
import 'package:app/utils/common_widgets/common_popups.dart';
import 'package:app/utils/dateformate.dart';
import 'package:app/utils/request_manager.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_errors/flutter_errors.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';
import 'package:statemanagement_riverpod/statemanagement_riverpod.dart';

import 'create_edit_gate_pass_page.dart';

class CreateEditGatePassViewModel extends BasePageViewModel {
  // Dependencies
  final FlutterExceptionHandlerBinder exceptionHandlerBinder;
  final ChooseFileUseCase _chooseFileUseCase;
  final GetPurposeOfVisitListUsecase _getPurposeOfVisitListUsecase;
  final GetTypeOfVisitorListUsecase _getTypeOfVisitorListUsecase;
  final UploadVisitorProfileUsecase _uploadVisitorProfileUsecase;
  final CreateGatepassUsecase _createGatepassUsecase;
  final FlutterToastErrorPresenter _flutterToastErrorPresenter;
  final PopulateVisitorDataUsecase _populateVisitorDataUsecase;
  final PatchParentGatepassUsecase _patchParentGatepassUsecase;

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
  final BehaviorSubject<Resource<MdmCoReasonResponseModel>>
      _purposeOfVisitResponse = BehaviorSubject();
  Stream<Resource<MdmCoReasonResponseModel>> get purposeOfVisitResponse =>
      _purposeOfVisitResponse.stream;

  int? purposOfVisitId;

  void getPurposeOfVisitList() {
    final params = GetPurposeOfVisitListUsecaseParams();
    RequestManager<MdmCoReasonResponseModel>(params,
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
        ?.firstWhere(
            (e) => e.attributes?.name?.toLowerCase() == value.toLowerCase(),
            orElse: () => MdmCoReasonDataModel())
        .id;
  }

  // Stream for type of visitor response
  final BehaviorSubject<Resource<MdmCoReasonResponseModel>>
      _typeOfVisitorResponse = BehaviorSubject();
  Stream<Resource<MdmCoReasonResponseModel>> get typeOfVisitorResponse =>
      _typeOfVisitorResponse.stream;

  int? typeOfVisitorId;

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
        ?.firstWhere(
            (e) => e.attributes?.name?.toLowerCase() == value.toLowerCase(),
            orElse: () => MdmCoReasonDataModel())
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
  final TextEditingController vehicleController = TextEditingController();
  final TextEditingController guestCountController =
      TextEditingController(text: '1');
  final TextEditingController visitDateTimeController = TextEditingController(
      text: DateTime.now().toIso8601String().dateFormatToDDMMYYYhhmma());

  BehaviorSubject<String> countryDialCode = BehaviorSubject.seeded("+91");
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  void createGatePass() async {
    final params = CreateGatepassUsecaseParams(
      requestModel: CreateGatePassModel(
          name: visitorNameController.text,
          mobile: "${countryDialCode.value}${contactNumberController.text}",
          email: emailIDController.text,
          visitorTypeId: typeOfVisitorId,
          purposeOfVisitId: purposOfVisitId,
          comingFrom: comingFromController.text,
          pointOfContact: pointOfContactController.text,
          profileImage: _uploadedFileResponse.valueOrNull?.data?.data?.filePath,
          guestCount: int.parse(guestCountController.text),
          vehicleNumber: vehicleController.text),
    );

    RequestManager(params,
            createCall: () => _createGatepassUsecase.execute(params: params))
        .asFlow()
        .listen((data) {
      _createGatePassResponse.add(data);

      if (data.status == Status.success) {
        loadingSubject.add(Resource.loading(data: false));
        CommonPopups().showSuccess(
            navigatorKey.currentContext!, "Gate pass created successfuly",
            (value) {
          navigatorKey.currentState?.pushReplacementNamed(
            RoutePaths.visitorDetailsPage,
            arguments: {
              'gatePassId': '${data.data?.data?.id}',
              'type': "In",
            },
          );
        }, popParameter: "In");
      } else if (data.status == Status.error) {
        loadingSubject.add(Resource.loading(data: false));
        _flutterToastErrorPresenter.show(
            data.dealSafeAppError!,
            navigatorKey.currentContext!,
            "${data.dealSafeAppError?.error.message}");
      }
    }).onError((error) {
      loadingSubject.add(Resource.loading(data: false));
    });
  }

  void populateVisitorData() {
    PopulateVisitorDataUsecaseParams params = PopulateVisitorDataUsecaseParams(
        mobileNumber:
            "${countryDialCode.value}${contactNumberController.text}");
    RequestManager<VisitorPopulateResponseModel>(params,
            createCall: () =>
                _populateVisitorDataUsecase.execute(params: params))
        .asFlow()
        .listen((data) {
      if (data.status == Status.success) {
        if (data.data?.data != null) {
          visitorNameController.text = data.data?.data?.name ?? "";
          emailIDController.text = data.data?.data?.email ?? "";
          log("CONTACT ${data.data?.data?.mobile}");
          contactNumberController.text = data.data?.data?.mobile ?? "";
          //TODO: uncomment after deom  getCountryCode(phoneNumber: data.data?.data?.mobile ?? "");
          _uploadedFileResponse.add(
            Resource.success(
              data: UploadFileResponseModel(
                status: 200,
                data: UploadFileResponseData(
                    filePath: data.data?.data?.profileImage,
                    url: data.data?.data?.profileImageUrl),
              ),
            ),
          );
        }
      } else if (data.status == Status.error) {
        _flutterToastErrorPresenter.show(data.dealSafeAppError!.throwable,
            navigatorKey.currentContext!, data.dealSafeAppError!.type.name);
      }
    }).onError((error) {
      _flutterToastErrorPresenter.show(error.dealSafeAppError!.throwable,
          navigatorKey.currentContext!, error.dealSafeAppError!.type.name);
    });
  }

  getCountryCode({required String phoneNumber}) async {
    try {
      final result = await parse(phoneNumber);
      final validPhoneNumber = PhoneNumberDetails.fromMap(result);

      contactNumberController.text = validPhoneNumber.nationalNumber;
      countryDialCode.add("+${validPhoneNumber.countryCode}");
      return validPhoneNumber.countryCode.isNotEmpty ? true : false;
    } on PlatformException catch (_) {}
  }

  String type = "";
  String gatePassId = "";

  BehaviorSubject<String>? intialTypeOfVisitor = BehaviorSubject.seeded('');

  void populateGatePass({required GatePassArguments arguments}) {
    visitorNameController.text = arguments.parentData.visitorName ?? "";
    emailIDController.text = arguments.parentData.visitorEmail ?? "";
    contactNumberController.text = arguments.parentData.visitorMobile ?? "";
    gatePassId = arguments.id;
    type = arguments.type;

    // TODO: uncomment after demo getCountryCode(phoneNumber: arguments.parentData.visitorMobile ?? "");
  }

  void patchParent() {
    final params = PatchParentGatepassUsecaseParams(
      gatePassId: gatePassId,
      requestBody: ParentGatePassRequestModel(
          visitorTypeId: 16,
          purposeOfVisitId: purposOfVisitId,
          comingFrom: comingFromController.text,
          pointOfContact: pointOfContactController.text,
          companyName: "Ampersand",
          guestCount: guestCountController.text),
    );
    RequestManager(
      params,
      createCall: () => _patchParentGatepassUsecase.execute(
        params: params,
      ),
    ).asFlow().listen((data) {
      if (data.status == Status.success) {
        loadingSubject.add(Resource.loading(data: false));

        CommonPopups().showSuccess(
          navigatorKey.currentContext!,
          type.isNotEmpty
              ? "Gate pass updated successfuly"
              : "Gate pass created successfuly",
          (value) {
            navigatorKey.currentState?.pushReplacementNamed(
              RoutePaths.visitorDetailsPage,
              arguments: {
                'gatePassId': '${data.data?.data?.visitorDataModel?.id}',
                'type': "In"
              },
            );
          },
          popParameter: "In",
        );
      } else if (data.status == Status.error) {
        loadingSubject.add(Resource.loading(data: false));
        _flutterToastErrorPresenter.show(
            data.dealSafeAppError!,
            navigatorKey.currentContext!,
            "${data.dealSafeAppError?.error.message}");
      }
    }).onError((error) {
      loadingSubject.add(Resource.loading(data: false));
    });
  }

  final BehaviorSubject<Resource<bool>> loadingSubject =
      BehaviorSubject.seeded(Resource.none());

  void creatOrUpdateGatePass() {
    loadingSubject.add(Resource.loading(data: true));
    if (type == "cross-platform") {
      patchParent();
    } else {
      createGatePass();
    }
  }

  // Constructor
  CreateEditGatePassViewModel(
      {required this.exceptionHandlerBinder,
      required PatchParentGatepassUsecase patchParentGatepassUsecase,
      required PopulateVisitorDataUsecase populateVisitorDataUsecase,
      required CreateGatepassUsecase createGatepassUsecase,
      required ChooseFileUseCase chooseFileUseCase,
      required GetTypeOfVisitorListUsecase getTypeOfVisitorListUsecase,
      required GetPurposeOfVisitListUsecase getPurposeOfVisitListUsecase,
      required UploadVisitorProfileUsecase uploadVisitorProfileUsecase,
      required FlutterToastErrorPresenter flutterToastErrorPresenter})
      : _populateVisitorDataUsecase = populateVisitorDataUsecase,
        _createGatepassUsecase = createGatepassUsecase,
        _chooseFileUseCase = chooseFileUseCase,
        _getTypeOfVisitorListUsecase = getTypeOfVisitorListUsecase,
        _getPurposeOfVisitListUsecase = getPurposeOfVisitListUsecase,
        _uploadVisitorProfileUsecase = uploadVisitorProfileUsecase,
        _flutterToastErrorPresenter = flutterToastErrorPresenter,
        _patchParentGatepassUsecase = patchParentGatepassUsecase;
}
