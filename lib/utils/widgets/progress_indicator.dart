import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CustomProgessIndicator extends StatelessWidget {
  const CustomProgessIndicator({super.key, this.color});

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SpinKitThreeBounce(
      size: 12,
      color: color ?? Theme.of(context).colorScheme.secondary,
    );
  }
}
