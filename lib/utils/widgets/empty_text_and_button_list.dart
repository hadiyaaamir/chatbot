import 'package:flutter/material.dart';

class EmptyTextAndButtonList extends StatelessWidget {
  const EmptyTextAndButtonList({
    super.key,
    required this.text,
    required this.button,
  });

  final String text;
  final Widget button;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(text),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Flexible(flex: 1, child: SizedBox(width: 0)),
            Flexible(
              flex: 2,
              child: Padding(padding: const EdgeInsets.all(10), child: button),
            ),
            const Flexible(flex: 1, child: SizedBox(width: 0)),
          ],
        ),
      ],
    );
  }
}
