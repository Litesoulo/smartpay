import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../generated/strings.g.dart';
import '../../common/constant/app_constants.dart';
import '../../common/widget/space.dart';
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
            onPressed: () {},
            icon: const Icon(
              CupertinoIcons.plus,
            ),
          ),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(AppConstants.padding),
        separatorBuilder: (context, index) => Space.v10,
        itemCount: 3,
        itemBuilder: (context, index) {
          return const BankCardItem();
        },
      ),
    );
  }
}
