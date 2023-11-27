import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';

class DottedDivider extends StatelessWidget {
  const DottedDivider({super.key, this.spaceAbove = 0, this.spaceBelow = 0});

  final double spaceAbove;
  final double spaceBelow;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          SizedBox(height: spaceAbove),
          DottedLine(
            dashColor: Theme.of(context).colorScheme.outlineVariant,
            dashGapLength: 5,
          ),
          SizedBox(height: spaceBelow),
        ],
      ),
    );
  }
}
