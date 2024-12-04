import 'package:auto_route/auto_route.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../generated/strings.g.dart';
import '../../common/constant/app_constants.dart';
import '../../common/extensions/extensions.dart';
import '../../common/widget/space.dart';
import '../../sl/sl.dart';
import '../../view_model/settings/settings_store.dart';

part 'widget/__app_settings_group.dart';
part 'widget/__settings_group.dart';
part 'widget/__settings_item.dart';

@RoutePage()
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.t.dashboard.settings,
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppConstants.padding),
          children: [
            ...[
              _AppSettingsGroup(),
              _SettingsGroup(
                items: [
                  _SettingsItem(
                    leading: const Icon(CupertinoIcons.info_circle),
                    title: context.t.settings.aboutApp,
                  ),
                ],
              ),
            ].expand(
              (element) => [
                element,
                Space.v20,
              ],
            )
          ],
        ),
      ),
    );
  }
}
