part of 'sl.dart';

_setupModel() async {
  final prefs = await SharedPreferences.getInstance();

  sl.registerSingleton<SettingsRepository>(
    SettingsRepositoryImpl(prefs: prefs),
  );
}
