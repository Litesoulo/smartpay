part of '../transaction_history_screen.dart';

class _TransactionHistoryCard extends StatelessWidget {
  final int index;

  const _TransactionHistoryCard({required this.index});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: context.theme.cardColor,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Внеш эконом банк',
            style: context.textTheme.labelLarge,
          ),
          Text(
            '200 TMT',
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
                  index == 0 ? 'неудачно' : 'успешно',
                  style: context.textTheme.labelSmall,
                ),
                Space.h5,
                Icon(
                  Icons.circle,
                  size: 12,
                  color: index == 0 ? context.colorScheme.error : context.colorScheme.primary,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
