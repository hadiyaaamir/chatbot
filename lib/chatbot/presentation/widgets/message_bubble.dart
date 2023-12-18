import 'package:chatbot/chatbot/chatbot.dart';
import 'package:chatbot/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:url_launcher/url_launcher.dart';

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
                textColor: Theme.of(context).colorScheme.onPrimary,
                paddingLeft: kMessageBubbleEndPadding,
                paddingRight: kMessageBubbleStartPadding,
                mainAxisAlignment: MainAxisAlignment.end,
                message: message,
                sentMessage: message.sentMessage,
              )
            : Column(
                children: [
                  _Bubble(
                    bubbleColor: Theme.of(context).colorScheme.inversePrimary,
                    textColor: Theme.of(context).colorScheme.onBackground,
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
      bubbleColor: Theme.of(context).colorScheme.inversePrimary,
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
          _TextRectangle(
            message: message,
            sentMessage: sentMessage,
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
    const double borderRadius = 15;

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
                ? _TextMessage(message: message!.message, textColor: textColor)
                : _AudioMessage(message: message!.message)
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

class _AudioMessage extends StatelessWidget {
  const _AudioMessage({required this.message});

  final MessagePayload message;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.read<ChatbotBloc>().add(
            message.audio!.isPlaying
                ? ChatbotAudioMessageStopped(message: message)
                : ChatbotAudioMessagePlayed(message: message),
          ),
      child: Icon(
        message.audio!.isPlaying ? Icons.pause : Icons.play_arrow,
        color: Theme.of(context).colorScheme.onPrimary,
        size: Theme.of(context).textTheme.bodyLarge?.fontSize,
      ),
    );
  }
}
