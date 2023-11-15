// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:chatbot/chatbot/chatbot.dart';

void main() {
  group('ChatbotEvent', () {
    group('ChatbotCustomEvent', () {
      group('supports value equality', () {
        test('when comparing two objects with the same values', () {
          expect(
            ChatbotCustomEvent(property: 'default'),
            equals(ChatbotCustomEvent(property: 'default')),
          );
        });
        test('when comparing two nonequal objects', () {
          expect(
            ChatbotCustomEvent(property: 'one'),
            isNot(equals(ChatbotCustomEvent(property: 'two'))),
          );
        });
      });
    });
    group('constructor', () {
      test('can be instantiated', () {
        expect(const ChatbotCustomEvent(property: 'default'), isNotNull);
      });
    });
  });
}
