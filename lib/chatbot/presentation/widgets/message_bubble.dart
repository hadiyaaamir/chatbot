import 'package:audio_manager/audio_manager.dart';
import 'package:chatbot/chatbot/chatbot.dart';
import 'package:chatbot/utils/constants.dart';
import 'package:chatbot/utils/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

part 'audio_message.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({super.key, required this.message});

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatbotBloc, ChatbotState>(
      builder: (context, state) {
        return message.sentMessage
            ? _SentMessageBubble(message: message)
            : Column(
                children: [
                  _ReceivedMessageBubble(message: message),
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
      bubbleColor: Theme.of(context).colorScheme.inversePrimary,
      textColor: Colors.black,
      paddingLeft: kMessageBubbleStartPadding,
      paddingRight: kMessageBubbleEndPadding,
      borderRadiusRight: kBubbleBorderRadius,
      borderRadiusLeft: kBubbleSharpBorderRadius,
      mainAxisAlignment: MainAxisAlignment.start,
    );
  }
}

class _SentMessageBubble extends StatelessWidget {
  const _SentMessageBubble({required this.message});

  final ChatMessage? message;

  @override
  Widget build(BuildContext context) {
    return _Bubble(
      bubbleColor: Theme.of(context).colorScheme.primary,
      textColor: Theme.of(context).colorScheme.onPrimary,
      paddingLeft: kMessageBubbleEndPadding,
      paddingRight: kMessageBubbleStartPadding,
      borderRadiusRight: kBubbleSharpBorderRadius,
      borderRadiusLeft: kBubbleBorderRadius,
      mainAxisAlignment: MainAxisAlignment.end,
      message: message,
    );
  }
}

class _ReceivedMessageBubble extends StatelessWidget {
  const _ReceivedMessageBubble({required this.message});

  final ChatMessage? message;

  @override
  Widget build(BuildContext context) {
    return _Bubble(
      bubbleColor: Theme.of(context).colorScheme.inversePrimary,
      textColor: Theme.of(context).colorScheme.onBackground,
      paddingLeft: kMessageBubbleStartPadding,
      paddingRight: kMessageBubbleEndPadding,
      borderRadiusRight: kBubbleBorderRadius,
      borderRadiusLeft: kBubbleSharpBorderRadius,
      mainAxisAlignment: MainAxisAlignment.start,
      message: message,
    );
  }
}

class _Bubble extends StatelessWidget {
  const _Bubble({
    required this.bubbleColor,
    required this.textColor,
    required this.paddingLeft,
    required this.paddingRight,
    required this.borderRadiusRight,
    required this.borderRadiusLeft,
    required this.mainAxisAlignment,
    this.message,
  });

  final Color bubbleColor;
  final Color textColor;

  final double paddingLeft;
  final double paddingRight;
  final double borderRadiusRight;
  final double borderRadiusLeft;
  final MainAxisAlignment mainAxisAlignment;

  final ChatMessage? message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(paddingLeft, 5, paddingRight, 5),
      child: Row(
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _TextRectangle(
            message: message,
            borderRadiusRight: borderRadiusRight,
            borderRadiusLeft: borderRadiusLeft,
            backgroundColor: bubbleColor,
            textColor: textColor,
          ),
        ],
      ),
    );
  }
}

class _TextRectangle extends StatelessWidget {
  const _TextRectangle({
    this.message,
    required this.borderRadiusRight,
    required this.borderRadiusLeft,
    required this.backgroundColor,
    required this.textColor,
  });

  final ChatMessage? message;

  final double borderRadiusRight;
  final double borderRadiusLeft;

  final Color backgroundColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    const double borderRadius = 15;

    return Flexible(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(borderRadiusLeft),
            // sentMessage ? const Radius.circular(borderRadius) : Radius.zero,
            topRight: Radius.circular(borderRadiusRight),
            // sentMessage ? Radius.zero : const Radius.circular(borderRadius),
            bottomLeft: const Radius.circular(borderRadius),
            bottomRight: const Radius.circular(borderRadius),
          ),
        ),
        child: message != null
            ? message!.message.isTextMessage
                ? _TextMessage(message: message!.message, textColor: textColor)
                : _AudioMessage(message: message!.message)
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [CustomProgessIndicator(color: textColor)],
              ),
      ),
    );
  }
}

class _TextMessage extends StatelessWidget {
  const _TextMessage({
    required this.message,
    required this.textColor,
  });

  final MessagePayload message;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          message.displayText ?? message.text,
          style: TextStyle(color: textColor),
        ),
        if (message.urlText != null)
          GestureDetector(
            child: Text(
              'Event Directions',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                    decoration: TextDecoration.underline,
                    decorationColor: Theme.of(context).colorScheme.secondary,
                  ),
            ),
            onTap: () => launchUrl(Uri.parse(message.urlText!)),
          ),
      ],
    );
  }
}
