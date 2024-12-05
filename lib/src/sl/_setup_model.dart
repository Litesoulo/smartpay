part of 'sl.dart';

Future<void> _setupModel() async {
  final prefs = await SharedPreferences.getInstance();

  sl.registerSingleton<SettingsRepository>(
    SettingsRepositoryImpl(prefs: prefs),
  );

  sl.registerSingleton<BankRepository>(
    MockBankRepository(),
  );

  sl.registerSingleton<BankCardRepository>(
    BankCardRepositoryImpl(prefs: prefs),
  );
}
