import 'dart:developer';

import 'package:app/errors/flutter_toast_error_presenter.dart';
import 'package:app/feature/gate_managment/create_edit_gate_pass/create_edit_gate_pass_page.dart';

import 'package:app/model/resource.dart';
import 'package:app/myapp.dart';
import 'package:app/navigation/route_paths.dart';
import 'package:app/utils/dateformate.dart';
import 'package:app/utils/request_manager.dart';
import 'package:domain/domain.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_errors/flutter_errors.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import 'package:rxdart/rxdart.dart';
import 'package:statemanagement_riverpod/statemanagement_riverpod.dart';

class GatePassQrScannerViewModel extends BasePageViewModel {
  final FlutterExceptionHandlerBinder _exceptionHandlerBinder;
  final PatchVisitorDetailsUsecase _getVisitorDetailsUsecase;
  final GetVisitorDetailsUsecase _getGatePassDetailsUsecase;
  final PatchParentGatepassUsecase _patchParentGatepassUsecase;

  final PublishSubject<Resource<VisitorDataModel>> _visitorDetails =
      PublishSubject();

  Stream<Resource<VisitorDataModel>> get visitorDetails =>
      _visitorDetails.stream;

  final BehaviorSubject<bool> _navigateToHomeScreen = BehaviorSubject<bool>();

  Stream<bool> get navigateToHomeScreenStream => _navigateToHomeScreen.stream;

  final FlutterToastErrorPresenter _flutterToastErrorPresenter;

  bool _hasShownError = false;
  final Set<String> scannedCodes = <String>{};

  GatePassQrScannerViewModel(
      {required FlutterExceptionHandlerBinder exceptionHandlerBinder,
      required PatchVisitorDetailsUsecase getVisitorDetailsUsecase,
      required FlutterToastErrorPresenter flutterToastErrorPresenter,
      required GetVisitorDetailsUsecase getGatePassDetailsUsecase,
      required PatchParentGatepassUsecase patchParentGatepassUsecase})
      : _exceptionHandlerBinder = exceptionHandlerBinder,
        _getVisitorDetailsUsecase = getVisitorDetailsUsecase,
        _flutterToastErrorPresenter = flutterToastErrorPresenter,
        _getGatePassDetailsUsecase = getGatePassDetailsUsecase,
        _patchParentGatepassUsecase = patchParentGatepassUsecase;

  final MobileScannerController controller = MobileScannerController(
    formats: const [BarcodeFormat.qrCode],
  );

  final BehaviorSubject<String> scannerResult = BehaviorSubject<String>();

  void listenToScannerResult() {
    scannerResult.listen((result) async {
      final gatePassUri = Uri.parse(result);

      log("message $gatePassUri");

      //  Handle the scanned result
      if (result.isNotEmpty) {
        // Extract the gatepassid from the result
        String? gatepassid = gatePassUri.pathSegments.isNotEmpty
            ? gatePassUri.pathSegments.last
            : "";
        // Extract the 'type' query parameter
        final type = gatePassUri.queryParameters['type'];

        // Check if this QR code has already been scanned
        if (!scannedCodes.contains(gatepassid)) {
          _hasShownError = false;
          // Stop the scanner as soon as we get a valid result
          controller.stop();
          log('Scanned QR $gatepassid');

          // Add the gatepassid to the set to prevent future duplicates
          scannedCodes.add(gatepassid);

          // Check if 'type' exists in the query parameters
          if (type != null && type.isNotEmpty) {
            // Call the function that handles this specific type case
            getVisitorDetails(gatePassId: gatepassid, type: type);
          } else {
            // Normal case, no 'type' key in the query parameters
            patchVisitorDetails(gatepassid);
          }
        } else {
          log('Duplicate QR code $gatepassid ignored');
        }
      } else {
        qrInvalidMessageShow();
      }
    });
  }

  void getVisitorDetails({required String gatePassId, required String type}) {
    _exceptionHandlerBinder.handle(block: () {
      final params = GetVisitorDetailsUsecaseParams(gatepassId: gatePassId);

      RequestManager<VisitorDetailsResponseModel>(params,
              createCall: () =>
                  _getGatePassDetailsUsecase.execute(params: params))
          .asFlow()
          .listen((data) {
        _visitorDetails.add(Resource.loading(data: null));
        if (data.status == Status.success) {
          if (data.data?.data?.incomingTime != null &&
              (data.data?.data?.incomingTime?.isNotEmpty ?? false)) {
            punchParentOut(gatePassId: gatePassId, parentData: data.data!);
          } else {
            WidgetsBinding.instance.addPostFrameCallback((timestamp) {
              controller.stop();
              navigatorKey.currentState?.pushReplacementNamed(
                  RoutePaths.createEditGatePassPage,
                  result: "In",
                  arguments: GatePassArguments(
                      id: gatePassId,
                      type: type,
                      parentData: data.data!.data!));
            });
            _visitorDetails.add(Resource.success(data: VisitorDataModel()));

            _hasShownError = false;
          }
        } else if (data.status == Status.error && !_hasShownError) {
          _visitorDetails.add(Resource.none());

          qrInvalidMessageShow(appError: data.dealSafeAppError);

          _hasShownError = true;
        }
        //  else {
        //   _visitorDetails.add(Resource.none());

        //   log('facing some issue');
        // }
      }, onError: (error) {
        _visitorDetails.add(Resource.none());
      });
    }).execute();
  }

  void punchParentOut(
      {required String gatePassId,
      required VisitorDetailsResponseModel parentData}) {
    log("message PUNCH PARENT");
    final params = PatchParentGatepassUsecaseParams(
      gatePassId: gatePassId,
      requestBody: ParentGatePassRequestModel(
          comingFrom: parentData.data?.comingFrom,
          companyName: "Ampersand",
          guestCount: "${parentData.data?.guestCount ?? '1'}",
          otherPointOfContact: null,
          pointOfContact: parentData.data?.pointOfContact,
          purposeOfVisitId: parentData.data?.purposeOfVisitId,
          visitorTypeId: 16),
    );
    RequestManager(params,
            createCall: () =>
                _patchParentGatepassUsecase.execute(params: params))
        .asFlow()
        .listen(
      (data) {
        _visitorDetails.add(Resource.loading(data: null));
        if (Status.success == data.status &&
            (data.data?.data?.signedOut == null ||
                data.data?.data?.signedOut == true)) {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            controller.stop();

            _navigateToHomeScreen.add(true);
          });
          _visitorDetails.add(Resource.success(data: VisitorDataModel()));

          _hasShownError = false;
        } else if (data.status == Status.error && !_hasShownError) {
          _visitorDetails.add(Resource.none());

          qrInvalidMessageShow(appError: data.dealSafeAppError);

          _hasShownError = true;
        }
        // else {
        //   _visitorDetails.add(Resource.none());

        //   log('facing some issue');
        // }
      },
      onError: (error) {
        _visitorDetails.add(Resource.none());
      },
    ).onError((error) {
      _visitorDetails.add(Resource.none());
    });
  }

//scan QR and update outing time
  void patchVisitorDetails(String gatepassId) {
    _exceptionHandlerBinder.handle(block: () {
      PatchVisitorDetailsUsecaseParams params =
          PatchVisitorDetailsUsecaseParams(
        gatepassId: gatepassId,
        outgoingTime: {
          "outgoing_time": DateTime.now().dateFormatoHHmmss(),
        },
      );
      RequestManager<VisitorDetailsResponseModel>(
        params,
        createCall: () => _getVisitorDetailsUsecase.execute(params: params),
      ).asFlow().listen((result) async {
        _visitorDetails.add(Resource.loading(data: null));

        if (result.status == Status.success) {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            controller.stop();

            _navigateToHomeScreen.add(true);
          });

          _visitorDetails.add(
            Resource.success(data: result.data?.data),
          );
          _hasShownError = false;
        } else if (result.status == Status.error && !_hasShownError) {
          _visitorDetails.add(Resource.none());

          qrInvalidMessageShow(appError: result.dealSafeAppError);

          _hasShownError = true;
        }
        //  else {
        //   _visitorDetails.add(Resource.none());

        //   log('facing some issue');
        // }
      }).onError((error) {
        log("patchVisitorDetails error $error");
        _visitorDetails.add(Resource.none());
      });
    }).execute();
  }

  void qrInvalidMessageShow({AppError? appError}) {
    _flutterToastErrorPresenter.show(
      AppError(
        throwable: Exception(),
        error: ErrorInfo(message: appError?.error.message ?? 'QR Code Invalid'),
        type: ErrorType.qrCodeInvalid,
      ),
      navigatorKey.currentContext!,
      appError?.error.message ?? 'QR Code Invalid',
    );
  }

  @override
  void dispose() {
    controller.dispose();
    scannerResult.close();

    super.dispose();
  }
}
