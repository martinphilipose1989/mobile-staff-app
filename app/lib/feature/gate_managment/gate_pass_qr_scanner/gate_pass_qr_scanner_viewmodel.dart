import 'dart:developer';

import 'package:app/model/resource.dart';
import 'package:app/utils/dateformate.dart';
import 'package:app/utils/request_manager.dart';
import 'package:domain/domain.dart';
import 'package:flutter_errors/flutter_errors.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import 'package:rxdart/rxdart.dart';
import 'package:statemanagement_riverpod/statemanagement_riverpod.dart';

class GatePassQrScannerViewModel extends BasePageViewModel {
  final FlutterExceptionHandlerBinder _exceptionHandlerBinder;
  final PatchVisitorDetailsUsecase _getVisitorDetailsUsecase;

  BehaviorSubject<VisitorDataModel>? visitorDetails =
      BehaviorSubject<VisitorDataModel>.seeded(VisitorDataModel());

  BehaviorSubject<bool> isLoading = BehaviorSubject<bool>.seeded(false);
  BehaviorSubject<bool> isUpdateOutGoingTime =
      BehaviorSubject<bool>.seeded(false);

  GatePassQrScannerViewModel(
      {required FlutterExceptionHandlerBinder exceptionHandlerBinder,
      required PatchVisitorDetailsUsecase getVisitorDetailsUsecase})
      : _exceptionHandlerBinder = exceptionHandlerBinder,
        _getVisitorDetailsUsecase = getVisitorDetailsUsecase;

  final MobileScannerController controller = MobileScannerController(
    formats: const [BarcodeFormat.qrCode],
  );

  final BehaviorSubject<String> scannerResult = BehaviorSubject<String>();

  void listenToScannerResult() {
    scannerResult.listen((result) async {
      // Handle the scanned result
      if (result.isNotEmpty) {
        isLoading.add(true);
        // controller.stop();

        String gatepassid = result.split('/').last;
        log('scanne qr $gatepassid');

        patchVisitorDetails(gatepassid);
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
      ).asFlow().listen((result) {
        isLoading.add(false);

        if (result.status == Status.success) {
          isUpdateOutGoingTime.add(true);
          // Access the data from the resource
          visitorDetails?.add(result.data?.data ?? VisitorDataModel());
          log("patchVisitorDetails  success${visitorDetails?.first.toString()}");
        } else {
          // controller.start();
          log('facing some issue');
        }
      }).onError((error) {
        isLoading.add(false);
        //controller.start();
        log("patchVisitorDetails error $error");
      });
    }).execute();
  }

  @override
  void dispose() {
    controller.dispose();
    scannerResult.close();
    isLoading.close();
    super.dispose();
  }
}
