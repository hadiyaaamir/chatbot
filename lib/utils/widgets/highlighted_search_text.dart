import 'package:flutter/material.dart';

class HighlightedSearchText extends StatelessWidget {
  const HighlightedSearchText({
    super.key,
    required this.child,
    required this.searchText,
  });

  final Text child;
  final String searchText;

  @override
  Widget build(BuildContext context) {
    final String text = child.data!;
    final TextStyle? normalStyle = child.style;
    final TextStyle? highlightStyle = normalStyle?.copyWith(
      color: Theme.of(context).colorScheme.primary,
    );

    List<TextSpan> textSpans = _buildTextSpans(
      text: text,
      highlightStyle: highlightStyle,
      normalStyle: normalStyle,
    );

    return RichText(text: TextSpan(children: textSpans));
  }

  List<TextSpan> _buildTextSpans(
      {required String text,
      required TextStyle? normalStyle,
      required TextStyle? highlightStyle}) {
    List<TextSpan> textSpans = [];

    if (searchText.isEmpty || text.isEmpty) {
      textSpans.add(TextSpan(text: text, style: normalStyle));
      return textSpans;
    }

    String lowerCaseText = text.toLowerCase();
    String lowerCaseSearchText = searchText.toLowerCase();
    int index = lowerCaseText.indexOf(lowerCaseSearchText);
    int lastIndex = 0;

    while (index != -1) {
      // Add normal text before the match
      if (index > lastIndex) {
        textSpans.add(
          TextSpan(text: text.substring(lastIndex, index), style: normalStyle),
        );
      }

      // Add highlighted match
      textSpans.add(
        TextSpan(
          text: text.substring(index, index + searchText.length),
          style: highlightStyle,
        ),
      );

      lastIndex = index + searchText.length;
      index = lowerCaseText.indexOf(lowerCaseSearchText, lastIndex);
    }

    // Add the remaining normal text after the last match
    if (lastIndex < text.length) {
      textSpans.add(
        TextSpan(text: text.substring(lastIndex), style: normalStyle),
      );
    }

    return textSpans;
  }
}
