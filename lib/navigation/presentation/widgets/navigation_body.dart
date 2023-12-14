import 'package:flutter/material.dart';
import 'package:chatbot/navigation/navigation.dart';

class NavigationBody extends StatelessWidget {
  const NavigationBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, state) {
        return Center(child: Text(state.customProperty));
      },
    );
  }
}
