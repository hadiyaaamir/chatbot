// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:chatbot/chatbot/chatbot.dart';


void main() {
  group('ChatbotPage', () {
    group('route', () {
      test('is routable', () {
        expect(ChatbotPage.route(), isA<MaterialPageRoute<dynamic>>());
      });
    });

    testWidgets('renders ChatbotView', (tester) async {
      await tester.pumpWidget(MaterialApp(home: ChatbotPage()));
      expect(find.byType(ChatbotView), findsOneWidget);
    });
  });
}
