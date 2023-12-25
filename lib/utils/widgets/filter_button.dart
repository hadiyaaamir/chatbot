import 'package:flutter/material.dart';

class FilterButton extends StatelessWidget {
  const FilterButton({
    super.key,
    required this.isSelected,
    required this.label,
    required this.onPressed,
  });

  final String label;
  final bool isSelected;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor:
              isSelected ? colorScheme.secondary : colorScheme.primaryContainer,
          foregroundColor: isSelected
              ? colorScheme.onSecondary
              : colorScheme.onPrimaryContainer,
        ),
        child: Text(label),
      ),
    );
  }
}
