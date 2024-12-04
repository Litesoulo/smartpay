import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:turkmen_localization_support/turkmen_localization_support.dart';

import '../../common/router/app_router.dart';
import '../../sl/sl.dart';

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      // Localization
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        ...TkDelegates.delegates,
      ],

      // Debug
      debugShowCheckedModeBanner: false,

      routerConfig: sl<AppRouter>().config(),
    );
  }
}
