import 'package:flutter/material.dart';
import 'package:ishara/core/utils/styles.dart';

class SettingsOptions extends StatelessWidget {
  SettingsOptions({super.key, required this.icon, required this.title});
  IconData icon;
  String title;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      height: 50,
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(10),
        border:
            Border.all(color: theme.dividerColor.withOpacity(0.7), width: 1.2),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(icon, size: 24, color: theme.colorScheme.primary),
          Text(
            title,
            style: theme.textTheme.bodyLarge?.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: theme.colorScheme.onSurface,
            ),
          ),
          Icon(Icons.arrow_forward_ios,
              size: 24, color: theme.colorScheme.primary),
        ],
      ),
    );
  }
}
