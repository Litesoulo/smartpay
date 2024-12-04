import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../common/extensions/extensions.dart';
import '../../common/widget/space.dart';

@RoutePage()
class PaymentQrScannerScreen extends StatelessWidget {
  const PaymentQrScannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _MobileScanner(),
    );
  }
}

class _MobileScanner extends StatefulWidget {
  @override
  State<_MobileScanner> createState() => _MobileScannerState();
}

class _MobileScannerState extends State<_MobileScanner>
    with WidgetsBindingObserver {
  final MobileScannerController _scannerController = MobileScannerController(
      // required options for the scanner
      );

  StreamSubscription<Object?>? _subscription;
  String text = '';

  _handleBarcode(BarcodeCapture barcodeCapture) {
    final value = barcodeCapture.barcodes.firstOrNull;
    final isUUID = value?.rawValue?.isUUID ?? false;

    if (isUUID) {
      text = value?.rawValue ?? '';
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    // Start listening to lifecycle changes.
    WidgetsBinding.instance.addObserver(this);

    // Start listening to the barcode events.
    _subscription = _scannerController.barcodes.listen(_handleBarcode);

    // Finally, start the scanner itself.
    unawaited(_scannerController.start());
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // If the controller is not ready, do not try to start or stop it.
    // Permission dialogs can trigger lifecycle changes before the controller is ready.
    if (!_scannerController.value.hasCameraPermission) {
      return;
    }

    switch (state) {
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
      case AppLifecycleState.paused:
        return;
      case AppLifecycleState.resumed:
        // Restart the scanner when the app is resumed.
        // Don't forget to resume listening to the barcode events.
        _subscription = _scannerController.barcodes.listen(_handleBarcode);

        unawaited(_scannerController.start());
      case AppLifecycleState.inactive:
        // Stop the scanner when the app is paused.
        // Also stop the barcode events subscription.
        unawaited(_subscription?.cancel());
        _subscription = null;
        unawaited(_scannerController.stop());
    }
  }

  @override
  Future<void> dispose() async {
    // Stop listening to lifecycle changes.
    WidgetsBinding.instance.removeObserver(this);
    // Stop listening to the barcode events.
    unawaited(_subscription?.cancel());
    _subscription = null;
    // Dispose the widget itself.
    super.dispose();
    // Finally, dispose of the controller.
    await _scannerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Space.v80,
        SizedBox(
          height: context.height * 0.5,
          width: double.infinity,
          child: MobileScanner(
            controller: _scannerController,
          ),
        ),
        Text(
          text,
          style: context.textTheme.titleSmall,
        ),
      ],
    );
  }
}
