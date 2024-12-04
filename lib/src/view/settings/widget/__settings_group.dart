part of '../settings_screen.dart';

class _SettingsGroup extends StatelessWidget {
  final List<Widget> items;

  const _SettingsGroup({
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: context.theme.cardColor,
      margin: EdgeInsets.zero,
      child: Column(
        children: [
          ...items.expand(
            (e) => [
              if (items.length == 1) Space.v5,
              e,
              if (items.last != e)
                Divider(
                  color: context.colorScheme.onSurface.withOpacity(0.2),
                )
              else
                Space.v5,
            ],
          )
        ],
      ),
    );
  }
}
