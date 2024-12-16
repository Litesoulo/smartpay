import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:smartpay/generated/assets/assets.gen.dart';

import '../../../generated/strings.g.dart';
import '../../../main.dart';
import '../../common/constant/app_constants.dart';
import '../../common/extensions/extensions.dart';
import '../../common/router/app_router.gr.dart';
import '../../common/widget/space.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: context.height * 0.4,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  context.colorScheme.primary,
                  context.colorScheme.primary.withOpacity(0.5),
                  context.theme.scaffoldBackgroundColor,
                ],
              ),
            ),
          ),
          SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Container(
                    padding: const EdgeInsets.all(AppConstants.padding),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      context.t.dashboard.home,
                      style: context.textTheme.titleLarge?.copyWith(
                        color: context.colorScheme.onPrimary,
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Assets.images.oguzhanLogo.image(
                    height: context.height * 0.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (kIsBusiness)
            FloatingActionButton(
              onPressed: () => context.pushRoute(
                const ReceivePaymentRoute(),
              ),
              child: const Icon(
                Icons.call_received_outlined,
              ),
            ),
          Space.h20,
          _ScanQrButton(),
        ],
      ),
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
