part of 'sl.dart';

Future<void> _setupViewModel() async {
  final settingsStoreCompleter = Completer<void>();
  sl.registerSingleton(
    SettingsStore(
      settingsRepository: sl<SettingsRepository>(),
      initCompleter: settingsStoreCompleter,
    ),
  );
  await settingsStoreCompleter.future;
}
