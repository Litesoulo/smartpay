import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:mobx/mobx.dart';

import '../../../generated/strings.g.dart';
import '../../../main.dart';
import '../../common/constant/app_constants.dart';
import '../../common/extensions/extensions.dart';
import '../../common/widget/icon_animated.dart';
import '../../common/widget/space.dart';
import '../../sl/sl.dart';
import '../../view_model/bank_card/bank_card_store.dart';
import '../../view_model/bank_card/bank_store.dart';
import '../bank_card/add_bank_card_screen.dart';
import 'store/payment_store.dart';

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

class _MobileScannerState extends State<_MobileScanner> with WidgetsBindingObserver {
  final MobileScannerController _scannerController = MobileScannerController(
      // required options for the scanner
      );

  StreamSubscription<Object?>? _subscription;

  _handleBarcode(BarcodeCapture barcodeCapture) {
    final value = barcodeCapture.barcodes.firstOrNull;

    if (value?.rawValue == null) return;

    final text = value?.rawValue ?? '';

    if (text.isNotEmpty) {
      sl<PaymentStore>().getDetectedPayment(text);
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

    sl<BankCardStore>().dispose();
    sl<PaymentStore>().dispose();

    super.dispose();
    // Finally, dispose of the controller.
    await _scannerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Space.v80,
        Observer(builder: (_) {
          final detectedPaymentFuture = sl<PaymentStore>().detectedPaymentFuture;
          final isPending = detectedPaymentFuture.status == FutureStatus.pending;
          final detectedPayment = detectedPaymentFuture.value;

          final updatePaymetFuture = sl<PaymentStore>().updatePaymentFuture;
          final isUpdatePending = updatePaymetFuture.status == FutureStatus.pending;
          final updatedPaymet = updatePaymetFuture.value;
          final router = context.router;

          if (updatedPaymet != null) {
            Future.delayed(
              const Duration(seconds: 3),
              () => router.maybePop(),
            );
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: context.colorScheme.primary,
                        width: 4,
                      ),
                    ),
                    child: IconAnimated(
                      active: true,
                      size: 128,
                      color: context.colorScheme.primary,
                      iconType: IconType.check,
                    ),
                  ),
                  Space.v40,
                  Text(
                    context.t.thanksForPayment,
                    style: context.textTheme.titleLarge,
                  ),
                ],
              ),
            );
          }

          if (detectedPayment != null) {
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...[
                    Text(
                      context.t.addCard.selectBank,
                      style: context.textTheme.titleLarge,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(AppConstants.padding),
                      child: BankSelector(
                        banks: sl<BankStore>().banksFuture.value ?? [],
                      ),
                    ),
                    Text(
                      '${context.t.amount} ${detectedPayment.amount.toStringAsFixed(2)} TMT',
                      style: context.textTheme.titleLarge,
                    ),
                    Observer(builder: (context) {
                      return AnimatedSwitcher(
                        duration: AppConstants.defaultAnimationDuration,
                        child: isUpdatePending
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : FilledButton(
                                onPressed: () {
                                  final selectedBankId = sl<BankCardStore>().bankCard.bankId;

                                  if (selectedBankId.isEmpty) {
                                    ScaffoldMessenger.of(context).clearSnackBars();

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          context.t.addCard.selectBank,
                                        ),
                                      ),
                                    );

                                    return;
                                  }

                                  sl<PaymentStore>().updatePayment(
                                    (sl<PaymentStore>().detectedPaymentFuture.value!).copyWith(
                                      bankIdentifier: selectedBankId,
                                      isSuccess: true,
                                      date: DateTime.now(),
                                      senderId: clientId,
                                    ),
                                  );
                                },
                                child: Text(
                                  context.t.submit,
                                ),
                              ),
                      );
                    }),
                  ].expand(
                    (e) => [
                      e,
                      Space.v20,
                    ],
                  ),
                ],
              ),
            );
          }

          return AnimatedSwitcher(
            duration: AppConstants.defaultAnimationDuration,
            child: isPending
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : SizedBox(
                    height: context.height * 0.5,
                    width: double.infinity,
                    child: MobileScanner(
                      controller: _scannerController,
                    ),
                  ),
          );
        }),
      ],
    );
  }
}
