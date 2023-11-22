import 'dart:math';

import 'package:chatbot/chatbot/chatbot.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({super.key, required this.message});

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatbotBloc, ChatbotState>(
      builder: (context, state) {
        const double startPadding = 0;
        const double endPadding = 60;

        return Column(
          children: [
            message.sentMessage
                ? _Bubble(
                    bubbleColor: Theme.of(context).colorScheme.primary,
                    textColor: Colors.white,
                    paddingLeft: endPadding,
                    paddingRight: startPadding,
                    mainAxisAlignment: MainAxisAlignment.end,
                    message: message,
                  )
                : _Bubble(
                    bubbleColor: Theme.of(context).colorScheme.primaryContainer,
                    textColor: Colors.black,
                    paddingLeft: startPadding,
                    paddingRight: endPadding,
                    mainAxisAlignment: MainAxisAlignment.start,
                    message: message,
                  ),
            OptionTiles(options: message.message.options),
          ],
        );
      },
    );
  }
}

class _Bubble extends StatelessWidget {
  const _Bubble({
    required this.bubbleColor,
    required this.textColor,
    required this.paddingLeft,
    required this.paddingRight,
    required this.mainAxisAlignment,
    required this.message,
  });

  final Color bubbleColor;
  final Color textColor;

  final double paddingLeft;
  final double paddingRight;
  final MainAxisAlignment mainAxisAlignment;

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(paddingLeft, 5, paddingRight, 5),
      child: Row(
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!message.sentMessage)
            Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(pi),
              child: CustomPaint(painter: _Triangle(color: bubbleColor)),
            ),
          _TextRectangle(
            message: message,
            backgroundColor: bubbleColor,
            textColor: textColor,
          ),
          if (message.sentMessage)
            CustomPaint(painter: _Triangle(color: bubbleColor)),
        ],
      ),
    );
  }
}

class _TextRectangle extends StatelessWidget {
  const _TextRectangle({
    required this.message,
    required this.backgroundColor,
    required this.textColor,
  });

  final ChatMessage message;
  final Color backgroundColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    const double borderRadius = 14;

    return Flexible(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.only(
            topLeft: message.sentMessage
                ? const Radius.circular(borderRadius)
                : Radius.zero,
            topRight: message.sentMessage
                ? Radius.zero
                : const Radius.circular(borderRadius),
            bottomLeft: const Radius.circular(borderRadius),
            bottomRight: const Radius.circular(borderRadius),
          ),
        ),
        child: Text(
          message.message.displayText ?? message.message.text,
          style: TextStyle(color: textColor),
        ),
      ),
    );
  }
}

class _Triangle extends CustomPainter {
  final Color color;

  _Triangle({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()..color = color;

    var path = Path();
    path.lineTo(-5, 0);
    path.lineTo(0, 10);
    path.lineTo(5, 0);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
