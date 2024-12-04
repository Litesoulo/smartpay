import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../generated/strings.g.dart';
import '../../common/constant/app_constants.dart';
import '../../common/extensions/extensions.dart';
import '../../common/widget/space.dart';

part 'widget/__transaction_history_card.dart';

enum TransactionHistoryTypeEnum {
  income,
  outcome;

  String getName(BuildContext context) {
    final locale = context.t.transactionHistory;

    switch (this) {
      case TransactionHistoryTypeEnum.income:
        return locale.incoming;
      case TransactionHistoryTypeEnum.outcome:
        return locale.outcoming;
      default:
        return '';
    }
  }
}

@RoutePage()
class TransactionHistoryScreen extends StatelessWidget {
  const TransactionHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.t.dashboard.transactionHistory,
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: _Tabbar(),
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(AppConstants.padding),
        itemBuilder: (context, index) {
          return _TransactionHistoryCard(
            index: index,
          );
        },
        separatorBuilder: (context, index) => Space.v10,
        itemCount: 3,
      ),
    );
  }
}

class _Tabbar extends StatefulWidget {
  @override
  State<_Tabbar> createState() => _TabbarState();
}

class _TabbarState extends State<_Tabbar> {
  TransactionHistoryTypeEnum current = TransactionHistoryTypeEnum.income;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppConstants.padding),
      child: AnimatedToggleSwitch<TransactionHistoryTypeEnum>.size(
        current: current,
        values: TransactionHistoryTypeEnum.values,
        indicatorSize: const Size.fromHeight(40),
        customIconBuilder: (context, local, global) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                local.value.getName(context),
                style: context.textTheme.labelLarge?.copyWith(
                  color: current == local.value
                      ? context.colorScheme.onPrimary
                      : context.colorScheme.onSurface,
                ),
              ),
            ],
          );
        },
        selectedIconScale: 1.2,
        style: ToggleStyle(
          borderColor: Colors.transparent,
          indicatorColor: context.colorScheme.primary,
          backgroundColor: context.theme.cardColor,
        ),
        borderWidth: AppConstants.padding / 2,
        onChanged: (value) => setState(
          () => current = value,
        ),
      ),
    );
  }
}
