import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:smartpay/src/common/router/app_router.gr.dart';
import 'package:smartpay/src/view_model/bank_card/bank_card_store.dart';

import '../../../generated/strings.g.dart';
import '../../common/constant/app_constants.dart';
import '../../common/widget/space.dart';
import '../../sl/sl.dart';
import 'widget/bank_card_item.dart';

@RoutePage()
class BankCardsScreen extends StatelessWidget {
  const BankCardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.t.dashboard.bankCards,
        ),
        actions: [
          IconButton(
            onPressed: () => context.pushRoute(const AddBankCardRoute()),
            icon: const Icon(
              CupertinoIcons.plus,
            ),
          ),
        ],
      ),
      body: Observer(builder: (context) {
        final bankCardsFuture = sl<BankCardStore>().bankCardsFuture;

        if (bankCardsFuture.status == FutureStatus.pending) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final bankCards = sl<BankCardStore>().bankCards;

        return ListView.separated(
          padding: const EdgeInsets.all(AppConstants.padding),
          separatorBuilder: (context, index) => Space.v10,
          itemCount: bankCards.length,
          itemBuilder: (context, index) {
            final bankCard = bankCards[index];

            return BankCardItem(
              bankCard: bankCard,
            );
          },
        );
      }),
    );
  }
}
