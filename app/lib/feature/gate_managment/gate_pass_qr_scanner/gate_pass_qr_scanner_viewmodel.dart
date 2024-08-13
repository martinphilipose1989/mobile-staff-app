import 'package:flutter_errors/flutter_errors.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import 'package:rxdart/rxdart.dart';
import 'package:statemanagement_riverpod/statemanagement_riverpod.dart';

class GatePassQrScannerViewModel extends BasePageViewModel {
  final FlutterExceptionHandlerBinder exceptionHandlerBinder;

  GatePassQrScannerViewModel({required this.exceptionHandlerBinder});

  final MobileScannerController controller = MobileScannerController(
    formats: const [BarcodeFormat.qrCode],
  );

  final BehaviorSubject<String> scannerResult = BehaviorSubject<String>();

  void listenToScannerResult() {
    scannerResult.listen((result) {
      // Handle the scanned result
      if (result.isNotEmpty) {
         controller.stop();
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    scannerResult.close();
    super.dispose();
  }
}
