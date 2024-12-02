import 'package:mobx/mobx.dart';
import 'package:flutter/material.dart';
import 'package:smartpay/generated/strings.g.dart';

import '../../model/entity/settings_entity.dart';
import '../../model/repository/settings_repository.dart';

part '../../../generated/src/view_model/settings/settings_store.g.dart';

class SettingsStore = _SettingsStore with _$SettingsStore;

abstract class _SettingsStore with Store {
  final SettingsRepository _repository;

  _SettingsStore({
    required SettingsRepository repository,
  }) : _repository = repository;

  @observable
  SettingsEntity settings = SettingsEntity.defaultSettings();

  @action
  Future<void> loadSettings() async {
    final storedSettings = await _repository.settings;
    settings = storedSettings;
  }

  bool get isDarkMode => settings.themeMode == ThemeMode.dark;

  @action
  Future<void> setThemeMode(ThemeMode value) async {
    settings = settings.copyWith(
      themeMode: value,
    );
    await _repository.saveSettings(settings);
  }

  @action
  Future<void> changeLanguage(AppLocale locale) async {
    settings = settings.copyWith(locale: locale);
    await _repository.saveSettings(settings);
  }
}
