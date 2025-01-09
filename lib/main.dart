import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kitsunee_flutter/constants/constants.dart';
import 'package:kitsunee_flutter/navigation/stack_navigation.dart';
import 'package:kitsunee_flutter/providers/theme_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  await dotenv.load();

  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      title: 'Kitsunee Flutter',
      theme: themeProvider.isDarkMode ? darkTheme : lightTheme,
      home: const StackNavigation(),
    );
  }
}
