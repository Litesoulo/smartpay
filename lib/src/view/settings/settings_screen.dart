import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:smartpay/generated/strings.g.dart';
import '../../view_model/settings/settings_store.dart';
import '../../sl/sl.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SettingsStore settingsStore = sl<SettingsStore>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Settings",
        ),
      ),
      body: Observer(
        builder: (_) => Column(
          children: [
            SwitchListTile(
              title: const Text(
                "Dark Mode",
              ),
              value: settingsStore.isDarkMode,
              onChanged: (_) => settingsStore.setThemeMode(
                Theme.of(context).brightness == Brightness.dark
                    ? ThemeMode.light
                    : ThemeMode.light,
              ),
            ),
            DropdownButton<AppLocale>(
              value: settingsStore.settings.locale,
              items: [
                for (final locale in AppLocale.values)
                  DropdownMenuItem(
                    value: locale,
                    child: Text(
                      locale.languageTag,
                    ),
                  ),
              ],
              onChanged: (value) {
                if (value != null) settingsStore.changeLanguage(value);
              },
            ),
          ],
        ),
      ),
    );
  }
}
