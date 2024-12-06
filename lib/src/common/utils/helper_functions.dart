import '../../../generated/strings.g.dart';

String getLocalizedText({
  required String ru,
  required String en,
  required String tk,
}) {
  final locale = LocaleSettings.currentLocale;

  switch (locale) {
    case AppLocale.ru:
      return ru;
    case AppLocale.tk:
      return tk;
    case AppLocale.en:
      return en;
    default:
      return '';
  }
}
