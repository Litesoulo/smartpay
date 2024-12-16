import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:smartpay/src/model/entity/payment_entity.dart';

import '../../../generated/strings.g.dart';
import '../../common/constant/app_constants.dart';
import '../../common/extensions/extensions.dart';
import '../../common/widget/space.dart';
import '../../sl/sl.dart';
import '../payment/store/payment_store.dart';

part 'widget/__transaction_history_card.dart';

enum TransactionTypeEnum {
  income,
  outcome;

  String getName(BuildContext context) {
    final locale = context.t.transactionHistory;

    switch (this) {
      case TransactionTypeEnum.income:
        return locale.incoming;
      case TransactionTypeEnum.outcome:
        return locale.outcoming;
      default:
        return '';
    }
  }
}

@RoutePage()
class TransactionHistoryScreen extends StatefulWidget {
  const TransactionHistoryScreen({super.key});

  @override
  State<TransactionHistoryScreen> createState() => _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen> {
  @override
  void initState() {
    sl<PaymentStore>().getPayments();

    super.initState();
  }

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
      body: RefreshIndicator(
        onRefresh: () async {
          sl<PaymentStore>().getPayments();
        },
        child: Observer(builder: (_) {
          final transactionsFuture = sl<PaymentStore>().paymentsFuture;
          final transactions = sl<PaymentStore>().paymentsList;

          if (transactionsFuture.status == FutureStatus.pending) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(AppConstants.padding),
            itemCount: transactions.length,
            separatorBuilder: (context, index) => Space.v10,
            itemBuilder: (context, index) {
              final transaction = transactions[index];

              return _TransactionHistoryCard(
                paymentEntity: transaction,
              );
            },
          );
        }),
      ),
    );
  }
}

class _Tabbar extends StatefulWidget {
  @override
  State<_Tabbar> createState() => _TabbarState();
}

class _TabbarState extends State<_Tabbar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppConstants.padding),
      child: Observer(builder: (context) {
        final current = sl<PaymentStore>().type;

        return AnimatedToggleSwitch<TransactionTypeEnum>.size(
          current: current,
          values: TransactionTypeEnum.values,
          indicatorSize: const Size.fromHeight(40),
          customIconBuilder: (context, local, global) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  local.value.getName(context),
                  style: context.textTheme.labelLarge?.copyWith(
                    color: current == local.value ? context.colorScheme.onPrimary : context.colorScheme.onSurface,
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
          onChanged: (value) => sl<PaymentStore>().setTransactionType(value),
        );
      }),
    );
  }
}
