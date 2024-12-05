import 'package:flutter/material.dart';

import '../../../common/constant/app_constants.dart';
import '../../../common/extensions/extensions.dart';

class BankCardItem extends StatelessWidget {
  const BankCardItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: context.theme.cardColor,
      title: Text(
        '**** **** **** 9142',
        style: context.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        'Amanov Aman \t',
        style: context.textTheme.titleSmall,
      ),
      trailing: Container(
        width: 80,
        height: 40,
        decoration: BoxDecoration(
          color: context.colorScheme.primary,
          borderRadius: BorderRadius.circular(AppConstants.borderRadius / 2),
        ),
      ),
    );
  }
}
