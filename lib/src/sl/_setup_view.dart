part of 'sl.dart';

Future<void> _setupView() async {
  sl.registerSingleton<AppRouter>(
    AppRouter(),
  );
}
