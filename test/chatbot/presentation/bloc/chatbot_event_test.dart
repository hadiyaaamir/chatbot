// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:chatbot/chatbot/chatbot.dart';

void main() {
  group('ChatbotEvent', () {
    group('ChatbotCustomEvent', () {
      group('supports value equality', () {
        test('when comparing two objects with the same values', () {
          expect(
            ChatbotMessageSent(message: 'default'),
            equals(ChatbotMessageSent(message: 'default')),
          );
        });
        test('when comparing two nonequal objects', () {
          expect(
            ChatbotMessageSent(message: 'one'),
            isNot(equals(ChatbotMessageSent(message: 'two'))),
          );
        });
      });
    });
    group('constructor', () {
      test('can be instantiated', () {
        expect(const ChatbotMessageSent(message: 'default'), isNotNull);
      });
    });
  });
}
