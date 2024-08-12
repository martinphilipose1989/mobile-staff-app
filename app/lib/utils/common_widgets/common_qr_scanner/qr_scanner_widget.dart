import 'package:app/utils/common_widgets/common_qr_scanner/qr_scanner_error_widget.dart';
import 'package:app/utils/common_widgets/common_qr_scanner/qr_scanner_overlay_shape.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:rxdart/rxdart.dart';

class QrScannerWidget extends StatelessWidget {
  final MobileScannerController? controller;
  final Rect? scanWindow;

  final Function(List<Barcode>) onDetect;
  final BehaviorSubject<String> scannerResult;

  const QrScannerWidget(
    this.controller,
    this.scanWindow, {
    required this.onDetect,
    required this.scannerResult,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: scanWindow?.height,
      width: scanWindow?.width,
      decoration: ShapeDecoration(
        shape: QrScannerOverlayShape(
          overlayColor: Colors.red,
          borderRadius: 0.5,
          borderLength: 30,
          borderWidth: 8,
          cutOutWidth: scanWindow!.width,
          cutOutHeight: scanWindow!.height,
        ),
      ),
      child: MobileScanner(
        onDetect: (capture) {
          final List<Barcode> barcodes = capture.barcodes;
          onDetect(barcodes);
          for (final barcode in barcodes) {
            final result = barcode.rawValue ?? '';

            scannerResult.add(result);
          }
        },
        controller: controller,
        errorBuilder: (context, error, child) {
          return QrScannerErrorWidget(
            error: error,
          );
        },
      ),
    );
  }
}
