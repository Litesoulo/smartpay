part of 'sl.dart';

Future<void> _setupViewModel() async {
  sl.registerSingleton<SettingsStore>(
    SettingsStore(
      repository: sl<SettingsRepository>(),
    ),
  );
}
