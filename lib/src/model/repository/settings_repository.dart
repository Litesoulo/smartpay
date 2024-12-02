import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../entity/settings_entity.dart';

abstract class SettingsRepository {
  Future<SettingsEntity> get settings;
  Future<void> saveSettings(SettingsEntity settings);
}

class SettingsRepositoryImpl implements SettingsRepository {
  static const _settingsKey = 'settings_key';

  final SharedPreferences _prefs;

  SettingsRepositoryImpl({
    required SharedPreferences prefs,
  }) : _prefs = prefs;

  @override
  Future<SettingsEntity> get settings async {
    final jsonString = _prefs.getString(_settingsKey);
    if (jsonString == null) {
      return SettingsEntity.defaultSettings();
    }
    final json = jsonDecode(jsonString) as Map<String, dynamic>;
    return SettingsEntity.fromJson(json);
  }

  @override
  Future<void> saveSettings(SettingsEntity settings) async {
    final jsonString = jsonEncode(settings.toJson());
    await _prefs.setString(_settingsKey, jsonString);
  }
}
