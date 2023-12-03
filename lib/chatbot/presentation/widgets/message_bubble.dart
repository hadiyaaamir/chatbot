import 'dart:math';

import 'package:chatbot/audio/audio.dart';
import 'package:chatbot/chatbot/chatbot.dart';
import 'package:chatbot/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({super.key, required this.message});

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatbotBloc, ChatbotState>(
      builder: (context, state) {
        return message.sentMessage
            ? _Bubble(
                bubbleColor: Theme.of(context).colorScheme.primary,
                textColor: Colors.white,
                paddingLeft: kMessageBubbleEndPadding,
                paddingRight: kMessageBubbleStartPadding,
                mainAxisAlignment: MainAxisAlignment.end,
                message: message,
                sentMessage: message.sentMessage,
              )
            : Column(
                children: [
                  _Bubble(
                    bubbleColor: Theme.of(context).colorScheme.primaryContainer,
                    textColor: Colors.black,
                    paddingLeft: kMessageBubbleStartPadding,
                    paddingRight: kMessageBubbleEndPadding,
                    mainAxisAlignment: MainAxisAlignment.start,
                    message: message,
                    sentMessage: message.sentMessage,
                  ),
                  OptionTiles(
                    options: message.message.options,
                    usernameRequired: message.message.requireUsername,
                  ),
                ],
              );
      },
    );
  }
}

class LoadingMessageBubble extends StatelessWidget {
  const LoadingMessageBubble({super.key});

  @override
  Widget build(BuildContext context) {
    return _Bubble(
      bubbleColor: Theme.of(context).colorScheme.primaryContainer,
      textColor: Colors.black,
      paddingLeft: kMessageBubbleStartPadding,
      paddingRight: kMessageBubbleEndPadding,
      mainAxisAlignment: MainAxisAlignment.start,
      sentMessage: false,
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
    this.message,
    required this.sentMessage,
  });

  final Color bubbleColor;
  final Color textColor;

  final double paddingLeft;
  final double paddingRight;
  final MainAxisAlignment mainAxisAlignment;

  final ChatMessage? message;
  final bool sentMessage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(paddingLeft, 5, paddingRight, 5),
      child: Row(
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!sentMessage)
            Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(pi),
              child: CustomPaint(painter: _Triangle(color: bubbleColor)),
            ),
          _TextRectangle(
            message: message,
            sentMessage: sentMessage,
            backgroundColor: bubbleColor,
            textColor: textColor,
          ),
          if (sentMessage) CustomPaint(painter: _Triangle(color: bubbleColor)),
        ],
      ),
    );
  }
}

class _TextRectangle extends StatelessWidget {
  const _TextRectangle({
    this.message,
    required this.sentMessage,
    required this.backgroundColor,
    required this.textColor,
  });

  final ChatMessage? message;
  final bool sentMessage;
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
            topLeft:
                sentMessage ? const Radius.circular(borderRadius) : Radius.zero,
            topRight:
                sentMessage ? Radius.zero : const Radius.circular(borderRadius),
            bottomLeft: const Radius.circular(borderRadius),
            bottomRight: const Radius.circular(borderRadius),
          ),
        ),
        child: message != null
            ? message!.message.isTextMessage
                ? Text(
                    message!.message.displayText ?? message!.message.text,
                    style: TextStyle(color: textColor),
                  )
                : _AudioMessage(path: message!.message.audio!)
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SpinKitThreeBounce(size: 12, color: textColor),
                ],
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

class _AudioMessage extends StatelessWidget {
  const _AudioMessage({required this.path});

  final String path;

  @override
  Widget build(BuildContext context) {
    final audioManager = context.read<AudioManager>();
    return GestureDetector(
      onTap: () => audioManager.playAudioFromFile(path),
      child: const Icon(Icons.play_arrow),
    );
  }
}
