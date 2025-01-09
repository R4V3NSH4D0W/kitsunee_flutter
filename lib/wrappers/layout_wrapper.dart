import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kitsunee_flutter/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class LayoutWrapper extends StatelessWidget {
  final Widget child;

  const LayoutWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final backgroundColor = Provider.of<ThemeProvider>(context).backgroundColor;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Padding(
        padding: Platform.isIOS
            ? EdgeInsets.only(
                top: MediaQuery.of(context).padding.top - 60,
              )
            : EdgeInsets.zero,
        child: child,
      ),
    );
  }
}
