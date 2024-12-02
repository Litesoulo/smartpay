part of 'sl.dart';

_setupViewModel() async {
  sl.registerSingleton(
    () => SettingsStore(
      repository: sl<SettingsRepository>(),
    ),
  );
}
