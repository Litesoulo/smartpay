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
            DateFormat('dd MMMM yyyy hh:mm').format(paymentEntity.date ?? DateTime(2024)).capitalizeAll(),
            style: context.textTheme.labelSmall,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  paymentEntity.isSuccess ? context.t.success : context.t.fail,
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
