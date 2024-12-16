import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/error_codes.dart' as auth_error;
import 'package:local_auth/local_auth.dart';

import 'package:intl/date_symbol_data_local.dart';
import 'package:smartpay/src/view_model/settings/settings_store.dart';

import 'generated/strings.g.dart';
import 'src/common/logger/logger.dart';
import 'src/sl/sl.dart';
import 'src/view/application/application.dart';

const kIsBusiness = false;
const businessId = 'iwbma6ayu863854';
const clientId = '93txjwkw5238789';

void main() async => runZonedGuarded(
      () async {
        WidgetsFlutterBinding.ensureInitialized();
        LocaleSettings.useDeviceLocale();

        HttpOverrides.global = MyHttpOverrides();
        FlutterError.onError = Logger.logFlutterError;
        PlatformDispatcher.instance.onError = Logger.logPlatformDispatcherError;
        initializeDateFormatting();

        await setupServiceLocator();

        final checkIdentity = sl<SettingsStore>().settings.checkIdentity;

        if (!checkIdentity) {
          runApp(
            TranslationProvider(
              child: const Application(),
            ),
          );
          return;
        }

        final LocalAuthentication auth = LocalAuthentication();
        try {
          final bool didAuthenticate = await auth.authenticate(
            localizedReason: ' ',
            options: const AuthenticationOptions(useErrorDialogs: false),
          );

          if (didAuthenticate) {
            return runApp(
              TranslationProvider(
                child: const Application(),
              ),
            );
          }

          throw PlatformException(code: '-1');
          // ···
        } on PlatformException catch (e) {
          if (e.code == auth_error.notEnrolled) {
            // Add handling of no hardware here.
          } else if (e.code == auth_error.lockedOut || e.code == auth_error.permanentlyLockedOut) {
            // ...
          } else {
            // ...
          }
        }
      },
      Logger.logZoneError,
    );

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}
