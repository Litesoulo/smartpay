import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../common/router/app_router.dart';
import '../model/repository/bank_card_repository.dart';
import '../model/repository/bank_repository.dart';
import '../model/repository/settings_repository.dart';
import '../view_model/bank_card/bank_card_store.dart';
import '../view_model/bank_card/bank_store.dart';
import '../view_model/settings/settings_store.dart';

part '_setup_model.dart';
part '_setup_view.dart';
part '_setup_view_model.dart';

final sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  await _setupModel();
  await _setupView();
  await _setupViewModel();
}
