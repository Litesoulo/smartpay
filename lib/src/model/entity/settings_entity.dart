import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../generated/strings.g.dart';

part '../../../generated/src/model/entity/settings_entity.g.dart';

@JsonSerializable()
class SettingsEntity extends Equatable {
  @JsonKey(fromJson: _themeModeFromJson, toJson: _themeModeToJson)
  final ThemeMode themeMode;

  @JsonKey(fromJson: _localeFromJson, toJson: _localeToJson)
  final AppLocale locale;

  const SettingsEntity({
    required this.themeMode,
    required this.locale,
  });

  /// Default settings for the entity.
  factory SettingsEntity.defaultSettings() => SettingsEntity(
        themeMode: ThemeMode.system,
        locale: LocaleSettings.useDeviceLocaleSync(),
      );

  /// JSON serialization methods.
  factory SettingsEntity.fromJson(Map<String, dynamic> json) =>
      _$SettingsEntityFromJson(json);
  Map<String, dynamic> toJson() => _$SettingsEntityToJson(this);

  /// Creates a new copy of the entity with updated fields.
  SettingsEntity copyWith({
    ThemeMode? themeMode,
    AppLocale? locale,
  }) {
    return SettingsEntity(
      themeMode: themeMode ?? this.themeMode,
      locale: locale ?? this.locale,
    );
  }

  /// Equatable properties for value comparison.
  @override
  List<Object?> get props => [
        themeMode,
        locale,
      ];

  /// Custom JSON converters for ThemeMode.
  static ThemeMode _themeModeFromJson(int value) =>
      ThemeMode.values.elementAt(value);

  static int _themeModeToJson(ThemeMode mode) => mode.index;

  /// Custom JSON converters for Locale.
  static AppLocale _localeFromJson(int index) {
    return AppLocale.values.elementAt(index);
  }

  static int _localeToJson(AppLocale locale) {
    return locale.index;
  }
}
