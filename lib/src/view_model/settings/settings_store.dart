import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';

import '../../../../generated/strings.g.dart';
import '../../model/entity/settings_entity.dart';
import '../../model/repository/settings_repository.dart';

part '../../../generated/src/view_model/settings/settings_store.g.dart';

class SettingsStore = _SettingsStoreBase with _$SettingsStore;

abstract class _SettingsStoreBase with Store {
  final SettingsRepository _settingsRepository;
  final Completer<void> _initCompleter;

  _SettingsStoreBase({
    required SettingsRepository settingsRepository,
    required Completer<void> initCompleter,
  })  : _settingsRepository = settingsRepository,
        _initCompleter = initCompleter {
    _init();
  }

  @observable
  late SettingsEntity settings;

  _init() async {
    settings = await _settingsRepository.settings;

    // Set up locale-related functionality
    LocaleSettings.getLocaleStream().listen(
      (event) {
        Intl.defaultLocale = event.flutterLocale.toLanguageTag();
      },
    );

    LocaleSettings.setLocale(settings.locale);

    _initCompleter.complete();
  }

  @action
  Future<void> setThemeMode(ThemeMode themeMode) async {
    settings = settings.copyWith(themeMode: themeMode);
    await _settingsRepository.saveSettings(settings);
  }

  @action
  Future<void> setLocale(AppLocale? locale) async {
    if (locale == null) return;

    settings = settings.copyWith(locale: locale);
    LocaleSettings.setLocale(locale);

    await _settingsRepository.saveSettings(settings);
  }
}
