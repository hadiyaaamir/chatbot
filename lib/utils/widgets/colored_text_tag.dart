import 'package:flutter/material.dart';

class ColoredTextTag extends StatelessWidget {
  const ColoredTextTag({
    super.key,
    required this.text,
    this.backgroundColor,
    this.foregroundColor,
  });

  final String text;
  final Color? backgroundColor;
  final Color? foregroundColor;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: backgroundColor ?? colorScheme.secondaryContainer,
      ),
      child: Text(
        text,
        style: textTheme.bodyMedium?.copyWith(
          color: foregroundColor ?? colorScheme.primary,
        ),
      ),
    );
  }
}
