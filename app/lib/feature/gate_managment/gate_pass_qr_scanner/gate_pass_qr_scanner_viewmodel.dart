import 'dart:developer';

import 'package:app/errors/flutter_toast_error_presenter.dart';
import 'package:app/model/resource.dart';
import 'package:app/myapp.dart';
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

  final PublishSubject<Resource<VisitorDataModel>> _visitorDetails =
      PublishSubject();

  Stream<Resource<VisitorDataModel>> get visitorDetails =>
      _visitorDetails.stream;

  final BehaviorSubject<bool> _navigateToHomeScreen = BehaviorSubject<bool>();

  Stream<bool> get navigateToHomeScreenStream => _navigateToHomeScreen.stream;

  final FlutterToastErrorPresenter _flutterToastErrorPresenter;

  bool _hasShownError = false;

  GatePassQrScannerViewModel({
    required FlutterExceptionHandlerBinder exceptionHandlerBinder,
    required PatchVisitorDetailsUsecase getVisitorDetailsUsecase,
    required FlutterToastErrorPresenter flutterToastErrorPresenter,
  })  : _exceptionHandlerBinder = exceptionHandlerBinder,
        _getVisitorDetailsUsecase = getVisitorDetailsUsecase,
        _flutterToastErrorPresenter = flutterToastErrorPresenter;

  final MobileScannerController controller = MobileScannerController(
    formats: const [BarcodeFormat.qrCode],
  );

  final BehaviorSubject<String> scannerResult = BehaviorSubject<String>();

  void listenToScannerResult() {
    scannerResult.listen((result) async {
      // Handle the scanned result
      if (result.isNotEmpty) {
        String gatepassid = result.split('/').last;
        log('scanne qr $gatepassid');
        controller.stop();
        patchVisitorDetails(gatepassid);
      } else {
        _flutterToastErrorPresenter.show(
          AppError(
            throwable: Exception(),
            error: ErrorInfo(message: 'QR Code Invalid'),
            type: ErrorType.qrCodeInvalid,
          ),
          navigatorKey.currentContext!,
          'QR Code Invalid',
        );
      }
    });
  }

//scan QR and update outing time
  void patchVisitorDetails(String gatepassId) {
    _exceptionHandlerBinder.handle(block: () {
      PatchVisitorDetailsUsecaseParams params =
          PatchVisitorDetailsUsecaseParams(
        gatepassId: gatepassId,
        outgoingTime: {
          "outgoing_time": DateTime.now().dateFormatohhmmss(),
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
            Resource.success(
              data: result.data?.data,
            ),
          );
          _hasShownError = false;
        } else if (result.status == Status.error && !_hasShownError) {
          _visitorDetails.add(Resource.none());

          _flutterToastErrorPresenter.show(
            AppError(
              throwable: Exception(),
              error: ErrorInfo(message: 'QR Code Invalid'),
              type: ErrorType.qrCodeInvalid,
            ),
            navigatorKey.currentContext!,
            'QR Code Invalid',
          );

          _hasShownError = true;
          controller.start();
        } else {
          _visitorDetails.add(Resource.none());
          // controller.start();
          log('facing some issue');
        }
      }).onError((error) {
        log("patchVisitorDetails error $error");
      });
    }).execute();
  }

  @override
  void dispose() {
    controller.dispose();
    scannerResult.close();

    super.dispose();
  }
}
