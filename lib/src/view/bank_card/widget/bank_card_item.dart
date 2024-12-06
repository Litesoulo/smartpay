import 'package:flutter/material.dart';

import '../../../common/extensions/extensions.dart';
import '../../../model/entity/bank_card_entity.dart';

class BankCardItem extends StatelessWidget {
  final BankCardEntity bankCard;

  const BankCardItem({
    super.key,
    required this.bankCard,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: context.theme.cardColor,
      title: Text(
        '**** **** **** ${bankCard.cardNumber.split(' ').last}',
        style: context.textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            bankCard.surnameName,
            style: context.textTheme.titleMedium,
          ),
          Text(
            bankCard.expirationDate,
            style: context.textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}
