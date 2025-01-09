import 'package:flutter/material.dart';
import 'dart:io' show Platform;

class LayoutWrapper extends StatelessWidget {
  final Widget child;

  const LayoutWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Platform.isIOS
          ? EdgeInsets.only(
              top: MediaQuery.of(context).padding.top - 60,
            )
          : EdgeInsets.zero,
      child: child,
    );
  }
}
