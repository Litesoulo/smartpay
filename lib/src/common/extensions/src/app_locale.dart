import 'package:flutter/material.dart';

import '../../../../../generated/strings.g.dart';

extension AppLocaleX on AppLocale {
  String getName(BuildContext context) {
    final locale = context.t.locale;

    switch (this) {
      case AppLocale.tk:
        return locale.turkmen;
      case AppLocale.ru:
        return locale.russian;
      case AppLocale.en:
        return locale.english;
      default:
        return '';
    }
  }
}
