// // ignore_for_file: prefer_const_constructors

// import 'package:flutter_test/flutter_test.dart';
// import 'package:chatbot/chatbot/chatbot.dart';

// void main() {
//   group('ChatbotState', () {
//     group('supports value equality', () {
//       test('when comparing two default objects', () {
//         expect(ChatbotState(), equals(ChatbotState()));
//       });
//       test('when comparing two objects with the same values', () {
//         expect(
//           ChatbotState(customProperty: 'property'),
//           equals(ChatbotState(customProperty: 'property')),
//         );
//       });
//       test('when comparing two objects with different values', () {
//         expect(
//           ChatbotState(customProperty: 'one'),
//           isNot(equals(ChatbotState(customProperty: 'two'))),
//         );
//       });
//     });

//     group('constructor', () {
//       test('can be instantiated', () {
//         expect(const ChatbotState(), isNotNull);
//       });
//     });

//     group('copyWith', () {
//       test('copies correctly when no argument specified', () {
//         const oldState = ChatbotState(customProperty: 'property');
//         final result = oldState.copyWith();
//         expect(oldState.customProperty, equals(result.customProperty));
//       });

//       test('copies correctly when all arguments specified', () {
//         final oldState = ChatbotState(customProperty: 'one');
//         final newState = ChatbotState(customProperty: 'two');

//         final result = oldState.copyWith(
//           customProperty: newState.customProperty,
//         );

//         expect(result.customProperty, equals(newState.customProperty));
//       });
//     });
//   });
// }
