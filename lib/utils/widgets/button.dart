import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.backgroundColor,
    this.foregroundColor,
    this.outlineColor,
  });

  final String label;
  final Function()? onPressed;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? outlineColor;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 40),
        shape: RoundedRectangleBorder(
          side: outlineColor == null
              ? BorderSide.none
              : BorderSide(color: outlineColor!),
          borderRadius: BorderRadius.circular(12),
        ),
        backgroundColor: backgroundColor ?? colorScheme.primaryContainer,
        foregroundColor: foregroundColor ?? colorScheme.onPrimaryContainer,
        surfaceTintColor: Colors.transparent,
      ),
      onPressed: onPressed,
      child: Text(label),
    );
  }
}
