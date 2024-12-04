import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../common/extensions/extensions.dart';

@RoutePage()
class PaymentIncomingScreen extends StatelessWidget {
  const PaymentIncomingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: QrImageView(
          data: 'bebb5c4c-0d4c-4dd9-bcd2-3ce0fe0f2e23',
          version: QrVersions.auto,
          eyeStyle: QrEyeStyle(
            color: context.colorScheme.onSurface,
            eyeShape: QrEyeShape.square,
          ),
          dataModuleStyle: QrDataModuleStyle(
            color: context.colorScheme.onSurface,
            dataModuleShape: QrDataModuleShape.square,
          ),
          size: context.width * 0.8,
          gapless: false,
        ),
      ),
    );
  }
}
