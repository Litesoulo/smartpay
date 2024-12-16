part of '../transaction_history_screen.dart';

class _TransactionHistoryCard extends StatelessWidget {
  final PaymentEntity paymentEntity;

  const _TransactionHistoryCard({required this.paymentEntity});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: context.theme.cardColor,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            paymentEntity.bankIdentifier,
            style: context.textTheme.labelLarge,
          ),
          Text(
            '${paymentEntity.amount.toStringAsFixed(2)} TMT',
            style: context.textTheme.labelLarge,
          ),
        ],
      ),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '21 Ноября 2023 г. 13:30',
            style: context.textTheme.labelSmall,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  paymentEntity.isSuccess ? 'успешно' : 'неудачно',
                  style: context.textTheme.labelSmall,
                ),
                Space.h5,
                Icon(
                  Icons.circle,
                  size: 12,
                  color: paymentEntity.isSuccess ? context.colorScheme.primary : context.colorScheme.error,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
