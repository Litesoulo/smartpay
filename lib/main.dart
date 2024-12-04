import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/error_codes.dart' as auth_error;
import 'package:local_auth/local_auth.dart';

import 'generated/strings.g.dart';
import 'src/sl/sl.dart';
import 'src/view/application/application.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LocaleSettings.useDeviceLocale();

  await setupServiceLocator();

  final LocalAuthentication auth = LocalAuthentication();
  try {
    final bool didAuthenticate = await auth.authenticate(
      localizedReason: ' ',
      options: const AuthenticationOptions(useErrorDialogs: false),
    );

    if (didAuthenticate) {
      return runApp(const Application());
    }

    throw PlatformException(code: '-1');
    // ···
  } on PlatformException catch (e) {
    if (e.code == auth_error.notEnrolled) {
      // Add handling of no hardware here.
    } else if (e.code == auth_error.lockedOut ||
        e.code == auth_error.permanentlyLockedOut) {
      // ...
    } else {
      // ...
    }
  }
}
