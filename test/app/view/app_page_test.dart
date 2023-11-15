// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:chatbot/app/app.dart';

void main() {
  group('AppPage', () {
    testWidgets('renders AppView', (tester) async {
      await tester.pumpWidget(MaterialApp(home: AppPage()));
      expect(find.byType(AppView), findsOneWidget);
    });
  });
}
