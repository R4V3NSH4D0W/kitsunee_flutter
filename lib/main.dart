import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kitsunee_flutter/navigation/stack_navigation.dart';

void main() async {
  // Ensure widgets are initialized before loading .env
  await dotenv.load(); // Load the .env file

  // Check if BASE_URL is loaded
  String? baseUrl = dotenv.env['BASE_URL'];
  if (baseUrl != null) {
    print('BASE_URL loaded: $baseUrl');
  } else {
    print('Failed to load BASE_URL');
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kitsunee Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const StackNavigation(),
    );
  }
}
