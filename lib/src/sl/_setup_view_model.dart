part of 'sl.dart';

Future<void> _setupViewModel() async {
  final settingsStoreCompleter = Completer<void>();
  sl.registerSingleton<SettingsStore>(
    SettingsStore(
      settingsRepository: sl<SettingsRepository>(),
      initCompleter: settingsStoreCompleter,
    ),
  );
  await settingsStoreCompleter.future;

  sl.registerSingleton<BankStore>(
    BankStore(
      bankRepository: sl<BankRepository>(),
    )..getBanks(),
  );

  sl.registerSingleton<BankCardStore>(
    BankCardStore(
      bankCardRepository: sl<BankCardRepository>(),
    )..getBankCards(),
  );
}
