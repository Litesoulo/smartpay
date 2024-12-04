import 'package:auto_route/auto_route.dart';

import 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        // AutoRoute(
        //   page: OnboardingRoute.page,
        // ),
        // AutoRoute(
        //   page: LoginRoute.page,
        // ),
        AutoRoute(
          initial: true,
          page: HomeDashboardRoute.page,
          children: [
            AutoRoute(
              initial: true,
              page: HomeRoute.page,
            ),
            AutoRoute(
              page: BankCardsRoute.page,
            ),
            AutoRoute(
              page: TransactionHistoryRoute.page,
            ),
            AutoRoute(
              page: SettingsRoute.page,
            ),
          ],
        ),

        // Payment
        AutoRoute(
          page: PaymentQrScannerRoute.page,
        ),
        AutoRoute(
          page: PaymentIncomingRoute.page,
        ),
      ];
}
