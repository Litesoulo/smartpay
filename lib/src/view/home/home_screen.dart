import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../generated/assets/assets.gen.dart';
import '../../../generated/strings.g.dart';
import '../../common/extensions/extensions.dart';
import '../../common/router/app_router.gr.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.t.dashboard.home,
        ),
      ),
      body: ListView(
        children: [
          Assets.images.loading.image(
            height: context.height * 0.24,
          ),
        ],
      ),
      floatingActionButton: _ScanQrButton(),
    );
  }
}

class _ScanQrButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => context.pushRoute(
        const PaymentQrScannerRoute(),
      ),
      child: const Icon(
        Icons.qr_code,
      ),
    );
  }
}
