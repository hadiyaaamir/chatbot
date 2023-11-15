// // ignore_for_file: prefer_const_constructors

// import 'package:bloc_test/bloc_test.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:chatbot/chatbot/chatbot.dart';

// void main() {
//   group('ChatbotBloc', () {
//     group('constructor', () {
//       test('can be instantiated', () {
//         expect(ChatbotBloc(), isNotNull);
//       });
//     });

//     test('initial state has default values', () {
//       final chatbotBloc = ChatbotBloc();
//       expect(chatbotBloc.state.customProperty, equals('Default Value'));
//     });

//     group('ChatbotCustomEvent', () {
//       blocTest<ChatbotBloc, ChatbotState>(
//         'emits nothing',
//         build: ChatbotBloc.new,
//         act: (bloc) => bloc.add(const ChatbotCustomEvent(property: '')),
//         expect: () => <ChatbotState>[],
//       );
//     });
//   });
// }
